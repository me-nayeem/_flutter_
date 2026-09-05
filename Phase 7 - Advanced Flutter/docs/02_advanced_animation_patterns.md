# Phase 7 — Advanced Flutter

## Topic 2: Advanced Animation Patterns

These patterns help you build **more complex animations by combining or coordinating basic animations**.

---

## 1. Hero Animations

A **Hero animation** creates a smooth transition for the same visual element between two screens.

Example:

```text
Screen A                    Screen B

   🖼️                         🖼️
  small                     large
    │                         │
    └──── Hero animation ────►
```

Use:

```dart
Hero(
  tag: 'profile-image',
  child: Image.network(...),
)
```

The `tag` identifies the same element on both screens.

**Use it for:** profile images, product images, cards, etc.

---

## 2. Staggered Animations

A **staggered animation** is when multiple animations happen at **different times or with overlapping intervals**.

Example:

```text
0s ─────────────────────────── 2s

Box 1: █████████
Box 2:     █████████
Box 3:          █████████
```

Instead of animating everything simultaneously, you create a sequence.

Typically this uses multiple `Animation` objects driven by the **same `AnimationController`**.

---

## 3. Coordinated Animations

Coordinated animations mean **multiple UI elements respond together to one animation or user action**.

For example:

```text
User taps button
       ↓
Controller
   ┌───┼────┐
   ↓   ↓    ↓
Scale Fade  Move
```

One `AnimationController` can drive several animations.

This is especially useful for complex UI transitions.

---

## 4. Animated Transitions

Animated transitions control **how one screen/widget changes into another**.

For example:

```text
Page A
  ↓
Fade / Slide / Scale
  ↓
Page B
```

Flutter provides transition widgets such as:

* `FadeTransition`
* `SlideTransition`
* `ScaleTransition`
* `RotationTransition`
* `SizeTransition`

Example:

```dart
FadeTransition(
  opacity: animation,
  child: const Text('Hello'),
)
```

These are useful when you already have an `Animation<double>` and want to apply it to a widget.

---

## 5. Custom Animation Components

When Flutter's built-in animation widgets aren't enough, you can create your own reusable animation component.

For example:

```dart
class MyAnimatedWidget extends AnimatedWidget {
  const MyAnimatedWidget({
    super.key,
    required Animation<double> animation,
  }) : super(listenable: animation);
}
```

The goal isn't to create custom animation classes everywhere.

> **Create a custom animation component when you have a specific animation behavior that you want to reuse or cannot express cleanly with existing Flutter widgets.**

---

## 🧠 Mental Model

Think of advanced animation patterns as **combinations of the fundamentals from Topic 1**:

```text
AnimationController
       ↓
   Animation
       ↓
 ┌─────┼─────────┐
 ↓     ↓         ↓
Hero  Staggered  Transitions
      /Coordinated
       ↓
Custom components
```

**Key idea:** Don't learn these as completely new animation systems. They are mostly ways of **combining and controlling the animation tools you already learned.**
