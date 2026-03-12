# SceneKit API Reference and RealityKit Mapping

## Concept Mapping

| SceneKit | RealityKit | Notes |
|---|---|---|
| `SCNScene` | entity hierarchy / `RealityViewContent` | root scene representation |
| `SCNNode` | `Entity` | hierarchy container |
| `SCNView` | `RealityView` / `ARView` | rendering surface |
| `SceneView` | `RealityView` | SwiftUI replacement |
| node-owned behavior | components + systems | ECS split |
| `.scn` | `.usdz` / `.usda` | preferred asset path |

## `SCNScene`

```swift
let scene = SCNScene(named: "scene.scn")
let scene = try SCNScene(url: url, options: [.checkConsistency: true])

scene?.rootNode
scene?.background.contents = UIColor.black
scene?.lightingEnvironment.contents = UIImage(named: "ibl")
scene?.isPaused = false
```

## `SCNNode`

```swift
let node = SCNNode()
node.position = SCNVector3(0, 1, 0)
node.eulerAngles = SCNVector3(0, .pi / 4, 0)
node.scale = SCNVector3(1, 1, 1)

parent.addChildNode(node)
node.removeFromParentNode()
let found = scene.rootNode.childNode(withName: "player", recursively: true)
```

## Geometry

| SceneKit | RealityKit |
|---|---|
| `SCNBox` | `MeshResource.generateBox` |
| `SCNSphere` | `MeshResource.generateSphere` |
| `SCNPlane` | `MeshResource.generatePlane` |
| `SCNCylinder` | `MeshResource.generateCylinder` |
| `SCNText` | `MeshResource.generateText` |

```swift
let box = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.1)
let node = SCNNode(geometry: box)
```

## Materials

```swift
let material = SCNMaterial()
material.lightingModel = .physicallyBased
material.diffuse.contents = UIColor.red
material.metalness.contents = 0.8
material.roughness.contents = 0.2
material.normal.contents = UIImage(named: "normal")
```

| `SCNMaterial` property | RealityKit equivalent |
|---|---|
| `diffuse` | `baseColor` |
| `metalness` | `metallic` |
| `roughness` | `roughness` |
| `normal` | `normal` |
| shader modifiers | `CustomMaterial` / `ShaderGraphMaterial` rewrite |

## Cameras and Lights

```swift
let cameraNode = SCNNode()
cameraNode.camera = SCNCamera()
cameraNode.camera?.fieldOfView = 60

let lightNode = SCNNode()
lightNode.light = SCNLight()
lightNode.light?.type = .directional
```

| `SCNLight` type | RealityKit |
|---|---|
| `.omni` | `PointLightComponent` |
| `.directional` | `DirectionalLightComponent` |
| `.spot` | `SpotLightComponent` |
| `.ambient` / `.probe` | environment lighting |

## Physics

```swift
let body = SCNPhysicsBody(type: .dynamic, shape: nil)
body.mass = 1
body.friction = 0.2
body.restitution = 0.3
body.categoryBitMask = 1 << 0
body.collisionBitMask = 1 << 1
body.contactTestBitMask = 1 << 1
node.physicsBody = body
```

| SceneKit | RealityKit |
|---|---|
| `SCNPhysicsBody` | `PhysicsBodyComponent` |
| `SCNPhysicsShape` | `CollisionComponent` + `ShapeResource` |
| `SCNPhysicsContactDelegate` | collision event subscriptions |

## Animation

```swift
SCNTransaction.begin()
SCNTransaction.animationDuration = 0.3
node.position = SCNVector3(0, 2, 0)
SCNTransaction.commit()
```

```swift
let action = SCNAction.moveBy(x: 0, y: 1, z: 0, duration: 0.3)
node.runAction(action)
```

RealityKit translation:

| SceneKit | RealityKit |
|---|---|
| `SCNAction` | `move(to:relativeTo:duration:)` / animation playback |
| `SCNTransaction` | explicit animation APIs |
| `SCNAnimationPlayer` | `AnimationPlaybackController` |

## SwiftUI Bridge

```swift
struct SceneKitView: UIViewRepresentable {
    let scene: SCNScene

    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.scene = scene
        view.allowsCameraControl = true
        return view
    }

    func updateUIView(_ uiView: SCNView, context: Context) {}
}
```

## Migration Notes

- Keep SceneKit only for legacy maintenance.
- Prefer USD assets during migration.
- Replace node-subclass logic with components/systems.
- Rewrite shader modifiers; there is no direct port.
- Treat new SceneKit feature work as migration debt.
