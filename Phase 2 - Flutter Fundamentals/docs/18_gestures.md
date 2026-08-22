# 🟢 Phase 2 — Topic 18: Gestures

> **Gestures are how Flutter detects user interactions such as taps, double taps, long presses, drags, swipes, and other touch-based actions.**

A Flutter UI is not useful only because it looks good. A real application must also **respond to user interaction**.

This topic teaches you how Flutter turns physical user actions into application events.

---

# 📚 Table of Contents

1. [What Are Gestures?](#-1-what-are-gestures)
2. [How Flutter Gesture Handling Works](#-2-how-flutter-gesture-handling-works)
3. [`GestureDetector`](#-3-gesturedetector)
4. [`onTap`](#-4-ontap)
5. [`onDoubleTap`](#-5-ondoubletap)
6. [`onLongPress`](#-6-onlongpress)
7. [Other Common Gesture Callbacks](#-7-other-common-gesture-callbacks)
8. [Tap vs Long Press vs Double Tap](#-8-tap-vs-long-press-vs-double-tap)
9. [Drag Gestures](#-9-drag-gestures)
10. [Vertical and Horizontal Drag](#-10-vertical-and-horizontal-drag)
11. [`onPanUpdate`](#-11-onpanupdate)
12. [Detecting Tap Position](#-12-detecting-tap-position)
13. [`InkWell`](#-13-inkwell)
14. [`GestureDetector` vs `InkWell`](#-14-gesturedetector-vs-inkwell)
15. [Making a Custom Widget Interactive](#-15-making-a-custom-widget-interactive)
16. [Gesture Handling with `setState`](#-16-gesture-handling-with-setstate)
17. [GestureDetector and Hit Testing](#-17-gesturedetector-and-hit-testing)
18. [Gesture Conflicts](#-18-gesture-conflicts)
19. [Common Mistakes](#-19-common-mistakes)
20. [Professional Best Practices](#-20-professional-best-practices)
21. [Real-World Example](#-21-real-world-example)
22. [Practice](#-22-practice)
23. [Knowledge Check](#-23-knowledge-check)
24. [Quick Reference](#-24-quick-reference)
25. [Key Takeaways](#-25-key-takeaways)

---

# 🧠 1. What Are Gestures?

A **gesture** is a physical interaction performed by the user.

Examples:

```text
Tap
Double tap
Long press
Swipe
Drag
Pan
Scale
```

For example:

```text
User taps button
      ↓
Flutter detects gesture
      ↓
Callback executes
      ↓
Application performs action
```

Example:

```dart
GestureDetector(
  onTap: () {
    print('Tapped!');
  },
  child: const Text('Tap me'),
)
```

When the user taps the text:

```text
Tapped!
```

is printed.

---

# 💡 2. How Flutter Gesture Handling Works

At a high level:

```text
Physical touch
      ↓
Flutter receives pointer event
      ↓
Hit testing
      ↓
Gesture recognition
      ↓
GestureDetector / InkWell
      ↓
Callback
      ↓
Your application logic
```

This distinction is important:

> A **pointer event** is low-level input information. A **gesture** is Flutter's interpretation of a sequence of pointer events.

For example:

```text
Finger touches screen
Finger moves
Finger leaves screen
        ↓
Flutter interprets the sequence
        ↓
"That was a tap"
```

You normally don't need to manually process those low-level events.

Flutter's gesture system does that for you.

---

# 🏗️ 3. `GestureDetector`

The primary widget for detecting gestures is:

```dart
GestureDetector
```

Basic example:

```dart
GestureDetector(
  onTap: () {
    print('Tapped');
  },
  child: const Text('Tap me'),
)
```

`GestureDetector` doesn't provide a visual design by itself.

Its job is:

> **Detect gestures and notify your code through callbacks.**

Think:

```text
GestureDetector
       │
       ├── Detect tap
       ├── Detect long press
       ├── Detect drag
       ├── Detect double tap
       └── Detect pan
```

---

# 🖱️ 4. `onTap`

The most common gesture:

```dart
onTap
```

Example:

```dart
GestureDetector(
  onTap: () {
    print('Button tapped');
  },
  child: Container(
    padding: const EdgeInsets.all(16),
    color: Colors.blue,
    child: const Text('Tap Me'),
  ),
)
```

When the user taps:

```text
Tap Me
   ↓
onTap()
   ↓
Your code
```

---

# 💡 A callback is just a function

This:

```dart
onTap: () {
  print('Tapped');
},
```

means:

> "When a tap happens, execute this function."

You can also call another method:

```dart
void handleTap() {
  print('Tapped');
}
```

Then:

```dart
GestureDetector(
  onTap: handleTap,
  child: const Text('Tap'),
)
```

This is often cleaner when the logic becomes larger.

---

# 👆 5. `onDoubleTap`

To detect a double tap:

```dart
GestureDetector(
  onDoubleTap: () {
    print('Double tapped');
  },
  child: const Text('Double tap me'),
)
```

Flow:

```text
Tap
 +
Tap
 ↓
Double tap
 ↓
onDoubleTap()
```

A common real-world example is liking an image:

```text
        Image
          │
      Double tap
          ↓
        ❤️
```

---

# ⏱️ 6. `onLongPress`

To detect a long press:

```dart
GestureDetector(
  onLongPress: () {
    print('Long pressed');
  },
  child: const Text('Hold me'),
)
```

Useful for interactions such as:

* showing contextual menus
* selecting an item
* opening additional actions
* initiating drag-like interactions

Example:

```text
User holds item
      ↓
Long press detected
      ↓
Show actions
```

---

# 📚 7. Other Common Gesture Callbacks

`GestureDetector` supports many callbacks.

Some important ones:

| Callback                 | Purpose                |
| ------------------------ | ---------------------- |
| `onTap`                  | Single tap             |
| `onDoubleTap`            | Double tap             |
| `onLongPress`            | Long press             |
| `onTapDown`              | Pointer touches down   |
| `onTapUp`                | Tap pointer released   |
| `onTapCancel`            | Tap gesture cancelled  |
| `onPanStart`             | Pan begins             |
| `onPanUpdate`            | Pan moves              |
| `onPanEnd`               | Pan ends               |
| `onHorizontalDragStart`  | Horizontal drag begins |
| `onHorizontalDragUpdate` | Horizontal drag moves  |
| `onHorizontalDragEnd`    | Horizontal drag ends   |
| `onVerticalDragStart`    | Vertical drag begins   |
| `onVerticalDragUpdate`   | Vertical drag moves    |
| `onVerticalDragEnd`      | Vertical drag ends     |
| `onScaleStart`           | Scaling begins         |
| `onScaleUpdate`          | Scaling changes        |
| `onScaleEnd`             | Scaling ends           |

You don't need to memorize all of them immediately.

Focus first on:

```text
onTap
onDoubleTap
onLongPress
onPanUpdate
onHorizontalDragUpdate
onVerticalDragUpdate
```

---

# 🔍 8. Tap vs Long Press vs Double Tap

These are different gestures.

```text
Single tap
    ↓
onTap()


Double tap
    ↓
onDoubleTap()


Long press
    ↓
onLongPress()
```

For example:

```dart
GestureDetector(
  onTap: () {
    print('Tap');
  },
  onDoubleTap: () {
    print('Double tap');
  },
  onLongPress: () {
    print('Long press');
  },
  child: const Text('Interact with me'),
)
```

Flutter's gesture system determines which gesture occurred.

---

# 🖐️ 9. Drag Gestures

Now we move to more advanced interaction.

Suppose the user wants to drag a widget:

```text
┌───────┐
│ Box   │ ───────────────►
└───────┘
```

You can use:

```dart
onPanUpdate
```

Example:

```dart
GestureDetector(
  onPanUpdate: (details) {
    print(details.delta);
  },
  child: Container(
    width: 100,
    height: 100,
    color: Colors.blue,
  ),
)
```

`details.delta` tells you how much the pointer moved since the previous update.

---

# 🧠 Understanding `DragUpdateDetails`

Inside:

```dart
onPanUpdate: (details) {
```

you receive information about the movement.

For example:

```dart
details.delta
```

might represent:

```text
Offset(5, 2)
```

meaning approximately:

```text
x changed by 5
y changed by 2
```

So:

```dart
details.delta.dx
```

is horizontal movement.

And:

```dart
details.delta.dy
```

is vertical movement.

---

# 🚀 10. Vertical and Horizontal Drag

Sometimes you only care about one direction.

### Horizontal

```dart
GestureDetector(
  onHorizontalDragUpdate: (details) {
    print(details.delta.dx);
  },
  child: Container(
    width: 100,
    height: 100,
  ),
)
```

### Vertical

```dart
GestureDetector(
  onVerticalDragUpdate: (details) {
    print(details.delta.dy);
  },
  child: Container(
    width: 100,
    height: 100,
  ),
)
```

This is useful for interfaces such as:

```text
Horizontal:
<──────────────>

Vertical:
      ↑
      │
      │
      ↓
```

---

# 🧠 11. `onPanUpdate`

`onPanUpdate` detects movement in any direction.

```dart
GestureDetector(
  onPanUpdate: (details) {
    print(details.delta);
  },
  child: Container(
    width: 100,
    height: 100,
  ),
)
```

Conceptually:

```text
          ↑
          │
          │
←─────────┼─────────→
          │
          │
          ↓
```

The pointer can move freely.

---

# 💻 Example: Dragging a Widget

Here's a simple example using `setState`.

```dart
class DragBox extends StatefulWidget {
  const DragBox({super.key});

  @override
  State<DragBox> createState() => _DragBoxState();
}

class _DragBoxState extends State<DragBox> {
  double x = 0;
  double y = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          x += details.delta.dx;
          y += details.delta.dy;
        });
      },
      child: Transform.translate(
        offset: Offset(x, y),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.blue,
        ),
      ),
    );
  }
}
```

The important idea isn't memorizing this code.

Understand the flow:

```text
User drags
    ↓
onPanUpdate
    ↓
details.delta
    ↓
Update x/y
    ↓
setState()
    ↓
Widget rebuilds
    ↓
New position
```

---

# 📍 12. Detecting Tap Position

Sometimes you need to know **where** the user tapped.

Use:

```dart
onTapDown
```

Example:

```dart
GestureDetector(
  onTapDown: (details) {
    print(details.localPosition);
  },
  child: Container(
    width: 300,
    height: 300,
  ),
)
```

`details.localPosition` gives the position relative to the widget.

For example:

```text
Container
┌──────────────────────────┐
│                          │
│        • ← tap           │
│                          │
└──────────────────────────┘
```

You can access:

```dart
details.localPosition.dx
details.localPosition.dy
```

This becomes useful for things such as:

* custom drawing
* interactive maps
* games
* custom controls
* touch-based UI

---

# 🎨 13. `InkWell`

Now we need to introduce another very important widget:

```dart
InkWell
```

`InkWell` detects taps like `GestureDetector`, but it is designed to provide **Material interaction effects**, especially the familiar ripple effect.

Example:

```dart
InkWell(
  onTap: () {
    print('Tapped');
  },
  child: Container(
    padding: const EdgeInsets.all(16),
    child: const Text('Tap me'),
  ),
)
```

When tapped, the user can see a Material ripple effect.

---

# 🧠 14. `GestureDetector` vs `InkWell`

This distinction is extremely important.

| Feature                  | `GestureDetector` | `InkWell`                      |
| ------------------------ | ----------------- | ------------------------------ |
| Detect gestures          | ✅                 | ✅                              |
| Tap detection            | ✅                 | ✅                              |
| Long press               | ✅                 | ✅                              |
| Drag detection           | ✅                 | Limited / not its main purpose |
| Material ripple          | ❌                 | ✅                              |
| Material interaction     | ❌                 | ✅                              |
| General gesture handling | ✅                 | More specialized               |

### Use `GestureDetector` when:

You need general gesture detection.

```dart
GestureDetector(
  onLongPress: ...,
  onPanUpdate: ...,
)
```

### Use `InkWell` when:

You're creating a Material-style tappable UI element.

```dart
InkWell(
  onTap: ...,
  child: ...
)
```

---

# 💡 Professional Rule

Don't automatically use:

```dart
GestureDetector
```

for every clickable UI.

If your intention is:

> "This is a Material button-like surface that should visually respond to taps."

then `InkWell` may communicate that intention better.

For standard buttons, however, prefer Flutter's actual button widgets:

```dart
ElevatedButton
FilledButton
OutlinedButton
TextButton
IconButton
```

rather than manually recreating buttons with `GestureDetector`.

---

# 🏗️ 15. Making a Custom Widget Interactive

One of the powerful things about Flutter is that **almost any widget can become interactive**.

For example:

```dart
GestureDetector(
  onTap: () {
    print('Profile clicked');
  },
  child: const CircleAvatar(
    radius: 40,
  ),
)
```

Now your avatar responds to taps.

Or:

```dart
GestureDetector(
  onTap: () {
    print('Card clicked');
  },
  child: Container(
    padding: const EdgeInsets.all(20),
    child: const Text('Profile'),
  ),
)
```

The general pattern is:

```text
Visual widget
      +
Gesture detector
      ↓
Interactive widget
```

---

# 🔄 16. Gesture Handling with `setState`

Gestures become particularly useful when combined with state.

Example:

```dart
class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          liked = !liked;
        });
      },
      child: Icon(
        liked ? Icons.favorite : Icons.favorite_border,
        size: 40,
      ),
    );
  }
}
```

The flow:

```text
Initial state
liked = false
      ↓
User taps
      ↓
onTap()
      ↓
liked = true
      ↓
setState()
      ↓
build()
      ↓
❤️
```

This is a fundamental Flutter pattern:

> **User interaction changes state → `setState()` tells Flutter to rebuild the affected UI.**

---

# 🔍 17. GestureDetector and Hit Testing

Now let's understand something deeper.

How does Flutter know **which widget was touched**?

It uses **hit testing**.

Imagine:

```text
Screen
│
├── AppBar
│
├── Card
│    └── Text
│
└── Button
```

When the user touches a location:

```text
Touch point
    ↓
Flutter performs hit testing
    ↓
Find widgets that contain the point
    ↓
Gesture system processes the event
    ↓
Recognizes gesture
    ↓
Callback
```

This is why widget size matters.

If your interactive widget occupies a tiny area, the user has a smaller touch target.

---

# 📱 Touch Target Matters

Suppose you have:

```dart
GestureDetector(
  onTap: () {},
  child: const Icon(Icons.close),
)
```

The interactive region may be much smaller than a properly sized button.

For mobile UI, interactive elements should generally have sufficiently large touch targets.

Instead of making only a tiny icon clickable, you might create a larger hit area:

```dart
SizedBox(
  width: 48,
  height: 48,
  child: GestureDetector(
    onTap: () {},
    child: const Icon(Icons.close),
  ),
)
```

This improves usability.

---

# ⚠️ 18. Gesture Conflicts

Sometimes multiple widgets want to respond to the same touch.

For example:

```text
Parent
  │
  └── Child
```

Both might have gesture handlers.

Flutter has a **gesture arena** system to resolve competing gesture recognizers.

Conceptually:

```text
Pointer event
      ↓
Several recognizers compete
      ↓
Gesture Arena
      ↓
Winner determined
      ↓
Winning recognizer receives gesture
```

You don't need to understand every internal detail yet.

But remember:

> **When multiple gesture recognizers compete for the same pointer sequence, Flutter uses its gesture arena system to determine which gesture wins.**

This becomes especially important with:

* nested scrolling
* horizontal vs vertical gestures
* nested `GestureDetector`s
* custom gestures

---

# ⚠️ 19. Common Mistakes

## ❌ Mistake 1 — Using `GestureDetector` for everything

Don't recreate standard buttons unnecessarily.

Instead of:

```dart
GestureDetector(
  onTap: login,
  child: Container(
    child: const Text('Login'),
  ),
)
```

consider:

```dart
ElevatedButton(
  onPressed: login,
  child: const Text('Login'),
)
```

Standard Flutter controls already provide:

* semantics
* accessibility behavior
* Material styling
* interaction states
* appropriate touch behavior

---

## ❌ Mistake 2 — Forgetting `setState()`

Suppose:

```dart
bool liked = false;
```

Then:

```dart
onTap: () {
  liked = !liked;
}
```

The variable changes, but the UI may not rebuild.

For a `StatefulWidget`, you normally need:

```dart
onTap: () {
  setState(() {
    liked = !liked;
  });
}
```

---

## ❌ Mistake 3 — Putting heavy work directly inside gesture callbacks

Avoid doing expensive work like:

```dart
onTap: () {
  // Huge computation
  // Complex synchronous processing
}
```

Gesture callbacks should respond quickly.

If the UI thread is blocked, the application can feel unresponsive.

---

## ❌ Mistake 4 — Creating unnecessarily tiny touch targets

This:

```dart
Icon(Icons.favorite)
```

may look small.

Don't make users hit a tiny visual target if the action is important.

Separate:

```text
Visual size
     ≠
Touch target size
```

A widget can visually contain a small icon while providing a larger interactive area.

---

## ❌ Mistake 5 — Ignoring accessibility

A custom gesture-only UI can be harder for:

* screen readers
* keyboard users
* users with motor difficulties

Standard Flutter controls often provide better semantics automatically.

When creating custom interactive widgets, think about accessibility as well as appearance.

---

# 🚀 20. Professional Best Practices

### 1. Prefer semantic widgets

Use:

```dart
ElevatedButton
FilledButton
TextButton
IconButton
Checkbox
Switch
Slider
```

when they represent the interaction you need.

Don't recreate them unnecessarily with `GestureDetector`.

---

### 2. Use `GestureDetector` for custom gestures

Good examples:

```text
Drag
Pan
Long press
Custom touch interaction
Interactive canvas
Game controls
```

---

### 3. Use `InkWell` for Material surfaces

If you have:

```text
Card
List item
Custom Material surface
```

and want a ripple interaction:

```dart
InkWell(
  onTap: ...,
)
```

can be appropriate.

---

### 4. Keep gesture callbacks simple

Good:

```dart
onTap: () {
  setState(() {
    selected = true;
  });
}
```

For complex logic:

```dart
onTap: _handleSelection,
```

and:

```dart
void _handleSelection() {
  // Logic
}
```

This keeps `build()` easier to read.

---

### 5. Think about the user experience

Don't ask only:

> "Can I detect this gesture?"

Also ask:

> "Is this gesture obvious to the user?"

For example, hiding an important action behind a long press may not be discoverable.

Good UI makes interactions understandable.

---

# 💻 21. Real-World Example

Let's build a simple interactive profile card.

```dart
class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      onLongPress: () {
        print('Profile long pressed');
      },
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected
              ? Colors.blue.shade100
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? Colors.blue
                : Colors.grey,
          ),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              child: Icon(Icons.person),
            ),
            SizedBox(height: 12),
            Text(
              'Flutter Developer',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Learning Flutter and building amazing apps.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
```

The interaction architecture is:

```text
ProfileCard
     │
     ├── onTap
     │     ↓
     │   selected changes
     │     ↓
     │   setState()
     │
     └── onLongPress
           ↓
        additional action
```

This is a small example of how interaction and state work together.

---

# 🧪 22. Practice

## 🟢 Beginner — Tap Counter

Build:

```text
┌──────────────────────────┐
│                          │
│           0              │
│                          │
│       [ Tap Me ]         │
│                          │
└──────────────────────────┘
```

Every tap should increase the number:

```text
0 → 1 → 2 → 3 → 4 → ...
```

Requirements:

* `StatefulWidget`
* `GestureDetector`
* `onTap`
* `setState`

---

## 🟢 Beginner — Interactive Icon

Create an icon:

```dart
Icons.favorite_border
```

When tapped, change it to:

```dart
Icons.favorite
```

Tap again to switch it back.

---

## 🟡 Intermediate — Long Press Menu

Create a profile card.

Requirements:

* Normal tap → print `"Profile opened"`
* Long press → show a menu or dialog
* Use `GestureDetector`

---

## 🟡 Intermediate — Draggable Box

Create:

```text
┌──────────────────────────────┐
│                              │
│       ┌───────┐              │
│       │ BOX   │              │
│       └───────┘              │
│                              │
└──────────────────────────────┘
```

Allow the user to drag the box around the screen.

Use:

```dart
onPanUpdate
```

and:

```dart
setState()
```

---

# 🔴 Challenge — Interactive Card

Build a card that supports:

### Single tap

```text
Select card
```

### Double tap

```text
Like card
```

### Long press

```text
Show options
```

### Visual state

When selected:

```text
Border changes
Background changes
```

Your architecture should look roughly like:

```text
InteractiveCard
      │
      ├── onTap
      │
      ├── onDoubleTap
      │
      ├── onLongPress
      │
      └── State
           │
           ├── selected
           └── liked
```

---

# 🧠 23. Knowledge Check

Before moving forward, make sure you can explain:

1. What is a gesture?
2. What is `GestureDetector`?
3. What does `onTap` do?
4. What is the difference between `onTap`, `onDoubleTap`, and `onLongPress`?
5. What is `onPanUpdate`?
6. What is `details.delta`?
7. What is the difference between `dx` and `dy`?
8. What does `onTapDown` provide?
9. What is `localPosition`?
10. What is `InkWell`?
11. What is the difference between `GestureDetector` and `InkWell`?
12. When should you use a standard button instead of `GestureDetector`?
13. What is hit testing?
14. What is the gesture arena?
15. Why might `setState()` be necessary after a gesture?
16. Why are touch targets important?
17. Why shouldn't gesture callbacks perform expensive synchronous work?
18. How would you implement a draggable widget?
19. How would you detect a double tap?
20. How would you make a custom widget accessible?

---

# 📌 24. Quick Reference

## Tap

```dart
GestureDetector(
  onTap: () {
    // Action
  },
  child: ...,
)
```

## Double Tap

```dart
GestureDetector(
  onDoubleTap: () {
    // Action
  },
  child: ...,
)
```

## Long Press

```dart
GestureDetector(
  onLongPress: () {
    // Action
  },
  child: ...,
)
```

## Pan

```dart
GestureDetector(
  onPanUpdate: (details) {
    final dx = details.delta.dx;
    final dy = details.delta.dy;
  },
  child: ...,
)
```

## Horizontal Drag

```dart
GestureDetector(
  onHorizontalDragUpdate: (details) {
    final dx = details.delta.dx;
  },
  child: ...,
)
```

## Vertical Drag

```dart
GestureDetector(
  onVerticalDragUpdate: (details) {
    final dy = details.delta.dy;
  },
  child: ...,
)
```

## Tap Position

```dart
GestureDetector(
  onTapDown: (details) {
    final position = details.localPosition;
  },
  child: ...,
)
```

## Material Ripple

```dart
InkWell(
  onTap: () {
    // Action
  },
  child: ...,
)
```

---

# 🎯 25. Key Takeaways

> **`GestureDetector` detects gestures; it does not provide visual styling.**

> **`InkWell` provides Material-style interaction feedback such as ripple effects.**

> **Use standard Flutter controls whenever they already represent the interaction you need.**

> **Use `GestureDetector` when you need custom gesture behavior.**

> **Gestures often change state, and state changes usually require rebuilding the UI.**

The fundamental interaction model to remember is:

```text
User interaction
       ↓
Pointer events
       ↓
Hit testing
       ↓
Gesture recognition
       ↓
Callback
       ↓
State / Business logic
       ↓
UI update
```

And the most important professional principle:

> **Don't just make an interface clickable. Design interactions that are discoverable, accessible, responsive, and appropriate for the user's intent.**

---

## 🗺️ Roadmap Position

You have now covered the current topic:

```text
Phase 2 — Flutter Fundamentals

...
13. ListView          ✅
14. GridView           ✅
15. Buttons            ✅
16. Text fields        ✅
17. Forms              ✅
18. Gestures           ✅  ← Current
19. Custom widgets     ⏭️  Next
```

The roadmap places **Custom widgets** immediately after **Gestures**, so that is the next topic. 
