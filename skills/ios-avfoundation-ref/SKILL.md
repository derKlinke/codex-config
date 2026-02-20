---
name: ios-avfoundation-ref
description: Use for AVFoundation audio reference: AVAudioSession categories/modes/options, AVAudioEngine pipelines/taps/conversion, DAC output behavior, and iOS 26+ input/spatial audio features.
license: MIT
metadata:
  version: "1.0.0"
---

# AVFoundation Audio Reference

## Quick Start

```swift
import AVFoundation

try AVAudioSession.sharedInstance().setCategory(
    .playback,
    mode: .default,
    options: [.mixWithOthers, .allowBluetooth]
)
try AVAudioSession.sharedInstance().setActive(true)

let engine = AVAudioEngine()
let player = AVAudioPlayerNode()
engine.attach(player)
engine.connect(player, to: engine.mainMixerNode, format: nil)
try engine.start()
```

## AVAudioSession

### Categories

| Category | Typical use | Silent switch | Background |
|---|---|---|---|
| `.ambient` | non-primary sounds | silenced | no |
| `.soloAmbient` | default ambient | silenced | no |
| `.playback` | music/podcast/video audio | ignored | yes |
| `.record` | capture-only | n/a | yes |
| `.playAndRecord` | call/chat/duplex | ignored | yes |
| `.multiRoute` | advanced multi-output | ignored | yes |

### Modes

| Mode | Typical use |
|---|---|
| `.default` | general |
| `.voiceChat` | VoIP echo control |
| `.videoChat` | FaceTime-like |
| `.gameChat` | game voice |
| `.videoRecording` | camera recording |
| `.measurement` | minimal processing |
| `.moviePlayback` | video playback |
| `.spokenAudio` | spoken-word content |

### Options

- Mixing: `.mixWithOthers`, `.duckOthers`, `.interruptSpokenAudioAndMixWithOthers`
- Bluetooth: `.allowBluetooth`, `.allowBluetoothA2DP`, `.bluetoothHighQualityRecording` (iOS 26+)
- Routing: `.defaultToSpeaker`, `.allowAirPlay`

### Interruption handling

```swift
NotificationCenter.default.addObserver(
    forName: AVAudioSession.interruptionNotification,
    object: nil,
    queue: .main
) { notification in
    guard
        let userInfo = notification.userInfo,
        let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
        let type = AVAudioSession.InterruptionType(rawValue: typeValue)
    else { return }

    switch type {
    case .began:
        player.pause()
    case .ended:
        let optionsValue = (userInfo[AVAudioSessionInterruptionOptionKey] as? UInt) ?? 0
        let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
        if options.contains(.shouldResume) { player.play() }
    @unknown default:
        break
    }
}
```

### Route changes

```swift
NotificationCenter.default.addObserver(
    forName: AVAudioSession.routeChangeNotification,
    object: nil,
    queue: .main
) { notification in
    guard
        let userInfo = notification.userInfo,
        let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
        let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue)
    else { return }

    if reason == .oldDeviceUnavailable {
        player.pause() // e.g., unplugged headphones
    }
}
```

## AVAudioEngine

### Basic graph

```swift
let engine = AVAudioEngine()
let player = AVAudioPlayerNode()
let reverb = AVAudioUnitReverb()
reverb.loadFactoryPreset(.largeHall)
reverb.wetDryMix = 50

engine.attach(player)
engine.attach(reverb)
engine.connect(player, to: reverb, format: nil)
engine.connect(reverb, to: engine.mainMixerNode, format: nil)

engine.prepare()
try engine.start()
```

### Common node roles

| Node | Role |
|---|---|
| `AVAudioPlayerNode` | playback |
| `AVAudioInputNode` | mic input |
| `AVAudioOutputNode` | output endpoint |
| `AVAudioMixerNode` | mixing |
| `AVAudioUnitEQ` / `Reverb` / `Delay` / `Distortion` / `TimePitch` | effects |

### Tap for analysis

```swift
let input = engine.inputNode
let format = input.outputFormat(forBus: 0)

input.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
    guard let ch = buffer.floatChannelData?[0] else { return }
    let n = Int(buffer.frameLength)
    var sum: Float = 0
    for i in 0..<n { sum += ch[i] * ch[i] }
    let rms = sqrt(sum / Float(n))
    let dB = 20 * log10(rms)
    DispatchQueue.main.async { self.levelMeter = dB }
}

input.removeTap(onBus: 0)
```

### Format conversion

