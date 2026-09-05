# Phase 7 — Advanced Flutter

## Topic 4: `CustomPainter`

> **Core idea:** `CustomPainter` lets you draw things yourself on Flutter's **Canvas** instead of relying only on built-in widgets.

It is useful for things like charts, graphs, custom shapes, progress indicators, signatures, and decorative UI.

---

## 1. Canvas & Painting

The `Canvas` is the surface where you draw.

`CustomPainter` gives you a `Canvas`:

```dart
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // draw here
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
```

You use a `Paint` object to define **how** something should look:

```dart
final paint = Paint()
  ..color = Colors.blue
  ..strokeWidth = 4
  ..style = PaintingStyle.stroke;

canvas.drawCircle(
  Offset(100, 100),
  50,
  paint,
);
```

Mental model:

```text
Canvas → WHERE to draw
Paint  → HOW to draw
```

---

## 2. Coordinate System

Flutter's canvas uses coordinates where:

```text
(0, 0) ───────────► x
  │
  │
  │
  ▼
  y
```

So:

* `(0, 0)` = top-left
* `x` increases → right
* `y` increases → down

For example:

```dart
canvas.drawCircle(
  const Offset(100, 100),
  50,
  paint,
);
```

draws a circle centered at `(100, 100)`.

---

## 3. Shapes and Paths

Canvas provides basic drawing operations:

```dart
canvas.drawLine(...)
canvas.drawCircle(...)
canvas.drawRect(...)
canvas.drawOval(...)
```

For more complex shapes, use a `Path`.

```dart
final path = Path()
  ..moveTo(50, 100)
  ..lineTo(150, 50)
  ..lineTo(200, 100)
  ..close();

canvas.drawPath(path, paint);
```

Think of a `Path` as:

> **A set of instructions describing a custom shape.**

---

## 4. Using `CustomPaint`

You normally attach your painter using `CustomPaint`:

```dart
CustomPaint(
  size: const Size(300, 200),
  painter: MyPainter(),
)
```

So the relationship is:

```text
CustomPaint
     ↓
CustomPainter
     ↓
Canvas + Paint
     ↓
Pixels
```

---

## 5. `shouldRepaint` — Important

Flutter may call `paint()` many times.

`shouldRepaint()` tells Flutter whether the painter needs to paint again when the painter configuration changes.

```dart
@override
bool shouldRepaint(covariant MyPainter oldDelegate) {
  return false;
}
```

If your drawing depends on a value:

```dart
class MyPainter extends CustomPainter {
  MyPainter(this.progress);

  final double progress;

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
```

This matters for **performance**.

> Don't return `true` blindly if the drawing hasn't actually changed.

---

## 🧠 Mental Model

Remember the core structure:

```text
CustomPaint
    │
    ▼
CustomPainter
    │
    ├── Canvas → where
    ├── Paint  → how
    └── Path   → custom shape
```

And the coordinate system:

```text
(0,0)
  ┌──────────────────► X
  │
  │
  │
  ▼
  Y
```

### When should you use `CustomPainter`?

Use it when the UI requires **custom drawing that ordinary Flutter widgets can't express cleanly**.

Don't use it just to recreate normal UI widgets—you'll usually make the code more complicated than necessary.
