---
name: ios-coreml-diag
description: "Use for Core ML diagnostics: load failures, slow inference, memory pressure, compression accuracy regressions, and conversion errors."
version: 1.0.0
---

# Core ML Diagnostics

## Quick Triage

| Symptom | First check | Patterns |
|---|---|---|
| Model will not load | deployment target/spec version | 1a-1c |
| First load slow only once | cache miss | 2a |
| Inference always slow | compute-unit placement | 2b-2c |
| Memory growth/OOM | concurrency + model size | 3a-3b |
| Accuracy drop post-compression | granularity/bit depth/calibration | 4a-4c |
| Conversion fails/wrong output | op support + parity checks | 5a-5b |

## Decision Tree

```
Core ML issue
├─ Load failure -> 1a/1b/1c
├─ Performance -> 2a/2b/2c
├─ Memory -> 3a/3b
├─ Accuracy regression -> 4a/4b/4c
└─ Conversion mismatch -> 5a/5b
```

## 1a) Unsupported Model Version

Symptom: load error mentions unsupported model/spec version.

```python
import coremltools as ct
model = ct.models.MLModel("Model.mlpackage")
print(model.get_spec().specificationVersion)
```

| Spec | Min iOS |
|---:|---:|
| 4 | 13 |
| 5 | 14 |
| 6 | 15 |
| 7 | 16 |
| 8 | 17 |
| 9 | 18 |

Fix: reconvert with lower deployment target.

```python
mlmodel = ct.convert(traced, minimum_deployment_target=ct.target.iOS16)
```

Tradeoff: may lose newer optimizations.

## 1b) Failed to Create Compute Plan

Cause: target compute unit cannot support op/precision mix.

Diagnosis:
1. Generate Xcode Performance Report
2. Find unsupported operations/device mapping

Fallback:

```swift
let cfg = MLModelConfiguration()
cfg.computeUnits = .cpuOnly
let model = try MLModel(contentsOf: url, configuration: cfg)
```

Better long-term: adjust conversion precision/op selection.

```python
mlmodel = ct.convert(traced, compute_precision=ct.precision.FLOAT16)
```

## 1c) General Load Failure

Checklist:
- file exists and readable
- runtime loads compiled `.mlmodelc`
- disk space available for caches
- model artifact not corrupted

```swift
let cfg = MLModelConfiguration()
cfg.parameters = [.reporter: { print($0) }] // iOS 17+
```

## 2a) Slow First Load, Fast Later

Cause: specialization cache miss.

Look for Load event labels:
- `prepare and cache`: miss
- `cached`: hit

Miss triggers: first install run, system update, cache eviction, config/path change.

Mitigation:

```swift
Task.detached(priority: .background) {
    _ = try? await MLModel.load(contentsOf: modelURL)
}
```

Cache key includes model path + config + device.

## 2b) Predictions Always Slow

Diagnosis:
- profile compute device distribution
- inspect expensive ops

Common causes and fixes:
- CPU fallback unexpectedly -> set/verify `computeUnits`
- model too large for NE -> compress model
- frequent CPU/GPU/NE transfers -> rebalance segmentation
- dynamic shapes recompiling -> use fixed/enumerated shapes

```swift
let plan = try await MLComputePlan.load(contentsOf: modelURL)
for op in plan.modelStructure.operations {
    let info = plan.computeDeviceInfo(for: op)
    print("\(op.name): \(info.preferredDevice)")
}
```

## 2c) Slow on Specific Device Class

```swift
print(MLModel.availableComputeDevices)
```

Device-specific strategy:
- Mac fast / iPhone slow -> often GPU-oriented model; consider palettization
- iPhone fast / Intel Mac slow -> no NE path; tune for GPU/CPU fallback
- older devices slow -> stronger compression or lighter model

Always profile target hardware.

## 3a) Memory Grows During Prediction

Cause: uncontrolled concurrent predictions + buffer accumulation.

```swift
actor PredictionLimiter {
    private let maxConcurrent = 2
    private var inFlight = 0

    func predict(_ model: MLModel, input: MLFeatureProvider) async throws -> MLFeatureProvider {
        while inFlight >= maxConcurrent { await Task.yield() }
        inFlight += 1
        defer { inFlight -= 1 }
        return try await model.prediction(from: input)
    }
}
```

Use Allocations + Core ML instruments to confirm.

## 3b) OOM on Model Load

```bash
ls -lh Model.mlpackage/Data/com.apple.CoreML/weights/
```

Compression options:

| Method | Typical size/memory effect |
|---|---|
| 8-bit palettization | ~2x smaller |
| 4-bit palettization | ~4x smaller |
| ~50% pruning | ~2x smaller |

iOS 17+ supports just-in-time decompression of compressed weights.

## 4a) Accuracy Drop After Palettization

Fix progression:

```python
config = OpPalettizerConfig(
    nbits=4,
    granularity="per_grouped_channel",
    group_size=16
)
```

Then:
1. increase bits (e.g., 6-bit)
2. add calibration/training-time palettization (`DKMPalettizer`)

## 4b) Accuracy Drop After Quantization

```python
config = OpLinearQuantizerConfig(
    dtype="int4",
    granularity="per_block",
    block_size=32
)
```

Add calibration (`LayerwiseCompressor`).

Note: INT4 is often better on Mac GPU; NE often favors palettization.

## 4c) Accuracy Drop After Pruning

Typical ranges (model-dependent):
- 0-30%: often safe
- 30-50%: may need calibration
- >50%: usually training-time adaptation needed

```python
config = MagnitudePrunerConfig(target_sparsity=0.4, n_samples=128)
```

## 5a) Conversion Fails (Unsupported Op)

1. update `coremltools`
2. replace op with supported composite ops
3. only if needed: register custom op in MIL

```bash
pip install --upgrade coremltools
```

## 5b) Conversion Succeeds but Output Is Wrong

Check parity in this order:
1. preprocessing/normalization
2. shape/layout assumptions (NCHW/NHWC paths)
3. precision mismatch (FP16 vs FP32)
4. model eval mode and stochastic layers disabled

```python
torch_output = model(input).detach().numpy()
coreml_output = mlmodel.predict({"input": input.numpy()})["output"]
print(np.max(np.abs(torch_output - coreml_output)))
```

## Pressure Scenarios

### "Works on simulator, not on device"
- simulator compute stack != device stack
- validate spec version vs device OS
- profile on physical target device

### "Ship now, optimize later"
- do not jump to max compression blindly
- baseline FP16 first
- compress incrementally with accuracy checks

## Diagnostic Checklist

- [ ] deployment target/spec compatible with device OS
- [ ] loading compiled artifact (`.mlmodelc`) at runtime
- [ ] load profile distinguishes cached vs uncached
- [ ] compute-unit placement inspected
- [ ] prediction concurrency bounded
- [ ] compression tuned by granularity/bit-depth/calibration
- [ ] conversion parity validated numerically

## Resources

- WWDC: 2023-10047, 2023-10049, 2024-10159, 2024-10161
- Docs: `/coreml`, `/coreml/mlmodel`
- Skills: `coreml`, `coreml-ref`
