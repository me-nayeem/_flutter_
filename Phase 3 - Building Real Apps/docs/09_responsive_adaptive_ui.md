# 🟢 Phase 3 — Building Complete Apps

# 9. Responsive & Adaptive UI

> **Goal:** Learn how to build Flutter interfaces that work properly across different screen sizes, orientations, and device types instead of designing for only one fixed screen.

A UI that looks perfect on your laptop or emulator may look terrible on:

* A small phone
* A large phone
* A tablet
* A foldable device
* Landscape orientation

Professional Flutter development requires you to think in terms of **available space**, not specific devices.

---

# 🧠 1. What Is Responsive UI?

**Responsive UI** means the layout responds to the available screen space.

For example:

```text
Small screen

┌──────────────┐
│   Product    │
│    Image     │
│              │
│    Title     │
│    Price     │
└──────────────┘
```

On a larger screen:

```text
┌──────────────────────────────────┐
│                                  │
│   Image      │   Title           │
│              │   Price            │
│              │   Description      │
│              │   [Buy Now]        │
└──────────────────────────────────┘
```

The content is the same, but the **layout adapts to the available space**.

---

# 🧠 2. Responsive vs Adaptive

These terms are related but not identical.

### Responsive

The UI adjusts its **size and layout** based on available space.

```text
Small width → smaller layout
Large width → larger layout
```

### Adaptive

The UI may use a **different interaction or layout structure** depending on the environment.

For example:

```text
Phone
    ↓
Bottom navigation

Tablet/Desktop
    ↓
Navigation rail/sidebar
```

Think:

```text
Responsive
    ↓
"How should this layout fit?"

Adaptive
    ↓
"What layout/interaction is appropriate here?"
```

Professional Flutter applications often use both.

---

# 3. Why Responsive Design Matters

Avoid designing like this:

```dart
Container(
  width: 400,
  height: 600,
)
```

That might look fine on one device.

But what happens when:

```text
Screen width = 320
```

Your layout may overflow.

Instead, think:

```text
Available width
      ↓
How much space do I have?
      ↓
How should my widgets use it?
```

---

# 4. Flutter's Layout Philosophy

Flutter doesn't primarily ask:

> "What device am I running on?"

Instead, its layout system is based heavily on:

> **Constraints go down, sizes go up, parent sets position.**

A simplified model:

```text
Parent
  │
  │ constraints
  ▼
Child
  │
  │ chooses size
  ▼
Parent
  │
  │ positions child
  ▼
Final layout
```

Understanding constraints is one of the most important skills in Flutter.

---

# 5. The Most Important Question

When building a responsive UI, ask:

> **How much space does this widget actually have?**

This is much more useful than asking:

> "Is this an iPhone or Android?"

For example:

```text
Available width = 360
```

might require:

```text
Column
```

while:

```text
Available width = 900
```

might allow:

```text
Row
```

---

# 6. `MediaQuery`

One of the most common tools for responsive design is:

```dart
MediaQuery
```

You can access it through:

```dart
MediaQuery.of(context)
```

For example:

```dart
final size = MediaQuery.sizeOf(context);
```

Then:

```dart
size.width
size.height
```

Example:

```dart
final width = MediaQuery.sizeOf(context).width;

print(width);
```

This tells you the current available screen size information.

---

# 7. Using Screen Width

Suppose you want a container to use half the screen:

```dart
final width = MediaQuery.sizeOf(context).width;

Container(
  width: width * 0.5,
)
```

If the screen is:

```text
360 px
```

then:

```text
360 × 0.5 = 180
```

If the screen is:

```text
800 px
```

then:

```text
800 × 0.5 = 400
```

The widget naturally changes with the available width.

---

# 8. Avoid Excessive `MediaQuery`

A common beginner pattern is:

```dart
width: MediaQuery.sizeOf(context).width * 0.8,
height: MediaQuery.sizeOf(context).height * 0.2,
```