```swift
let inputFormat = engine.inputNode.outputFormat(forBus: 0)
let outputFormat = AVAudioFormat(commonFormat: .pcmFormatInt16, sampleRate: 48_000, channels: 1, interleaved: false)!
let converter = AVAudioConverter(from: inputFormat, to: outputFormat)!

let out = AVAudioPCMBuffer(pcmFormat: outputFormat, frameCapacity: AVAudioFrameCount(outputFormat.sampleRate * 0.1))!
var error: NSError?
converter.convert(to: out, error: &error) { _, status in
    status.pointee = .haveData
    return inputBuffer
}
```

## DAC / Bit-Perfect Output

- iOS typically passes source sample rate to compatible USB DACs without forced resampling.
- Match processing graph to hardware rate where possible.

```swift
let hwRate = AVAudioSession.sharedInstance().sampleRate
let format = AVAudioFormat(standardFormatWithSampleRate: hwRate, channels: 2)
```

### Route inspection

```swift
for output in AVAudioSession.sharedInstance().currentRoute.outputs {
    print("Output: \(output.portName), type: \(output.portType)")
}
```

| Source rate | Typical behavior |
|---|---|
| 44.1/48/96/192 kHz | passthrough on compatible path |
| DSD | unsupported directly |

## iOS 26+ Input Selection

### `AVInputPickerInteraction`

```swift
import AVKit

let picker = AVInputPickerInteraction()
picker.delegate = self
button.addInteraction(picker)
// on action: picker.present()
```

Features: system input picker, live levels, per-app remembered selection.

## iOS 26+ AirPods High-Quality Recording

```swift
try AVAudioSession.sharedInstance().setCategory(
    .playAndRecord,
    options: [.bluetoothHighQualityRecording, .allowBluetoothA2DP]
)

let capture = AVCaptureSession()
capture.configuresApplicationAudioSessionForBluetoothHighQualityRecording = true
```

Fallback occurs on unsupported hardware.

## Spatial Audio Capture (iOS 26+)

### FOA capture

```swift
let audioInput = AVCaptureDeviceInput(device: audioDevice)
audioInput.multichannelAudioMode = .firstOrderAmbisonics
```

### AVAssetWriter path

- capture FOA + stereo + metadata tracks
- use `AVCaptureSpatialAudioMetadataSampleGenerator` for metadata samples

```swift
let foaOutput = AVCaptureAudioDataOutput()
foaOutput.spatialAudioChannelLayoutTag = kAudioChannelLayoutTag_HOA_ACN_SN3D

let stereoOutput = AVCaptureAudioDataOutput()
stereoOutput.spatialAudioChannelLayoutTag = kAudioChannelLayoutTag_Stereo
```

Typical file composition:
1. stereo compatibility track
2. APAC spatial track
3. metadata track

## ASAF / APAC

| Component | Purpose |
|---|---|
| ASAF | authoring/production format |
| APAC | positional delivery codec |

APAC supports channels/objects/HOA/dialogue/binaural, adapts to head tracking, and is used in immersive media workflows.

Playback is standard `AVPlayer` for supported files.

## Cinematic Audio Mix

```swift
import Cinematic

let asset = AVURLAsset(url: spatialAudioURL)
let info = try await CNAssetSpatialAudioInfo(asset: asset)
let mix = info.audioMix(effectIntensity: 0.5, renderingStyle: .cinematic)
playerItem.audioMix = mix
```

Rendering styles include `.cinematic`, `.studio`, `.inFrame`, plus extraction-oriented modes.

For non-`AVPlayer` paths, apply metadata to audio units via `spatialAudioMixMetadata`.

## Common Patterns

### Background playback

```swift
try AVAudioSession.sharedInstance().setCategory(.playback)
// Info.plist: UIBackgroundModes includes audio
```

### Duck others

```swift
try AVAudioSession.sharedInstance().setCategory(.playback, options: .duckOthers)
try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
```

### Bluetooth handling

```swift
try AVAudioSession.sharedInstance().setCategory(.playAndRecord, options: [.allowBluetooth, .allowBluetoothA2DP])
let route = AVAudioSession.sharedInstance().currentRoute
let hasBT = route.outputs.contains { $0.portType == .bluetoothA2DP || $0.portType == .bluetoothHFP }
```

## Anti-Patterns

1. Wrong category for feature intent (e.g., music app using `.ambient`).
2. No interruption observer.
3. Installing taps without removing them.
4. Incompatible manual formats causing graph failures.
5. Configuring session but never calling `setActive(true)`.

## Resources

- WWDC: 2025-251, 2025-403, 2019-510
- Docs: `/avfoundation`, `/avkit`, `/cinematic`
- Targets: iOS 12+ core audio; iOS 26+ for input picker/spatial/HQ AirPods capture
