# SF Symbols API Reference

## Display and Configuration

### SwiftUI

```swift
Image(systemName: "star.fill")
    .font(.title)
    .imageScale(.large)
    .fontWeight(.bold)

Image(systemName: "speaker.wave.3.fill", variableValue: 0.5)
Image(systemName: "person").symbolVariant(.circle.fill)
```

### UIKit

```swift
let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
let image = UIImage(systemName: "star.fill", withConfiguration: config)
imageView.image = image
```

## Rendering Modes

### SwiftUI

```swift
Image(systemName: "cloud.rain.fill")
    .symbolRenderingMode(.hierarchical)
    .foregroundStyle(.blue)

Image(systemName: "cloud.rain.fill")
    .symbolRenderingMode(.palette)
    .foregroundStyle(.white, .blue)

Image(systemName: "cloud.rain.fill")
    .symbolRenderingMode(.multicolor)
```

| Mode | Meaning |
|---|---|
| `.monochrome` | one color for all layers |
| `.hierarchical` | one color with derived opacity depth |
| `.palette` | explicit per-layer colors |
| `.multicolor` | Apple-defined colors |

### UIKit equivalents

```swift
UIImage.SymbolConfiguration(hierarchicalColor: .systemBlue)
UIImage.SymbolConfiguration(paletteColors: [.white, .systemBlue])
UIImage.SymbolConfiguration.preferringMulticolor()
```

## Symbol Effects

### Categories

| Category | Trigger | Modifier |
|---|---|---|
| discrete | `value:` changes | `.symbolEffect(_:options:value:)` |
| indefinite | `isActive:` | `.symbolEffect(_:options:isActive:)` |
| transition | insertion/removal | `.transition(.symbolEffect(_:))` |
| content transition | symbol replacement | `.contentTransition(.symbolEffect(_:))` |

### Common effects

```swift
Image(systemName: "arrow.down.circle")
    .symbolEffect(.bounce, value: count)

Image(systemName: "wifi")
    .symbolEffect(.variableColor.iterative, isActive: isSearching)

Image(systemName: "network")
    .symbolEffect(.pulse, isActive: isConnecting)
```

```swift
Image(systemName: "bell.fill")
    .symbolEffect(.wiggle, value: notificationCount) // iOS 18+

Image(systemName: "arrow.trianglehead.2.clockwise")
    .symbolEffect(.rotate, value: refreshCount) // iOS 18+
```

### Options

```swift
.symbolEffect(.bounce, options: .speed(2.0), value: count)
.symbolEffect(.pulse, options: .repeat(.continuous), isActive: true)
.symbolEffect(.wiggle, options: .repeat(5).speed(1.5), value: count)
```

## Draw Animations

```swift
Image(systemName: "pencil.and.outline")
    .symbolEffect(.drawOn, value: state)
```

`Draw` family availability: iOS 26+ / SF Symbols 7.

| Effect | Use |
|---|---|
| `.drawOn` | draw in |
| `.drawOff` | erase out |
| variable draw | progress-like path drawing |

## Custom Symbols

- Build in the SF Symbols app.
- Provide hierarchical, palette, and multicolor layers intentionally.
- Annotate draw paths if the symbol should support Draw animations.
- Test weight, scale, and baseline alignment against Apple symbols.

## Removing Effects

```swift
Image(systemName: "star.fill")
    .symbolEffectsRemoved()
```