everywhere.

This can become difficult to maintain.

Why?

Because the parent widget may already know the available constraints.

That's where:

```dart
LayoutBuilder
```

becomes extremely useful.

---

# 9. `LayoutBuilder`

`LayoutBuilder` gives you the constraints available to its child.

Example:

```dart
LayoutBuilder(
  builder: (context, constraints) {
    print(constraints.maxWidth);

    return Container();
  },
)
```

You can inspect:

```dart
constraints.maxWidth
constraints.maxHeight
constraints.minWidth
constraints.minHeight
```

---

# 10. `MediaQuery` vs `LayoutBuilder`

This distinction is extremely important.

### `MediaQuery`

Think:

> "What is the overall screen/window information?"

```dart
MediaQuery.sizeOf(context).width
```

### `LayoutBuilder`

Think:

> "How much space does this particular widget's parent give me?"

```dart
constraints.maxWidth
```

Conceptually:

```text
MediaQuery
    ↓
Overall available window/screen

LayoutBuilder
    ↓
Available space for this subtree
```

---

# 11. Simple `LayoutBuilder` Example

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) {
      return const Text('Small layout');
    }

    return const Text('Large layout');
  },
)
```

Now the UI can change based on available width.

---

# 12. Breakpoints

A **breakpoint** is a width at which your layout changes.

For example:

```text
< 600
    ↓
Mobile layout

600–900
    ↓
Tablet layout

> 900
    ↓
Large layout
```

Example:

```dart
if (constraints.maxWidth < 600) {
  return const MobileLayout();
} else {
  return const LargeLayout();
}
```

The exact breakpoint depends on your design.

Don't blindly assume that `600` is always correct.

---

# 13. A Better Way to Think About Breakpoints

Don't start with:

> "Phone = 600."

Instead start with:

> "At what width does my current layout stop being usable?"

For example:

```text
One-column layout
      ↓
Still comfortable
      ↓
Content starts becoming cramped
      ↓
Switch to two-column layout
```

That width becomes a useful breakpoint.

This is a more professional approach.

---

# 14. Responsive Row → Column

One of the most common patterns:

### Small width

```text
┌───────────────┐
│     Image     │
├───────────────┤
│     Text      │
└───────────────┘
```

### Large width

```text
┌──────────┬───────────────┐
│          │               │
│  Image   │     Text      │
│          │               │
└──────────┴───────────────┘
```

Implementation:

```dart
LayoutBuilder(
  builder: (context, constraints) {
    final isSmall = constraints.maxWidth < 600;

    if (isSmall) {
      return const Column(
        children: [
          ProductImage(),
          ProductDetails(),
        ],
      );
    }

    return const Row(
      children: [
        Expanded(
          child: ProductImage(),
        ),
        Expanded(
          child: ProductDetails(),
        ),
      ],
    );
  },
)
```

This is real responsive layout logic.

---

# 15. Responsive Grid

Suppose you have products.

On a phone:

```text
┌───────┬───────┐
│ Item  │ Item  │
├───────┼───────┤
│ Item  │ Item  │
└───────┴───────┘
```

On a tablet:

```text
┌────┬────┬────┬────┐
│ 1  │ 2  │ 3  │ 4  │
├────┼────┼────┼────┤
│ 5  │ 6  │ 7  │ 8  │
└────┴────┴────┴────┘
```

A useful widget is:

```dart
GridView
```

with:

```dart
SliverGridDelegateWithFixedCrossAxisCount
```

or:

```dart
SliverGridDelegateWithMaxCrossAxisExtent
```

---

# 16. `SliverGridDelegateWithMaxCrossAxisExtent`

For responsive grids, this is often convenient.

Example:

```dart
GridView.builder(
  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 250,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
  ),
  itemBuilder: (context, index) {
    return ProductCard(
      product: products[index],
    );
  },
)
```

Flutter can determine how many columns fit based on the available width.

This is often more flexible than manually specifying:

```dart
crossAxisCount: 2
```

for every screen size.

---

# 17. Fixed Cross Axis Count

You can also use:

```dart
SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
)
```

For example:

```dart
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
  ),
  itemBuilder: (context, index) {
    return const Card();
  },
)
```

This is fine when you intentionally want a fixed number of columns.

---

# 18. `Expanded` and Responsive Layout

You already learned:

```dart
Expanded
Flexible
```

These are fundamental to responsive Flutter layouts.

For example:

```dart
Row(
  children: [
    Expanded(
      child: Container(),
    ),
    Expanded(
      child: Container(),
    ),
  ],
)
```

The available width is divided between the children.

Conceptually:

```text
Available width
      │
 ┌────┴────┐
 ▼         ▼
 50%       50%
