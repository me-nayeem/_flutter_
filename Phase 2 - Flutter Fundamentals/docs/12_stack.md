# 🟢 Phase 2 — Topic 12: `Stack`

> **`Stack` is a Flutter layout widget used when you want widgets to overlap each other or position children relative to the edges of a parent.**

According to our roadmap, `Stack` comes directly after `Expanded / Flexible` and before `ListView`. 

---

# 📚 Table of Contents

* [1. What is Stack?](#-1-what-is-stack)
* [2. Why Does Stack Exist?](#-2-why-does-stack-exist)
* [3. Basic Stack Example](#-3-basic-stack-example)
* [4. Stack's Most Important Concept: Overlapping](#-4-stacks-most-important-concept-overlapping)
* [5. How Stack Positions Children](#-5-how-stack-positions-children)
* [6. Paint Order and Z-Order](#-6-paint-order-and-z-order)
* [7. Positioned](#-7-positioned)
* [8. Positioned Properties](#-8-positioned-properties)
* [9. top, bottom, left, right](#-9-top-bottom-left-right)
* [10. Centering with Positioned](#-10-centering-with-positioned)
* [11. Width and Height with Positioned](#-11-width-and-height-with-positioned)
* [12. Using Alignment](#-12-using-alignment)
* [13. StackFit](#-13-stackfit)
* [14. clipBehavior](#-14-clipbehavior)
* [15. Non-Positioned vs Positioned Children](#-15-non-positioned-vs-positioned-children)
* [16. Real-World Example: Profile Avatar](#-16-real-world-example-profile-avatar)
* [17. Real-World Example: Notification Badge](#-17-real-world-example-notification-badge)
* [18. Real-World Example: Image Overlay](#-18-real-world-example-image-overlay)
* [19. Real-World Example: Gradient Overlay](#-19-real-world-example-gradient-overlay)
* [20. Stack vs Column vs Row](#-20-stack-vs-column-vs-row)
* [21. Stack vs Positioned](#-21-stack-vs-positioned)
* [22. Common Mistakes](#-22-common-mistakes)
* [23. Stack and Constraints](#-23-stack-and-constraints)
* [24. Responsive Design Considerations](#-24-responsive-design-considerations)
* [25. Professional Best Practices](#-25-professional-best-practices)
* [26. Practice](#-26-practice)
* [27. Knowledge Check](#-27-knowledge-check)
* [28. Quick Reference](#-28-quick-reference)
* [29. Key Takeaways](#-29-key-takeaways)

---

# 📚 1. What is `Stack`?

`Stack` is a widget that allows its children to be **placed on top of one another**.

Unlike:

```dart
Row(...)
```

which arranges widgets horizontally,

or:

```dart
Column(...)
```

which arranges widgets vertically,

`Stack` allows widgets to occupy the **same area**.

### Simple mental model

```text
Row
→ "Put things beside each other."

Column
→ "Put things above/below each other."

Stack
→ "Put things on top of each other."
```

---

# 💡 2. Why Does `Stack` Exist?

Consider a profile picture with a small online indicator:

```text
       ┌─────────────┐
       │             │
       │    👤       │
       │             │
       └───────────●─┘
                   ↑
              online badge
```

The avatar and the badge occupy overlapping areas.

A `Column` doesn't naturally express this.

A `Row` doesn't naturally express this.

A `Stack` does.

Another example:

```text
┌─────────────────────────────┐
│                             │
│        Background Image     │
│                             │
│     ┌───────────────────┐   │
│     │      Text         │   │
│     └───────────────────┘   │
│                             │
└─────────────────────────────┘
```

Again:

> **Background + overlay = perfect use case for `Stack`.**

---

# 💻 3. Basic `Stack` Example

```dart
Stack(
  children: [
    Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    ),

    Container(
      width: 100,
      height: 100,
      color: Colors.red,
    ),
  ],
)
```

Conceptually:

```text
┌──────────────────────┐
│                      │
│    ┌──────────┐      │
│    │   Red    │      │
│    │          │      │
│    └──────────┘      │
│                      │
└──────────────────────┘
       Blue
```

The red container is placed **on top of** the blue container.

---

# 🧠 4. Stack's Most Important Concept: Overlapping

This is the fundamental idea:

```dart
Stack(
  children: [
    Widget A,
    Widget B,
    Widget C,
  ],
)
```

Think of it like layers:

```text
           ┌───────────┐
           │  Widget C │  ← top layer
           └───────────┘
        ┌─────────────────┐
        │    Widget B     │  ← middle layer
        └─────────────────┘
     ┌─────────────────────────┐
     │        Widget A         │  ← bottom layer
     └─────────────────────────┘
```

This makes `Stack` especially useful for:

* badges
* overlays
* image labels
* profile status indicators
* floating elements
* custom UI decorations
* cards with overlays
* image + text combinations
* loading overlays

---

# 🔍 5. How `Stack` Positions Children

There are two important categories of children inside a `Stack`:

### 1. Non-positioned children

Example:

```dart
Stack(
  children: [
    Container(),
    Text('Hello'),
  ],
)
```

These children participate in the normal `Stack` sizing/alignment behavior.

---

### 2. Positioned children

Example:

```dart
Stack(
  children: [
    Container(),

    Positioned(
      top: 10,
      right: 10,
      child: Text('Hello'),
    ),
  ],
)
```

`Positioned` gives you explicit control over where the child is placed.

This distinction is extremely important:

```text
Stack
│
├── Non-positioned child
│
└── Positioned child
        │
        ├── top
        ├── bottom
        ├── left
        └── right
```

---

# 🟢 6. Paint Order and Z-Order

Another extremely important concept:

> **Later children are painted on top of earlier children.**

Consider:

```dart
Stack(
  children: [
    Container(
      color: Colors.blue,
    ),

    Container(
      color: Colors.red,
    ),
  ],
)
```

The second container is painted after the first.

So:

```text
Blue → bottom
Red  → top
```

Think:

```text
children[0] → back
children[1] → middle
children[2] → front
...
```

For example:

```dart
Stack(
  children: [
    background,
    middleLayer,
    foreground,
  ],
)
```

This is a very useful way to mentally model `Stack`.

---

# 📌 7. `Positioned`

`Positioned` is one of the most important widgets you'll learn with `Stack`.

It allows you to specify where a child should be placed relative to the `Stack`.

Example:

```dart
Stack(
  children: [
    Container(
      width: 300,
      height: 200,
      color: Colors.blue,
    ),

    Positioned(
      top: 20,
      left: 20,
      child: Text('Hello'),
    ),
  ],
)
```

Conceptually:

```text
┌──────────────────────────────┐
│  Hello                       │
│                              │
│                              │
│                              │
└──────────────────────────────┘
 ↑
 20 px from top
 20 px from left
```

---

# 🔧 8. `Positioned` Properties

The most important properties are:

```dart
Positioned(
  top: ...,
  bottom: ...,
  left: ...,
  right: ...,
  width: ...,
  height: ...,
  child: ...,
)
```

They describe the child's relationship to the `Stack`.

---

# 📐 9. `top`, `bottom`, `left`, `right`

## `top`

```dart
Positioned(
  top: 20,
  child: Text('Hello'),
)
```

Means:

> Place the child 20 logical pixels from the top edge.

---

## `bottom`

```dart
Positioned(
  bottom: 20,
  child: Text('Hello'),
)
```

Means:

> Place the child 20 logical pixels from the bottom edge.

---

## `left`

```dart
Positioned(
  left: 20,
  child: Text('Hello'),
)
```

Means:

> Place the child 20 logical pixels from the left edge.

---

## `right`

```dart
Positioned(
  right: 20,
  child: Text('Hello'),
)
```

Means:

> Place the child 20 logical pixels from the right edge.

---

# 🎯 10. Centering with `Positioned`

You can use combinations of positioning properties.

For example:

```dart
Positioned(
  left: 0,
  right: 0,
  child: Text('Hello'),
)
```

This constrains the child between the left and right edges.

But if your goal is simply to center a widget, don't unnecessarily use `Positioned`.

A cleaner solution is often:

```dart
Stack(
  alignment: Alignment.center,
  children: [
    Container(
      width: 300,
      height: 200,
      color: Colors.blue,
    ),

    Text('Hello'),
  ],
)
```

Result:

```text
┌──────────────────────────────┐
│                              │
│                              │
│           Hello              │
│                              │
│                              │
└──────────────────────────────┘
```

### Professional rule

> **Use `alignment` when you want general alignment. Use `Positioned` when you need explicit edge-based positioning.**

---

# 📏 11. Width and Height with `Positioned`

You can specify:

```dart
Positioned(
  top: 20,
  left: 20,
  width: 100,
  height: 50,
  child: Container(
    color: Colors.red,
  ),
)
```

Conceptually:

```text
Stack
┌──────────────────────────────┐
│                              │
│ ┌──────────────┐             │
│ │              │             │
│ │     Red      │ 100 × 50    │
│ │              │             │
│ └──────────────┘             │
│                              │
└──────────────────────────────┘
```

### Important

You should understand the relationship between:

```text
left + right
```

and:

```text
width
```

For example:

```dart
Positioned(
  left: 20,
  right: 20,
  child: ...
)
```

effectively tells Flutter:

> "Stay 20 pixels from both sides."

The available width is then determined from the Stack's width.

Similarly:

```dart
Positioned(
  top: 20,
  bottom: 20,
  child: ...
)
```

determines the vertical space available to the child.

---

# 🎨 12. Using `alignment`

`Stack` has an:

```dart
alignment
```

property.

Example:

```dart
Stack(
  alignment: Alignment.center,
  children: [
    Container(
      width: 300,
      height: 200,
      color: Colors.blue,
    ),

    Text(
      'Hello',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ],
)
```

You can use:

```dart
Alignment.topLeft
Alignment.topCenter
Alignment.topRight

Alignment.centerLeft
Alignment.center
Alignment.centerRight

Alignment.bottomLeft
Alignment.bottomCenter
Alignment.bottomRight
```

This is very similar to the alignment concept you learned with `Container`.

---

# 🔍 13. `StackFit`

`Stack` also has a:

```dart
fit
```

property.

For example:

```dart
Stack(
  fit: StackFit.expand,
  children: [
    ...
  ],
)
```

The important values are:

```dart
StackFit.loose
StackFit.expand
StackFit.passthrough
```

---

## `StackFit.loose`

This is the default.

Non-positioned children receive loose constraints based on the Stack's constraints.

Think:

> "Children can choose a size within the available space."

---

## `StackFit.expand`

```dart
Stack(
  fit: StackFit.expand,
  children: [
    ...
  ],
)
```

Non-positioned children are constrained to fill the Stack's available space.

This is particularly useful for background layers.

For example:

```dart
Stack(
  fit: StackFit.expand,
  children: [
    Image.asset(
      'assets/background.jpg',
      fit: BoxFit.cover,
    ),

    Center(
      child: Text('Welcome'),
    ),
  ],
)
```

Conceptually:

```text
┌──────────────────────────────┐
│                              │
│      Background Image        │
│                              │
│          Welcome             │
│                              │
└──────────────────────────────┘
```

---

# ✂️ 14. `clipBehavior`

`Stack` has a:

```dart
clipBehavior
```

property.

It determines whether overflowing content is clipped.

Example:

```dart
Stack(
  clipBehavior: Clip.none,
  children: [
    ...
  ],
)
```

With:

```dart
Clip.none
```

a child can visually extend outside the Stack's bounds.

This is useful for designs such as:

```text
          ●
          ↑
      badge outside
   ┌──────────────┐
   │              │
   │    Avatar    │
   │              │
   └──────────────┘
```

But be careful.

Allowing overflow doesn't mean the child can interact outside the Stack in every possible way. Painting, hit testing, and clipping are separate concepts.

---

# 🧠 15. Non-Positioned vs Positioned Children

This distinction is worth memorizing.

Consider:

```dart
Stack(
  children: [
    Container(),
    
    Positioned(
      top: 10,
      right: 10,
      child: Icon(Icons.close),
    ),
  ],
)
```

### `Container`

Non-positioned.

It participates in Stack's normal sizing/alignment behavior.

### `Positioned`

Positioned.

It is explicitly placed using Stack-relative coordinates.

Think:

```text
Stack
│
├── normal child
│      ↓
│   Stack alignment
│
└── Positioned child
       ↓
    top/right/etc.
```

---

# 👤 16. Real-World Example — Profile Avatar

This is one of the most common `Stack` patterns.

```dart
Stack(
  children: [
    const CircleAvatar(
      radius: 40,
      child: Icon(
        Icons.person,
        size: 40,
      ),
    ),

    Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
    ),
  ],
)
```

Conceptually:

```text
        ┌───────────────┐
        │               │
        │      👤       │
        │               │
        │           ●   │
        └───────────────┘
                    ↑
                 online
```

Widget tree:

```text
Stack
├── CircleAvatar
└── Positioned
    └── Container
```

This is a very professional and reusable pattern.

---

# 🔔 17. Real-World Example — Notification Badge

Suppose you want:

```text
       🔔
        ● 5
```

You can create:

```dart
Stack(
  clipBehavior: Clip.none,
  children: [
    const Icon(
      Icons.notifications,
      size: 32,
    ),

    Positioned(
      top: -5,
      right: -5,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: const Text(
          '5',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ),
    ),
  ],
)
```

Notice:

```dart
clipBehavior: Clip.none
```

allows the badge to extend outside the icon's normal bounds.

---

# 🖼️ 18. Real-World Example — Image Overlay

A very common UI:

```text
┌──────────────────────────────┐
│                              │
│        Beautiful Image       │
│                              │
│                              │
│   Flutter Development        │
│   Learn Flutter step by step │
└──────────────────────────────┘
```

Implementation:

```dart
Stack(
  children: [
    Image.network(
      imageUrl,
      width: double.infinity,
      height: 250,
      fit: BoxFit.cover,
    ),

    Positioned(
      left: 16,
      bottom: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Flutter Development',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Learn Flutter step by step',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  ],
)
```

This pattern appears everywhere:

* news apps
* movie apps
* social media
* e-commerce
* travel apps
* portfolio apps

---

# 🌑 19. Real-World Example — Gradient Overlay

A professional image card often uses a gradient to make text readable.

```dart
Stack(
  children: [
    Image.network(
      imageUrl,
      width: double.infinity,
      height: 250,
      fit: BoxFit.cover,
    ),

    Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black54,
            ],
          ),
        ),
      ),
    ),

    const Positioned(
      left: 16,
      bottom: 16,
      child: Text(
        'Flutter Development',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
)
```

Notice something new:

```dart
Positioned.fill
```

---

# ⭐ `Positioned.fill`

`Positioned.fill` is a convenience constructor.

Conceptually:

```dart
Positioned(
  top: 0,
  right: 0,
  bottom: 0,
  left: 0,
  child: ...
)
```

So:

```dart
Positioned.fill(
  child: ...
)
```

means:

> **Fill the available Stack area.**

This is extremely useful for overlays.

---

# ⚖️ 20. Stack vs Column vs Row

It's important to understand that these widgets solve different layout problems.

| Widget       | Main Purpose                      |
| ------------ | --------------------------------- |
| `Row`        | Horizontal layout                 |
| `Column`     | Vertical layout                   |
| `Stack`      | Overlapping/layered layout        |
| `Expanded`   | Flexible space inside Flex        |
| `Flexible`   | Flexible child inside Flex        |
| `Positioned` | Explicit positioning inside Stack |

Think:

```text
Row
 ↓
Side by side

Column
 ↓
Top to bottom

Stack
 ↓
Layered / overlapping
```

---

# 🔄 21. Stack vs Positioned

These two are often confused.

### `Stack`

Creates the **layering environment**.

```dart
Stack(
  children: [
    ...
  ],
)
```

### `Positioned`

Controls the position of a child **inside that Stack**.

```dart
Positioned(
  top: 10,
  right: 10,
  child: ...
)
```

You normally use them together:

```dart
Stack(
  children: [
    Background(),
    
    Positioned(
      top: 10,
      right: 10,
      child: Badge(),
    ),
  ],
)
```

Mental model:

```text
Stack
→ "These widgets can overlap."

Positioned
→ "Put this particular widget here."
```

---

# ⚠️ 22. Common Mistakes

## ❌ Mistake 1 — Using `Positioned` outside `Stack`

This is incorrect:

```dart
Column(
  children: [
    Positioned(
      top: 10,
      child: Text('Hello'),
    ),
  ],
)
```

`Positioned` is intended to be a child of `Stack`.

Correct:

```dart
Stack(
  children: [
    Positioned(
      top: 10,
      child: Text('Hello'),
    ),
  ],
)
```

---

## ❌ Mistake 2 — Using Stack for everything

Don't replace:

```dart
Row
Column
Padding
Align
```

with `Stack`.

For example, don't build a normal vertical layout using dozens of `Positioned` widgets.

Bad approach:

```dart
Stack(
  children: [
    Positioned(top: 20, left: 20, child: Text('Name')),
    Positioned(top: 60, left: 20, child: Text('Email')),
    Positioned(top: 100, left: 20, child: Text('Phone')),
  ],
)
```

This can become fragile.

A better solution is often:

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Name'),
    Text('Email'),
    Text('Phone'),
  ],
)
```

### Professional principle

> **Use Stack for relationships that are genuinely layered or overlapping—not as a replacement for normal layout widgets.**

---

# ❌ Mistake 3 — Hardcoding coordinates everywhere

For example:

```dart
Positioned(
  left: 137,
  top: 286,
  child: ...
)
```

This may work on one screen size but break on another.

Remember:

> **Flutter apps run on many screen sizes and aspect ratios.**

Prefer relationships such as:

```dart
right: 16
```

or:

```dart
bottom: 16
```

rather than arbitrary absolute coordinates.

---

# ❌ Mistake 4 — Ignoring constraints

Consider:

```dart
Stack(
  children: [
    Positioned(
      left: 0,
      right: 0,
      child: ...
    ),
  ],
)
```

You need to understand whether the Stack itself has a meaningful width.

If its parent doesn't give it useful constraints, the result may not be what you expect.

This is another reason why Flutter's layout principle matters:

> **Constraints go down → sizes go up → parents set positions.**

---

# ❌ Mistake 5 — Forgetting paint order

Suppose:

```dart
Stack(
  children: [
    Text('TOP'),
    Container(color: Colors.white),
  ],
)
```

The white Container comes later.

It may paint over the text.

So if you want:

```text
Background
   ↓
Overlay
   ↓
Text
```

the children should normally be ordered:

```dart
Stack(
  children: [
    background,
    overlay,
    text,
  ],
)
```

---

# 🔍 23. Stack and Constraints

Now let's connect `Stack` to the layout system.

Remember:

> **Constraints go down → sizes go up → parents set positions.**

For `Stack`:

```text
Parent
  │
  │ constraints
  ▼
Stack
  │
  ├── non-positioned child
  │
  └── positioned child
```

The Stack determines its own size based on its constraints and its non-positioned children.

Then it lays out positioned children relative to its own size.

This is why `Positioned` values such as:

```dart
top: 20
right: 20
```

make sense only after the Stack has a meaningful size.

---

# 🧠 Stack's Layout Mental Model

Think of `Stack` as a coordinate/layer system:

```text
Stack
┌─────────────────────────────────┐
│                                 │
│   (0,0)                         │
│      ↓                          │
│      ┌──────────────┐           │
│      │   Widget     │           │
│      └──────────────┘           │
│                                 │
│                        (right)  │
│                              ↓  │
└─────────────────────────────────┘
```

`Positioned` tells Flutter how the child's position relates to the Stack's edges.

---

# 📱 24. Responsive Design Considerations

This is extremely important.

Suppose you design:

```dart
Positioned(
  left: 100,
  top: 200,
  child: Text('Hello'),
)
```

It might look good on:

```text
Phone A
```

but not:

```text
Phone B
Tablet
Landscape
Desktop
```

Instead, prefer relative relationships.

### Better

```dart
Positioned(
  right: 16,
  bottom: 16,
  child: ...
)
```

This keeps the element consistently positioned relative to the edge.

For more complex responsive layouts, you can combine `Stack` with:

```dart
LayoutBuilder
MediaQuery
FractionallySizedBox
Align
Positioned.fill
```

We'll study responsive/adaptive UI later in the roadmap.

---

# 🚀 25. Professional Best Practices

## 1. Use Stack for layering

Good:

```dart
Stack(
  children: [
    image,
    gradient,
    text,
  ],
)
```

---

## 2. Keep the layer order intentional

Think:

```text
Layer 1 → background
Layer 2 → overlay
Layer 3 → content
Layer 4 → controls
```

---

## 3. Prefer edge relationships

Prefer:

```dart
right: 16
bottom: 16
```

over:

```dart
left: 237
top: 381
```

when building responsive UI.

---

## 4. Use `Positioned.fill` for full overlays

Instead of:

```dart
Positioned(
  left: 0,
  right: 0,
  top: 0,
  bottom: 0,
  child: ...
)
```

use:

```dart
Positioned.fill(
  child: ...
)
```

It's clearer and communicates intent.

---

## 5. Don't make the entire UI a Stack

Use the simplest layout widget that expresses the relationship.

```text
Side-by-side → Row

Vertical → Column

Spacing → Padding / SizedBox

Flexible → Expanded / Flexible

Layering → Stack

Explicit layer position → Positioned
```

---

# 🧪 26. Practice

## 🟢 Beginner — Two Overlapping Containers

Create:

```text
┌─────────────────────────┐
│                         │
│     ┌────────────┐      │
│     │    Red     │      │
│     └────────────┘      │
│          ┌────────────┐ │
│          │   Blue     │ │
│          └────────────┘ │
│                         │
└─────────────────────────┘
```

Requirements:

* Use `Stack`
* Use two `Container`s
* Make them overlap

---

## 🟢 Beginner — Centered Text

Create:

```text
┌─────────────────────────┐
│                         │
│                         │
│       Hello Flutter     │
│                         │
│                         │
└─────────────────────────┘
```

Requirements:

* Use `Stack`
* Use `alignment: Alignment.center`

---

## 🟡 Intermediate — Notification Badge

Create:

```text
        🔔
       ┌───┐
       │ 5 │
       └───┘
```

Requirements:

* `Icon`
* `Stack`
* `Positioned`
* badge should sit at the top-right
* use `Clip.none` if necessary

---

## 🟡 Intermediate — Profile Avatar

Build:

```text
      ┌───────────┐
      │           │
      │     👤    │
      │           │
      │        ●  │
      └───────────┘
```

Requirements:

* `CircleAvatar`
* `Stack`
* `Positioned`
* green status indicator
* white border around indicator

---

# 🔴 Advanced Challenge — Image Card

Build:

```text
┌─────────────────────────────────┐
│                                 │
│          IMAGE                  │
│                                 │
│                                 │
│                                 │
│  Flutter Development            │
│  Master Flutter step by step    │
└─────────────────────────────────┘
```

Requirements:

* Background image
* Image should cover the available area
* Gradient overlay
* Title at bottom-left
* Subtitle below title
* Use `Stack`
* Use `Positioned`
* Use `Positioned.fill`
* Avoid hardcoded screen width

---

# 🧪 Challenge: Predict the Output

What will be on top?

```dart
Stack(
  children: [
    Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    ),

    Container(
      width: 150,
      height: 150,
      color: Colors.red,
    ),

    Container(
      width: 100,
      height: 100,
      color: Colors.green,
    ),
  ],
)
```

Think carefully.

The answer is:

```text
Green
  ↓
Red
  ↓
Blue
```

because later children are painted over earlier children.

---

# 🧠 27. Knowledge Check

Before moving forward, make sure you can answer:

1. What problem does `Stack` solve?
2. How is `Stack` different from `Row`?
3. How is `Stack` different from `Column`?
4. What does overlapping mean in Flutter layout?
5. What is a non-positioned child?
6. What is a positioned child?
7. What does `Positioned` do?
8. What do `top`, `bottom`, `left`, and `right` mean?
9. What happens when multiple children overlap?
10. Which child appears on top?
11. What does `Stack.alignment` do?
12. What is `StackFit.loose`?
13. What is `StackFit.expand`?
14. What does `clipBehavior` control?
15. Why might you use `Clip.none`?
16. What is `Positioned.fill`?
17. Why shouldn't you use `Stack` for every layout?
18. Why can hardcoded `top`/`left` coordinates cause responsive-layout problems?
19. How does `Stack` relate to Flutter's constraint system?
20. When should you choose `Stack` instead of `Row` or `Column`?

---

# 📌 28. Quick Reference

## Basic Stack

```dart
Stack(
  children: [
    background,
    foreground,
  ],
)
```

---

## Center children

```dart
Stack(
  alignment: Alignment.center,
  children: [
    background,
    foreground,
  ],
)
```

---

## Position a child

```dart
Stack(
  children: [
    background,

    Positioned(
      top: 16,
      right: 16,
      child: foreground,
    ),
  ],
)
```

---

## Fill the Stack

```dart
Stack(
  children: [
    background,

    Positioned.fill(
      child: overlay,
    ),
  ],
)
```

---

## Allow visual overflow

```dart
Stack(
  clipBehavior: Clip.none,
  children: [
    ...
  ],
)
```

---

## Proportional/edge-based positioning

```dart
Positioned(
  left: 16,
  right: 16,
  bottom: 16,
  child: ...
)
```

---

# 🎯 29. Key Takeaways

The most important things to remember:

### `Stack`

> **Use `Stack` when widgets need to overlap or exist as layers.**

### `Positioned`

> **Use `Positioned` when you need to explicitly place a child relative to the Stack's edges.**

### `alignment`

> **Use `alignment` when you want to position non-positioned children according to a general alignment.**

### Paint order

> **Later children are painted on top of earlier children.**

### `Positioned.fill`

> **Use it when a positioned child should fill the Stack.**

### `clipBehavior`

> **Controls whether overflowing content is clipped.**

---

# 🧠 Final Mental Model

You should now be able to visualize a `Stack` like this:

```text
                         STACK
┌─────────────────────────────────────────┐
│                                         │
│   Layer 1: Background                   │
│   ┌─────────────────────────────────┐   │
│   │                                 │   │
│   │   Layer 2: Overlay              │   │
│   │   ┌─────────────────────────┐   │   │
│   │   │                         │   │   │
│   │   │ Layer 3: Content        │   │   │
│   │   │                         │   │   │
│   │   └─────────────────────────┘   │   │
│   │                                 │   │
│   └─────────────────────────────────┘   │
│                                         │
│                          ┌──────────┐   │
│                          │ Positioned│   │
│                          │  Badge    │   │
│                          └──────────┘   │
│                                         │
└─────────────────────────────────────────┘
```

And the professional decision tree:

```text
What relationship do my widgets have?
              │
      ┌───────┼────────┐
      │       │        │
   Beside   Above/   Overlap/
    each    below     layers
    other    each      │
      │       other    │
      ▼       ▼        ▼
     Row    Column   Stack
                         │
                         ▼
                 Need explicit
                   positioning?
                         │
                    ┌────┴────┐
                   Yes        No
                    │          │
                    ▼          ▼
                Positioned   alignment
```

> **Professional takeaway:** Don't think of `Stack` as simply "a widget that lets things overlap." Think of it as a **layered layout system** where children are painted in order, non-positioned children establish normal layout behavior, and `Positioned` children can be placed relative to the Stack's boundaries.

Once you understand this model, building **badges, overlays, profile indicators, image cards, floating controls, and layered UI** becomes much more natural.
