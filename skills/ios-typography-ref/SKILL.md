---
name: ios-typography-ref
description: "Use for Apple typography reference: SF families, text styles, Dynamic Type, tracking/leading, AttributedString typography behavior, and international text handling through iOS 26."
license: MIT
---

# Typography Reference

Apple platform typography reference (iOS/macOS/watchOS/visionOS).

## San Francisco System

### Families
- `SF Pro` / `SF Pro Rounded`: default UI fonts
- `SF Compact` / `SF Compact Rounded`: constrained/narrow contexts (watchOS default)
- `SF Mono`: monospaced contexts
- `New York`: serif alternative
- `SF Arabic`: Arabic family aligned with SF system language

### Variable axes

- Weight: Ultralight -> Black
- Width: Condensed, Compressed, Regular, Expanded
- Optical sizing: text (<20pt) vs display (>=20pt)

```swift
let descriptor = UIFontDescriptor(fontAttributes: [
    .family: "SF Pro",
    kCTFontWidthTrait: 1.0
])
```

## Text Styles and Dynamic Type

### System styles

| Text Style | Default iOS size | Typical use |
|---|---:|---|
| `.largeTitle` | 34pt | Primary page title |
| `.title` | 28pt | Section title |
| `.title2` | 22pt | Secondary heading |
| `.title3` | 20pt | Tertiary heading |
| `.headline` | 17pt (semibold) | Emphasized body |
| `.body` | 17pt | Primary text |
| `.callout` | 16pt | Secondary text |
| `.subheadline` | 15pt | Supporting text |
| `.footnote` | 13pt | Footnotes |
| `.caption` | 12pt | Captions |
| `.caption2` | 11pt | Small labels |

### Emphasis

```swift
// UIKit
let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1)
let bold = descriptor.withSymbolicTraits(.traitBold)!
let font = UIFont(descriptor: bold, size: 0)

// SwiftUI
Text("Bold title").font(.title.bold())
```

### Leading variants

```swift
Text("Compact").font(.body.leading(.tight))
Text("Spacious").font(.body.leading(.loose))
```

### Dynamic Type with custom fonts

```swift
// UIKit
let base = UIFont(name: "Avenir-Medium", size: 34)!
let scaled = UIFontMetrics(forTextStyle: .body).scaledFont(for: base)

// SwiftUI
Text("Scaled")
    .font(.custom("Avenir-Medium", size: 34, relativeTo: .body))

@ScaledMetric(relativeTo: .body) var padding: CGFloat = 20
```

### Platform notes

- macOS AppKit: no Dynamic Type equivalent to iOS automatic scaling.
- watchOS: compact defaults, tight spacing.
- visionOS: similar typography behavior to iOS.

## Tracking and Leading

### Tracking

- Small text often needs looser tracking; large display text often tighter.
- Use semantic APIs carefully.

```swift
// UIKit
let attrs: [NSAttributedString.Key: Any] = [
    .font: UIFont.preferredFont(forTextStyle: .body),
    .kern: 2.0
]

// SwiftUI
Text("Tracked").tracking(2.0)
```

Use `.tracking` when intent is letter tracking; `.kerning` differs semantically.

### Leading / line spacing

```swift
// UIKit
let style = NSMutableParagraphStyle()
style.lineSpacing = 8

// SwiftUI
Text("Paragraph").lineSpacing(8)
```

iOS 17+ can increase line height automatically for scripts with taller glyph metrics (e.g., Arabic, Thai, Indic scripts).

## AttributedString + SwiftUI Typography (Critical)

If paragraph style must be preserved (e.g., `lineHeightMultiple`), keep font attributes inside `AttributedString` and avoid overriding with view-level `.font(...)` unless intentional.

### Risk pattern

```swift
var s = AttributedString(longText)
var p = AttributedString.ParagraphStyle()
p.lineHeightMultiple = 0.92
s.paragraphStyle = p

Text(s).font(.body) // may rebuild runs, may normalize/drop paragraph details
```

### Safe pattern

```swift
var s = AttributedString(longText)
s.font = .system(.body)

var p = AttributedString.ParagraphStyle()
p.lineHeightMultiple = 0.92
s.paragraphStyle = p

Text(s) // no overriding .font()
```

### Rule of use

- Need precise paragraph control or mixed fonts: put fonts in `AttributedString`.
- Need broad semantic override only: use `.font(...)` at view level.

### Verification checklist

- [ ] `AttributedString` includes explicit font where paragraph fidelity matters
- [ ] No accidental `.font(...)` override on the same `Text`
- [ ] Paragraph styling validated with real content
- [ ] Large accessibility sizes tested

## Internationalization

### BiDi and complex scripts

- Visual glyph order can differ from character index order.
- A single visual selection may map to multiple text ranges in bidirectional text.

### Line breaking

- iOS 17+ improves language-aware breaks (CJK, German compounds, etc.).
- TextKit 2 line breaking improves spacing regularity in justified text.

### Clipping prevention

- Prefer Dynamic Type aware styles
- Use adequate line limits (`nil` or bounded ranges)
- Use `minimumScaleFactor` only for constrained single-line cases

## Web/CSS Mapping

```css
font-family: system-ui;     /* SF Pro */
font-family: ui-rounded;    /* SF Rounded */
font-family: ui-serif;      /* New York */
font-family: ui-monospace;  /* SF Mono */
```

`-apple-system` is legacy; prefer `system-ui`.

## Quick Examples

```swift
Text("Recipe Editor").font(.largeTitle.bold())

let rounded = UIFontDescriptor
    .preferredFontDescriptor(withTextStyle: .largeTitle)
    .withDesign(.rounded)!
let roundedFont = UIFont(descriptor: rounded, size: 0)

struct ExampleView: View {
    @ScaledMetric(relativeTo: .body) var padding: CGFloat = 20
    var body: some View { Text("Recipe").padding(padding) }
}
```

## Resources

- WWDC: 2020-10175, 2022-110381, 2023-10058
- Docs: `/uikit/uifontdescriptor`, `/uikit/uifontmetrics`, `/swiftui/font`