```

This is generally better than:

```dart
width: 180
```

when you want proportional layouts.

---

# 19. Flexible Proportions

You can use flex values:

```dart
Row(
  children: [
    Expanded(
      flex: 2,
      child: Container(),
    ),
    Expanded(
      flex: 1,
      child: Container(),
    ),
  ],
)
```

The space is divided:

```text
2 : 1
```

Conceptually:

```text
┌──────────────────────┬──────────┐
│                      │          │
│       2 parts        │ 1 part   │
│                      │          │
└──────────────────────┴──────────┘
```

This is useful for responsive proportions.

---

# 20. `SafeArea`

Responsive design isn't only about width.

You also need to consider:

* Status bars
* Notches
* Camera cutouts
* System navigation areas

Flutter provides:

```dart
SafeArea
```

Example:

```dart
SafeArea(
  child: Scaffold(
    body: ...
  ),
)
```

Or more commonly, depending on your structure:

```dart
Scaffold(
  body: SafeArea(
    child: ...
  ),
)
```

`SafeArea` adds appropriate padding to avoid system UI intrusions.

---

# 21. Why `SafeArea` Matters

Without appropriate safe-area handling:

```text
┌──────────────┐
│ Camera/notch │
├──────────────┤
│   Your UI    │
│              │
```

Your content could overlap system areas.

With `SafeArea`:

```text
┌──────────────┐
│ Camera/notch │
├──────────────┤
│              │
│   Your UI    │
│              │
```

Flutter handles the system padding for you.

---

# 22. Orientation

Devices can rotate.

```text
Portrait

┌────────┐
│        │
│        │
│        │
└────────┘
```

Landscape:

```text
┌──────────────────┐
│                  │
│                  │
└──────────────────┘
```

Your layout should not assume portrait orientation unless the application specifically requires it.

---

# 23. Detecting Orientation

You can use:

```dart
MediaQuery.orientationOf(context)
```

For example:

```dart
final orientation = MediaQuery.orientationOf(context);

