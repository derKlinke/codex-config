---
name: ios-lldb-ref
description: "Use for LLDB command reference: variable inspection, breakpoints/watchpoints, thread/frame control, expression evaluation, process control, memory/image inspection, and .lldbinit customization."
license: MIT
---

# LLDB Command Reference

Task-organized LLDB commands for Xcode debugging.
For workflow/decision trees, use `ios-lldb`.

## 1) Variable Inspection

### `v` / `frame variable` (memory read, no compilation)

```lldb
v
v self
v self.property
v localVar
v self.array[0]
v self._stateBacking
```

| Flag | Effect |
|---|---|
| `-d run` | dynamic type resolution |
| `-T` | show types |
| `-R` | raw output |
| `-D N` | max nested depth |
| `-P N` | pointer depth |
| `-F` | flat output |

Use `v` for reliable read-only introspection.

### `p` / `expression`

```lldb
p self.computedProperty
p items.count
p someFunction()
p $R0 + 10
```

Compiles/evaluates expression; returns `$R*` temporaries.

### `po` / object description

```lldb
po myObject
po error
po notification.userInfo
```

Useful for object descriptions; may be weak for plain Swift value types/protocol-erased values.

### `expression` full form

```lldb
expression self.debugFlag = true
expression CATransaction.flush()
expression Self._printChanges()
expr -l objc -- (void)[CATransaction flush]
```

| Flag | Effect |
|---|---|
| `-l swift` | Swift evaluation |
| `-l objc` | Objective-C evaluation |
| `-O` | object description |
| `-i false` | stop on inner breakpoint hits |
| `--` | separate flags from expression |

### Registers

```lldb
register read
register read x0 x1
register read --all
```

## 2) Breakpoints / Watchpoints

### Set breakpoints

```lldb
b File.swift:42
breakpoint set -f File.swift -l 42
breakpoint set -n methodName
breakpoint set -n "MyClass.myMethod"
breakpoint set -S layoutSubviews
breakpoint set -r "viewDid.*"
breakpoint set -a 0x100abc123
```

### Conditions / behavior

```lldb
breakpoint set -f File.swift -l 42 -c "value == nil"
breakpoint set -f File.swift -l 42 -i 50
breakpoint set -f File.swift -l 42 -o
```

### Commands/logpoints

```lldb
breakpoint command add 1
> v self.state
> p self.items.count
> continue
> DONE

breakpoint command add 1 -o "v self.state"
```

### Exception/symbolic breakpoints

```lldb
breakpoint set -E swift
breakpoint set -E objc
breakpoint set -n UIViewAlertForUnsatisfiableConstraints
breakpoint set -n swift_willThrow
```

### Manage breakpoints

```lldb
breakpoint list
breakpoint enable 3
breakpoint disable 3
breakpoint modify 3 -c "x > 10"
breakpoint delete 3
breakpoint delete
```

### Watchpoints

```lldb
watchpoint set variable self.count
watchpoint set variable -w read_write myGlobal
watchpoint set expression -- &myVariable
watchpoint list
watchpoint modify 1 -c "self.count > 10"
watchpoint delete 1
```

Hardware watchpoints are limited; use sparingly.

## 3) Threads / Frames / Backtraces

```lldb
bt
bt 10
bt all
thread list
thread info
thread select 3
frame info
frame select 5
up
down
```

Early-return current frame (unsafe if cleanup is skipped):

```lldb
thread return
thread return 42
```

## 4) Expression Use Cases

### Swift

```lldb
expr let x = 42; print(x)
expr self.view.backgroundColor = UIColor.red
expr UIApplication.shared.windows.first?.rootViewController
expr UserDefaults.standard.set(true, forKey: "debug")
expr type(of: someValue)
```

### Objective-C fallback

```lldb
expr -l objc -- (void)[CATransaction flush]
expr -l objc -- (id)[[UIApplication sharedApplication] keyWindow]
expr -l objc -- (void)[[[UIApplication sharedApplication] keyWindow] recursiveDescription]
```

### SwiftUI

```lldb
expr Self._printChanges()
```

Valid only in relevant SwiftUI context.

## 5) Process Control

```lldb
continue
c
process interrupt
thread step-over
n
thread step-in
s
thread step-out
finish
thread step-inst
ni
```

Process lifecycle:

```lldb
process launch
process attach --pid 1234
process attach --name MyApp
process detach
kill
```

## 6) Memory / Images

```lldb
memory read 0x100abc123
memory read -c 64 0x100abc123
memory read -f x 0x100abc123
memory read -f s 0x100abc123
memory find -s "searchString" -- 0x100000000 0x200000000
```

```lldb
image lookup -a 0x100abc123
image lookup -n myFunction
image lookup -rn "MyClass.*"
image list
image list -b
```

## 7) `.lldbinit` Customization

### Location

Global config: `~/.lldbinit`
Per-project init: set in Xcode scheme options.

### Useful aliases

```lldb
command alias flush expr -l objc -- (void)[CATransaction flush]
command alias views expr -l objc -- (void)[[[UIApplication sharedApplication] keyWindow] recursiveDescription]
command alias constraints po [[UIWindow keyWindow] _autolayoutTrace]
```

### Type summary

```lldb
type summary add CLLocationCoordinate2D --summary-string "${var.latitude}, ${var.longitude}"
```

### Settings

```lldb
settings show target.language
settings set target.language swift
settings set target.max-children-count 100
```

## 8) LLDB Troubleshooting

### `expression failed to parse`
- prefer `v` for read-only checks
- simplify expression
- try ObjC mode for bridge-heavy APIs
- rebuild/clean if symbols stale

### `variable not available`
- variable optimized out
- use Debug + `-Onone`
- inspect registers if needed

### Wrong language mode

```lldb
settings set target.language swift
expr -l swift -- mySwiftExpression
```

### Expression crashes app
- expression had side effects
- use `v` where possible
- restart session if state corrupt

### LLDB hangs/slowness
- complex expression/type resolution
- cancel and use simpler expression or `v`

### Breakpoint not hit
- wrong line/symbol
- breakpoint disabled
- path never executed
- release optimization
- framework symbol mismatch (use symbolic breakpoint)

## Resources

- WWDC: 2019-429, 2018-412, 2022-110370, 2015-402
- Docs: `/xcode/stepping-through-code-and-inspecting-variables-to-isolate-bugs`, `/xcode/setting-breakpoints-to-pause-your-running-app`
- Skills: `ios-lldb`, `ios-xcode-debugging`
