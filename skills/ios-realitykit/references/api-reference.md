# RealityKit API Reference

## Core Types

| Type | Role |
|---|---|
| `Entity` | hierarchy node + identity |
| `ModelEntity` | renderable entity |
| `AnchorEntity` | tracked/world anchor root |
| `Component` | attached data |
| `System` | frame update logic |
| `RealityView` | SwiftUI rendering surface |
| `Model3D` | declarative model display |

## Entities

```swift
let entity = Entity()
entity.name = "player"

let model = ModelEntity(
    mesh: .generateBox(size: 0.1),
    materials: [SimpleMaterial(color: .blue, isMetallic: false)]
)

parent.addChild(model)
let clone = model.clone(recursive: true)
```

| Property | Notes |
|---|---|
| `name` | lookup identifier |
| `parent` / `children` | hierarchy |
| `components` | attached component set |
| `scene` | owning scene if active |
| `isEnabled` | local enabled state |

## Transform

```swift
entity.position = [0, 1, 0]
entity.orientation = simd_quatf(angle: .pi / 4, axis: [0, 1, 0])
entity.scale = .one * 2

let worldPosition = entity.position(relativeTo: nil)
entity.setPosition([1, 0, 0], relativeTo: nil)
entity.look(at: target, from: origin, relativeTo: nil)
```

## Components

### `ModelComponent`

```swift
entity.components[ModelComponent.self] = ModelComponent(
    mesh: .generateSphere(radius: 0.1),
    materials: [PhysicallyBasedMaterial()]
)
```

### `CollisionComponent`

```swift
entity.components[CollisionComponent.self] = CollisionComponent(
    shapes: [.generateBox(size: [0.2, 0.2, 0.2])]
)
```

### `PhysicsBodyComponent`

```swift
entity.components[PhysicsBodyComponent.self] = PhysicsBodyComponent(
    massProperties: .default,
    material: .default,
    mode: .dynamic
)
```

Physics modes:

| Mode | Behavior |
|---|---|
| `.dynamic` | simulation-owned |
| `.static` | immovable collider |
| `.kinematic` | app-driven motion |

### Custom component

```swift
struct HealthComponent: Component {
    var current: Int
    var maximum: Int
}

HealthComponent.registerComponent()
entity.components[HealthComponent.self] = .init(current: 100, maximum: 100)
```

## Meshes and Materials

### `MeshResource`

| Generator | Notes |
|---|---|
| `.generateBox(size:)` | box / rounded box variants |
| `.generateSphere(radius:)` | sphere |
| `.generatePlane(width:depth:)` | horizontal plane |
| `.generateCylinder(height:radius:)` | cylinder |
| `.generateCone(height:radius:)` | cone |
| `.generateText(_:)` | text mesh |

### Materials

| Material | Use |
|---|---|
| `SimpleMaterial` | lightweight non-PBR |
| `PhysicallyBasedMaterial` | metallic/roughness workflow |
| `UnlitMaterial` | ignore lighting |
| `OcclusionMaterial` | AR occlusion |
| `VideoMaterial` | video texture |
| `ShaderGraphMaterial` / `CustomMaterial` | custom shading |

## Anchoring

```swift
AnchorEntity(.plane(.horizontal, classification: .table, minimumBounds: [0.2, 0.2]))
AnchorEntity(.world(transform: .identity))
AnchorEntity(.image(group: "AR Resources", name: "poster"))
```

## Systems

```swift
struct DamageSystem: System {
    static let query = EntityQuery(where: .has(HealthComponent.self))

    init(scene: Scene) {}

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            // mutate components
        }
    }
}
```

## Animation and Motion

```swift
entity.move(
    to: Transform(scale: .one, rotation: simd_quatf(), translation: [0, 1, 0]),
    relativeTo: nil,
    duration: 0.3
)

let controller = entity.playAnimation(animationResource)
controller.stop()
```

## Audio

```swift
let resource = try await AudioFileResource(named: "click.wav", from: "Assets")
entity.playAudio(resource)
```

Useful audio components:

| Component | Use |
|---|---|
| `SpatialAudioComponent` | positional audio |
| `AmbientAudioComponent` | non-positional ambient sound |
| `AudioMixGroupsComponent` | routing/mix groups |

## `RealityView`

```swift
RealityView { content in
    let entity = try await Entity(named: "Scene", in: realityKitContentBundle)
    content.add(entity)
} update: { content in
    // update existing scene content
}
```

## Collision and Gesture Prerequisites

```swift
entity.generateCollisionShapes(recursive: true)
entity.components[InputTargetComponent.self] = .init()
entity.components[HoverEffectComponent.self] = .init()
```

## Accessibility

```swift
entity.components[AccessibilityComponent.self] = AccessibilityComponent(
    label: "Planet",
    value: "Selectable"
)
```