if (orientation == Orientation.portrait) {
  // Portrait layout
} else {
  // Landscape layout
}
```

But don't automatically create separate layouts just because orientation changes.

Often a properly responsive layout naturally handles both orientations.

---

# 24. Orientation vs Width

In many situations, width is more useful than orientation.

Why?

Consider a large tablet in portrait:

```text
Portrait
width = 800
```

It may have more usable width than a small phone in landscape:

```text
Landscape
width = 640
```

Therefore:

```text
orientation ≠ exact layout capability
```

Use actual constraints when possible.

---

# 25. Avoid Fixed Widths

Avoid:

```dart
Container(
  width: 500,
)
```

when the widget needs to work across different screens.

Prefer:

```dart
SizedBox(
  width: double.infinity,
  child: ...
)
```

or:

```dart
Expanded(
  child: ...
)
```

or use constraints.

---

# 26. But Fixed Dimensions Aren't Always Bad

This is important.

Don't misunderstand responsive design as:

> "Never use fixed dimensions."

Fixed dimensions can be completely appropriate:

```dart
Icon(
  Icons.favorite,
  size: 24,
)
```

or:

```dart
SizedBox(
  height: 16,
)
```

The problem is **unnecessary rigid layouts**.

For example:

```dart
Container(
  width: 390,
  height: 844,
)
```

is usually a bad idea.

---

# 27. `ConstrainedBox`

You can control minimum and maximum dimensions.

Example:

```dart
ConstrainedBox(
  constraints: const BoxConstraints(
    maxWidth: 500,
  ),
  child: const LoginForm(),
)
```

This is extremely useful for tablets and large screens.

Imagine a login form on a huge monitor.

Without constraints:

```text
┌─────────────────────────────────────────────┐
│                                             │
│     [ very wide login form ]                │
│                                             │
└─────────────────────────────────────────────┘
```

With:

```dart
maxWidth: 500
```

you can keep the form readable:

```text
┌─────────────────────────────────────────────┐
│                                             │
│            ┌──────────────┐                 │
│            │ Login Form   │                 │
│            │              │                 │
│            └──────────────┘                 │
│                                             │
└─────────────────────────────────────────────┘
```

---

# 28. `FractionallySizedBox`

Another useful widget:

```dart
FractionallySizedBox
```

Example:

```dart
FractionallySizedBox(
  widthFactor: 0.8,
  child: const LoginForm(),
)
```

The child uses:

```text
80% of available width
```

This can be useful for simple proportional layouts.

---

# 29. Centering Content on Large Screens

A common professional pattern:

```dart
Center(
  child: ConstrainedBox(
    constraints: const BoxConstraints(
      maxWidth: 600,
    ),
    child: const LoginForm(),
  ),
)
```

On a phone:

```text
┌──────────────┐
│ Login Form   │
│              │
└──────────────┘
```

On a large screen:

```text
┌──────────────────────────────────┐
│                                  │
│        ┌──────────────┐          │
│        │  Login Form  │          │
│        └──────────────┘          │
│                                  │
└──────────────────────────────────┘
```

This is a very useful pattern for web, desktop, and tablet layouts.

---

# 30. Responsive Padding

Avoid blindly doing:

```dart
padding: const EdgeInsets.all(32),
```

everywhere.

Sometimes:

```dart
EdgeInsets.symmetric(
  horizontal: constraints.maxWidth < 600 ? 16 : 32,
)
```

may be appropriate.

But don't make every value dynamically calculated.

Good responsive design is about meaningful layout changes, not mathematical complexity.

---

# 31. Responsive Navigation

A common adaptive pattern:

### Mobile

```text
┌──────────────┐
│              │
│   Content    │
│              │
├──────────────┤
│ Home Search  │
└──────────────┘
```

### Large screen

```text
┌──────┬───────────────────┐
│ Home │                   │
│Search│     Content       │
│Profile│                  │
└──────┴───────────────────┘
```

The interaction model changes.

This is **adaptive UI**.

The appropriate Flutter widget may be:

```text
NavigationBar
```

for compact layouts and:

```text
NavigationRail
```

for larger layouts.

---

# 32. Responsive App Architecture

Avoid putting all responsive logic inside one enormous `build()` method.

❌:

```dart
if (width < 500) {
  // 200 lines
} else {
  // 300 lines
}
```

Instead:

```dart
if (width < 600) {
  return const MobileHomePage();
}

return const TabletHomePage();
```

Then:

```text
HomePage
 ├── MobileHomePage
 └── TabletHomePage
