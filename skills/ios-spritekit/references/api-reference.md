# SpriteKit API Reference

## Node Catalog

| Node | Purpose | Notes |
|---|---|---|
| `SKNode` | container | zero rendering cost |
| `SKSpriteNode` | textured sprite | main gameplay primitive |
| `SKShapeNode` | vector path | expensive; avoid in gameplay |
| `SKLabelNode` | text | separate draw call |
| `SKEmitterNode` | particles | GPU-bound |
| `SKCameraNode` | viewport | attach HUD as children |
| `SKTileMapNode` | tiles | efficient large maps |
| `SKEffectNode` | filtered subtree | expensive unless rasterized |
| `SKCropNode` | masking | extra render passes |
| `SKRenderer` | custom render integration | Metal / offscreen integration |

## `SKSpriteNode`

```swift
let sprite = SKSpriteNode(imageNamed: "player")
sprite.anchorPoint = CGPoint(x: 0.5, y: 0)
sprite.color = .red
sprite.colorBlendFactor = 0.5
sprite.normalTexture = normalMap
```

## Physics Bodies

### Creation

```swift
SKPhysicsBody(circleOfRadius: 20)
SKPhysicsBody(rectangleOf: CGSize(width: 40, height: 60))
SKPhysicsBody(polygonFrom: path)
SKPhysicsBody(texture: texture, size: size)
SKPhysicsBody(edgeLoopFrom: rect)
SKPhysicsBody(edgeFrom: pointA, to: pointB)
SKPhysicsBody(bodies: [body1, body2])
```

### Key properties

```swift
body.categoryBitMask = 0x1
body.collisionBitMask = 0x2
body.contactTestBitMask = 0x4
body.isDynamic = true
body.affectedByGravity = true
body.allowsRotation = true
body.usesPreciseCollisionDetection = true
body.velocity = CGVector(dx: 100, dy: 0)
```

## `SKPhysicsWorld`

```swift
scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
scene.physicsWorld.speed = 1.0
scene.physicsWorld.contactDelegate = self
```

```swift
scene.physicsWorld.enumerateBodies(alongRayStart: start, end: end) { body, point, normal, stop in
    // inspect hits
}
```

## Actions

```swift
let jump = SKAction.moveBy(x: 0, y: 100, duration: 0.3)
let fade = SKAction.fadeOut(withDuration: 0.2)
let sequence = SKAction.sequence([jump, fade])
let group = SKAction.group([jump, .rotate(byAngle: .pi, duration: 0.3)])
let forever = SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.08))
```

| Action family | Examples |
|---|---|
| movement | `move`, `follow`, `speed` |
| transform | `scale`, `rotate`, `resize` |
| visibility | `fadeIn`, `fadeOut`, `hide`, `unhide` |
| animation | `animate(with:)`, `setTexture` |
| control flow | `sequence`, `group`, `repeat`, `wait`, `run` |

## Scene Setup

```swift
scene.scaleMode = .aspectFill

let camera = SKCameraNode()
scene.addChild(camera)
scene.camera = camera
```

Scale modes:

| Mode | Meaning |
|---|---|
| `.aspectFill` | fills view, crops edges |
| `.aspectFit` | fits whole scene, letterboxes |
| `.fill` | stretches to fit |
| `.resizeFill` | scene size follows view |

## Particles

```swift
let emitter = SKEmitterNode(fileNamed: "Explosion.sks")
emitter?.particleBirthRate = 200
emitter?.particleLifetime = 0.5
emitter?.particleSpeed = 300
```

## Constraints

```swift
let distance = SKConstraint.distance(SKRange(constantValue: 0), to: player)
camera.constraints = [distance]
```

## View Performance Flags

```swift
view.ignoresSiblingOrder = true
view.showsFPS = true
view.showsNodeCount = true
view.showsPhysics = true
```

## `SKRenderer`

```swift
let renderer = SKRenderer(device: device)
renderer.scene = scene
renderer.update(atTime: time)
renderer.render(withViewport: viewport, commandBuffer: commandBuffer, renderPassDescriptor: descriptor)
```
