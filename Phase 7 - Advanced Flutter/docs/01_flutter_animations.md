# Phase 7 — Advanced Flutter

## Topic 1: Flutter Animations

Animations make UI changes feel **smooth instead of sudden**.

The most important distinction to understand is:

```text
Implicit Animation → Flutter manages the animation for you
Explicit Animation → You control the animation yourself
```

---

## 1. Implicit Animations

Use implicit animations when you simply want a widget to **animate automatically when a property changes**.

Example:

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 500),
  width: isExpanded ? 200 : 100,
  height: 100,
);
```

When `isExpanded` changes:

```text
100px ───────────────► 200px
       smoothly
```

Flutter automatically handles the animation.

Common implicit widgets:

* `AnimatedContainer`
* `AnimatedOpacity`
* `AnimatedPadding`
* `AnimatedPositioned`

### When to use

Use them for simple UI transitions where you don't need precise control.

---

# 2. Explicit Animations

Use explicit animations when **you need control over the animation**.

The main components are:

```text
AnimationController
        │
        ▼
   Animation
        │
        ▼
      Tween
        │
        ▼
 Animated value
```

For example, you might want an animation to:

* start/stop manually
* repeat
* reverse
* react to user interaction
* control its exact progress

---

## 3. AnimationController

`AnimationController` controls **the progress and lifecycle of an animation**.

Think of it as a timer/progress controller:

```text
0.0 ───────────────► 1.0
start                 end
```

Example:

```dart
_controller.forward();
_controller.reverse();
_controller.repeat();
```

Usually created with a duration:

```dart
_controller = AnimationController(
  vsync: this,
  duration: const Duration(seconds: 1),
);
```

### Important

`AnimationController` needs a `Ticker`, which is why widgets commonly use:

```dart
with SingleTickerProviderStateMixin
```

---

# 4. Animation

An `Animation<T>` represents a **changing value over time**.

For example:

```dart
Animation<double>
```

could produce:

```text
0.0 → 0.2 → 0.5 → 0.8 → 1.0
```

The controller controls **time/progress**, while the animation provides the **value**.

---

# 5. Tween

A `Tween` defines:

> **What value should change from → to?**

Example:

```dart
Tween<double>(
  begin: 0,
  end: 100,
);
```

This creates values between:

```text
0 → 20 → 40 → 60 → 80 → 100
```

So:

```text
AnimationController
        ↓
     progress
     0 → 1
        ↓
      Tween
     0 → 100
        ↓
   actual value
```

This distinction is very important.

---

# 6. CurvedAnimation

A normal animation changes linearly:

```text
0 ─── 25 ─── 50 ─── 75 ─── 100
```

`CurvedAnimation` changes **how the animation progresses**.

For example:

```dart
CurvedAnimation(
  parent: controller,
  curve: Curves.easeInOut,
);
```

Now the movement can start slowly, accelerate, and slow down.

Think:

```text
Controller → "how far through?"
Curve      → "how should it feel?"
Tween      → "what value should change?"
```

---

# 7. Animation Lifecycle

For explicit animations, you generally need to manage the controller's lifecycle:

```dart
@override
void initState() {
  super.initState();

  _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );
}

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

### Why `dispose()`?

`AnimationController` uses resources that should be released when the widget is removed.

> **Rule:** If you create an `AnimationController`, properly dispose of it.

---

## 🧠 Final Mental Model

Remember this:

```text
AnimationController
    │
    │ controls progress
    ▼
CurvedAnimation
    │
    │ controls timing/feel
    ▼
Tween
    │
    │ maps progress to values
    ▼
Animation<T>
    │
    ▼
Widget
```

### Most important takeaway

**Implicit:** Flutter controls the animation.

**Explicit:** You control the animation.

And for explicit animations:

> **Controller = progress → Curve = timing → Tween = value range**