```

This keeps your code understandable.

---

# 33. Reusable Breakpoint Helper

As your application grows, you might define:

```dart
abstract final class Breakpoints {
  static const mobile = 600.0;
  static const tablet = 900.0;
}
```

Then:

```dart
if (constraints.maxWidth < Breakpoints.mobile) {
  ...
}
```

This avoids magic numbers scattered throughout your application.

---

# 34. Avoid "Magic Numbers"

Instead of:

```dart
if (width < 600) {}
```

everywhere:

```dart
if (width < Breakpoints.mobile) {}
```

is clearer.

The same idea applies to other reusable design values.

This becomes especially useful when we later discuss architecture and design systems.

---

# 35. A Practical Responsive Helper

You could create:

```dart
enum DeviceType {
  mobile,
  tablet,
  desktop,
}
```

Then:

```dart
DeviceType getDeviceType(double width) {
  if (width < 600) {
    return DeviceType.mobile;
  }

  if (width < 900) {
    return DeviceType.tablet;
  }

  return DeviceType.desktop;
}
```

Then:

```dart
final deviceType = getDeviceType(
  constraints.maxWidth,
);
```

This can make larger applications easier to reason about.

Don't introduce abstractions like this too early, though. Start simple.

---

# 36. Responsive Text

Don't make every text size proportional to screen width:

```dart
fontSize: width * 0.08
```

This can produce unreasonable sizes.

Instead, use your:

```dart
TextTheme
```

and make intentional adjustments at meaningful breakpoints if needed.

For example:

```dart
final textStyle = constraints.maxWidth < 600
    ? theme.textTheme.headlineSmall
    : theme.textTheme.headlineMedium;
```

---

# 37. Responsive Images

Images should generally respect their available constraints.

For example:

```dart
AspectRatio(
  aspectRatio: 16 / 9,
  child: Image.asset(
    'assets/images/banner.jpg',
    fit: BoxFit.cover,
  ),
)
```

This maintains a consistent aspect ratio while allowing the width to adapt.

---

# 38. `AspectRatio`

`AspectRatio` is very useful for responsive UI.

Example:

```dart
AspectRatio(
  aspectRatio: 16 / 9,
  child: Container(
    color: Colors.grey,
  ),
)
```

If the width becomes:

```text
320
```

the height adjusts automatically.

If the width becomes:

```text
800
```

the height adjusts accordingly.

Conceptually:

```text
Width changes
     ↓
Height recalculates
     ↓
