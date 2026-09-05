# Phase 7 — Advanced Flutter

## Topic 7: Performance Optimization

> **Core idea:** Performance optimization means making Flutter do **less unnecessary work** while keeping the UI smooth and responsive.

---

## 1. Rebuilds

When state changes, Flutter may rebuild widgets.

A rebuild is **not automatically bad**. The problem is unnecessary or expensive rebuilding.

```text
State changes
     ↓
Widget rebuilds
     ↓
Build → Layout → Paint
```

Keep frequently changing state as close as possible to the widgets that actually need it.

---

## 2. `const`

Use `const` when a widget and its configuration can be compile-time constant:

```dart
const Text('Hello');
```

`const` widgets can be reused instead of being recreated unnecessarily.

Use it throughout your widget tree where appropriate.

---

## 3. Widget Identity

Flutter uses **widget identity and keys** to determine which existing elements should correspond to new widgets.

This becomes particularly important when:

* list items are reordered
* items are inserted/removed
* widgets maintain state

For example:

```dart
ListTile(
  key: ValueKey(note.id),
  title: Text(note.title),
)
```

The key tells Flutter:

> **"This widget represents this specific item."**

---

## 4. Lazy Lists

For large lists, avoid creating every item upfront.

Prefer:

```dart
ListView.builder(
  itemCount: 1000,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('Item $index'),
    );
  },
)
```

It builds items **as they become needed**.

This is one reason `ListView.builder` is preferable to manually creating a huge list of widgets.

---

## 5. Image Optimization

Large images can consume significant **memory**.

Important practices include:

* Use appropriately sized images.
* Avoid loading unnecessarily huge images.
* Use efficient image formats where appropriate.
* Be careful when displaying many images simultaneously.

A 4000×4000 image requires much more memory to decode than an image actually needed at a small on-screen size.

---

## 6. Memory Usage

Performance isn't only about CPU.

Your app also needs to manage memory efficiently.

Watch for:

```text
Large images
Large collections
Unnecessary objects
Resources not disposed
```

For example, controllers, subscriptions, and similar resources should be properly disposed of.

---

## 7. Jank

**Jank** means visible stuttering or dropped frames.

Conceptually:

```text
Smooth:
Frame → Frame → Frame → Frame

Jank:
Frame → Frame → [TOO SLOW] → Frame
```

Typical causes include:

* expensive work on the UI isolate
* excessive rebuilding
* expensive layout/painting
* large image processing

Your goal isn't simply "make everything faster."

> **Find the actual bottleneck first, then optimize it.**

---

## 8. Flutter DevTools

**Flutter DevTools** is one of your most important tools for performance work.

It helps you inspect things such as:

* widget rebuilds
* CPU usage
* memory
* frame performance
* performance timelines

Don't optimize based purely on intuition.

Use profiling tools to **measure → identify bottleneck → optimize → measure again**.

---

## 🧠 Performance Mental Model

Remember this workflow:

```text
                    Performance
                         │
              ┌──────────┴──────────┐
              ↓                     ↓
        Avoid unnecessary      Keep work
           rebuilding          lightweight
              │                     │
           const                 Isolates
           Keys                 when needed
           Lazy lists
              │
              └──────────┬──────────
                         ↓
                    DevTools
                         ↓
                    Measure
                         ↓
                   Find bottleneck
                         ↓
                      Optimize
```

### Most important principles

1. **Don't fear rebuilds; avoid unnecessary expensive work.**
2. **Use `const` where appropriate.**
3. **Use lazy builders for large lists.**
4. **Optimize image memory usage.**
5. **Use DevTools to measure before optimizing.**
6. **Jank is a symptom—find the actual cause.**