Aspect ratio remains constant
```

---

# 39. Responsive Cards

A product card might use:

```dart
AspectRatio(
  aspectRatio: 1.5,
  child: Image.asset(
    'assets/images/product.png',
    fit: BoxFit.cover,
  ),
)
```

Then below:

```dart
Text(product.name)
Text(product.price)
```

This helps prevent arbitrary image heights from breaking your layout.

---

# 40. Common Responsive Mistakes

## ❌ Mistake 1 — Designing for one device

Testing only on:

```text
One emulator
```

doesn't guarantee responsiveness.

---

## ❌ Mistake 2 — Too many fixed widths

```dart
width: 350
```

everywhere can cause overflow.

---

## ❌ Mistake 3 — Using screen width everywhere

Don't automatically use:

```dart
MediaQuery.sizeOf(context).width
```

for every dimension.

Sometimes the widget's local constraints are what matter.

---

## ❌ Mistake 4 — Too many breakpoints

You don't need:

```text
320
360
400
440
480
520
...
```

Start with a small number of meaningful layout states.

---

## ❌ Mistake 5 — Using device type instead of constraints

Don't assume:

```text
Android → mobile layout
iPad → tablet layout
```

The same application can run in resizable windows.

Think in terms of available space.

---

## ❌ Mistake 6 — Forgetting text overflow

Long text can break layouts.

Consider:

```dart
Text(
  product.name,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
```

---

# 🧠 41. Professional Mental Model

When building responsive Flutter UI, think:

```text
              Available Space
                     │
                     ▼
                Constraints
                     │
          ┌──────────┴──────────┐
          ▼                     ▼
      Small space           Large space
          │                     │
          ▼                     ▼
    Compact layout        Expanded layout
          │                     │
          └──────────┬──────────┘
                     ▼
                User Interface
```

Don't think:

```text
"I am designing for a 6-inch phone."
```

Think:

```text
"I am designing for this amount of available space."
```

That mindset will make your Flutter layouts much more robust.

---

# 📊 42. Quick Reference

### Screen size

```dart
final size = MediaQuery.sizeOf(context);
```

### Screen width

```dart
final width = MediaQuery.sizeOf(context).width;
```

### Orientation

```dart
final orientation = MediaQuery.orientationOf(context);
```

### Local constraints

```dart
LayoutBuilder(
  builder: (context, constraints) {
    return ...;
  },
)
```

### Maximum width

```dart
constraints.maxWidth
```

### Responsive condition

```dart
if (constraints.maxWidth < 600) {
  return const MobileLayout();
}

return const LargeLayout();
```

### Safe area

```dart
SafeArea(
  child: ...
)
```

### Maximum content width

```dart
ConstrainedBox(
  constraints: const BoxConstraints(
    maxWidth: 600,
  ),
  child: ...,
)
```

### Maintain aspect ratio

```dart
AspectRatio(
  aspectRatio: 16 / 9,
  child: ...,
)
```

### Responsive grid

```dart
SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 250,
)
```

---

# 🧪 43. Practice Project

Take your previous **Profile Screen** and make it responsive.

### Mobile

Design:

```text
┌──────────────┐
│    Banner    │
│              │
│   Profile    │
│     Name     │
│      Bio     │
│    Buttons   │
└──────────────┘
```

### Large screen

Change it to:

```text
┌─────────────────────────────────┐
│                                 │
│   Profile    │     Information  │
│    Image     │     Name         │
│              │     Bio          │
│              │     Buttons      │
│                                 │
└─────────────────────────────────┘
```

Use:

* `LayoutBuilder`
* `Expanded`
* `ConstrainedBox`
* `AspectRatio`
* `SafeArea`
* `TextTheme`
* `ColorScheme`

### ⭐ Challenge

Make the navigation adaptive:

```text
Small width
    ↓
NavigationBar

Large width
    ↓
NavigationRail
```

Don't create separate applications. Build **one Flutter application that adapts its UI**.

---

# 🎯 What You Should Know After This Lesson

You should be able to explain:

* Responsive UI
* Adaptive UI
* Constraints
* `MediaQuery`
* `LayoutBuilder`
* `MediaQuery` vs `LayoutBuilder`
* Breakpoints
* Responsive `Row` / `Column`
* Responsive grids
* `Expanded` and `Flexible`
* `SafeArea`
* Orientation
* `ConstrainedBox`
* `FractionallySizedBox`
* `AspectRatio`
* Responsive navigation
* Responsive typography
* Avoiding unnecessary fixed dimensions
* Avoiding magic numbers
* Designing based on available space

---

# 🏁 Key Takeaway

The most important concept from this lesson is:

> **Don't design for devices. Design for available space.**

Instead of:

```text
"If Android → this layout"
"If iPhone → that layout"
```

think:

```text
Available space
      ↓
Constraints
      ↓
Choose appropriate layout
```

For example:

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) {
      return const MobileLayout();
    }

    return const LargeLayout();
  },
)
```

And remember the difference:

```text
MediaQuery
    ↓
Overall screen/window information

LayoutBuilder
    ↓
Space available to this widget
```

> **A professional Flutter UI isn't one that looks perfect on your development device. It's one that remains usable and visually coherent when the available space changes.**

---

## ⏭️ Next Topic

### **10. Debugging**

We'll learn how to systematically find and fix Flutter problems instead of randomly changing code.

We'll cover:

* Flutter error messages
* Reading stack traces
* Debug console
* `print()` and `debugPrint()`
* Breakpoints
* Debugger
* Flutter DevTools
* Widget Inspector
* Layout overflow errors
* `BuildContext` mistakes
* State-related bugs
* Common Flutter exceptions
* Debugging performance problems
* A professional debugging workflow
