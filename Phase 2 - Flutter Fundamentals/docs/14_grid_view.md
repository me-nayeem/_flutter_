# 🟢 Phase 2 — Topic 14: `GridView`

> **`GridView` is Flutter's scrollable widget for displaying children in a two-dimensional grid.**

According to the roadmap, `GridView` comes immediately after `ListView` in Phase 2. 

If `ListView` is for:

```text
Item 1
Item 2
Item 3
Item 4
```

then `GridView` is for:

```text
┌──────────┐  ┌──────────┐
│ Item 1   │  │ Item 2   │
└──────────┘  └──────────┘

┌──────────┐  ┌──────────┐
│ Item 3   │  │ Item 4   │
└──────────┘  └──────────┘

┌──────────┐  ┌──────────┐
│ Item 5   │  │ Item 6   │
└──────────┘  └──────────┘
```

This is extremely common in real applications for:

* Product catalogs
* Photo galleries
* Movie collections
* Category grids
* Dashboards
* App menus
* Game items
* E-commerce screens

---

# 📚 Table of Contents

1. [What is GridView?](#-1-what-is-gridview)
2. [Why do we need GridView?](#-2-why-do-we-need-gridview)
3. [GridView vs ListView](#-3-gridview-vs-listview)
4. [Basic GridView](#-4-basic-gridview)
5. [GridView.count](#-5-gridviewcount)
6. [Understanding crossAxisCount](#-6-understanding-crossaxiscount)
7. [GridView.builder](#-7-gridviewbuilder)
8. [Why builder matters](#-8-why-builder-matters)
9. [GridView.extent](#-9-gridviewextent)
10. [GridView.custom](#-10-gridviewcustom)
11. [Spacing](#-11-spacing)
12. [childAspectRatio](#-12-childaspectratio)
13. [mainAxisSpacing vs crossAxisSpacing](#-13-mainaxisspacing-vs-crossaxisspacing)
14. [Padding](#-14-padding)
15. [Horizontal GridView](#-15-horizontal-gridview)
16. [GridView inside Column](#-16-gridview-inside-column)
17. [shrinkWrap](#-17-shrinkwrap)
18. [Nested GridView](#-18-nested-gridview)
19. [Real-world Product Grid](#-19-real-world-product-grid)
20. [GridView and Responsive UI](#-20-gridview-and-responsive-ui)
21. [Common Mistakes](#-21-common-mistakes)
22. [Professional Best Practices](#-22-professional-best-practices)
23. [Practice](#-23-practice)
24. [Knowledge Check](#-24-knowledge-check)
25. [Quick Reference](#-25-quick-reference)
26. [Key Takeaways](#-26-key-takeaways)

---

# 📚 1. What is `GridView`?

`GridView` is a **scrollable grid layout**.

Unlike `ListView`, which primarily arranges children along one axis, `GridView` arranges children into rows and columns.

For example:

```dart
GridView.count(
  crossAxisCount: 2,
  children: [
    Text('Item 1'),
    Text('Item 2'),
    Text('Item 3'),
    Text('Item 4'),
  ],
)
```

Conceptually:

```text
┌──────────────┐
│ Item 1       │ Item 2
│              │
├──────────────┤
│ Item 3       │ Item 4
│              │
└──────────────┘
```

---

# 💡 2. Why Do We Need `GridView`?

Imagine you're building an e-commerce application.

You have:

```text
Laptop
Phone
Keyboard
Mouse
Monitor
Headphones
Camera
Tablet
```

A vertical list would look like:

```text
Laptop
Phone
Keyboard
Mouse
Monitor
Headphones
Camera
Tablet
```

But for products, you may want:

```text
┌────────────┐ ┌────────────┐
│   Laptop   │ │   Phone    │
│    $1200   │ │    $800    │
└────────────┘ └────────────┘

┌────────────┐ ┌────────────┐
│  Keyboard  │ │   Mouse    │
│     $80    │ │     $40    │
└────────────┘ └────────────┘
```

That's exactly what `GridView` is designed for.

---

# 🆚 3. `GridView` vs `ListView`

| Feature            | `ListView` | `GridView`     |
| ------------------ | ---------- | -------------- |
| Vertical list      | ✅          | ✅              |
| Horizontal list    | ✅          | ✅              |
| Multiple columns   | ❌          | ✅              |
| Grid layout        | ❌          | ✅              |
| Product catalog    | Possible   | Excellent      |
| Photo gallery      | Possible   | Excellent      |
| Large dynamic data | `builder`  | `builder`      |
| Lazy building      | ✅          | ✅ with builder |

Think:

```text
ListView
    ↓
One-dimensional sequence

GridView
    ↓
Two-dimensional visual arrangement
```

---

# 💻 4. Basic `GridView`

The simplest version is:

```dart
GridView(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
  ),
  children: [
    Container(color: Colors.red),
    Container(color: Colors.blue),
    Container(color: Colors.green),
    Container(color: Colors.orange),
  ],
)
```

This creates:

```text
┌───────────┬───────────┐
│           │           │
│   RED     │   BLUE    │
│           │           │
├───────────┼───────────┤
│           │           │
│   GREEN   │  ORANGE   │
│           │           │
└───────────┴───────────┘
```

There are two important concepts here:

```dart
GridView
```

and:

```dart
SliverGridDelegateWithFixedCrossAxisCount
```

Don't let the name intimidate you.

We'll break it down.

---

# 🧠 5. `GridView.count`

For simple grids, Flutter provides a convenient constructor:

```dart
GridView.count(
  crossAxisCount: 2,
  children: [
    Container(color: Colors.red),
    Container(color: Colors.blue),
    Container(color: Colors.green),
    Container(color: Colors.orange),
  ],
)
```

This is much easier to read.

### Result

```text
┌────────────┐ ┌────────────┐
│    RED     │ │    BLUE    │
└────────────┘ └────────────┘

┌────────────┐ ┌────────────┐
│   GREEN    │ │   ORANGE   │
└────────────┘ └────────────┘
```

---

# 🧠 6. Understanding `crossAxisCount`

This is one of the **most important GridView properties**.

```dart
crossAxisCount: 2
```

means:

> Put **2 items across the cross axis**.

For a normal vertical grid:

```text
          Cross Axis
        ←────────────→

       Column  Column
         1       2

       ┌─────┐ ┌─────┐
       │  1  │ │  2  │
       └─────┘ └─────┘

       ┌─────┐ ┌─────┐
       │  3  │ │  4  │
       └─────┘ └─────┘
             ↓
          Main Axis
```

So:

```dart
crossAxisCount: 2
```

means:

```text
2 columns
```

---

## `crossAxisCount: 3`

```dart
GridView.count(
  crossAxisCount: 3,
  children: [
    ...
  ],
)
```

Result:

```text
┌──────┐ ┌──────┐ ┌──────┐
│  1   │ │  2   │ │  3   │
└──────┘ └──────┘ └──────┘

┌──────┐ ┌──────┐ ┌──────┐
│  4   │ │  5   │ │  6   │
└──────┘ └──────┘ └──────┘
```

---

## `crossAxisCount: 4`

```text
┌────┐ ┌────┐ ┌────┐ ┌────┐
│ 1  │ │ 2  │ │ 3  │ │ 4  │
└────┘ └────┘ └────┘ └────┘

┌────┐ ┌────┐ ┌────┐ ┌────┐
│ 5  │ │ 6  │ │ 7  │ │ 8  │
└────┘ └────┘ └────┘ └────┘
```

So:

```text
crossAxisCount: 2 → 2 columns
crossAxisCount: 3 → 3 columns
crossAxisCount: 4 → 4 columns
```

---

# 🚀 7. `GridView.builder`

This is the **most important GridView constructor for real applications**.

Instead of manually creating:

```dart
GridView.count(
  crossAxisCount: 2,
  children: [
    ProductCard(...),
    ProductCard(...),
    ProductCard(...),
    ProductCard(...),
  ],
)
```

you can use:

```dart
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
  ),
  itemCount: products.length,
  itemBuilder: (context, index) {
    return ProductCard(
      product: products[index],
    );
  },
)
```

This is the grid equivalent of:

```dart
ListView.builder(...)
```

---

# 🧠 8. Why `builder` Matters

Suppose you have:

```text
100 products
```

or:

```text
10,000 products
```

You don't want to manually construct every widget unnecessarily.

`GridView.builder` allows Flutter to construct grid children lazily as needed for the scrolling viewport.

Mental model:

```text
ListView.builder
       ↓
Lazy vertical list


GridView.builder
       ↓
Lazy grid
```

This is why you should become very comfortable with:

```dart
GridView.builder
```

---

# 💻 Complete Example

```dart
final products = [
  'Laptop',
  'Phone',
  'Keyboard',
  'Mouse',
  'Monitor',
  'Headphones',
];

GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
  ),
  itemCount: products.length,
  itemBuilder: (context, index) {
    return Card(
      child: Center(
        child: Text(products[index]),
      ),
    );
  },
)
```

Result:

```text
┌────────────────┐ ┌────────────────┐
│                │ │                │
│     Laptop     │ │      Phone     │
│                │ │                │
└────────────────┘ └────────────────┘

┌────────────────┐ ┌────────────────┐
│                │ │                │
│    Keyboard    │ │      Mouse     │
│                │ │                │
└────────────────┘ └────────────────┘

┌────────────────┐ ┌────────────────┐
│    Monitor     │ │   Headphones   │
└────────────────┘ └────────────────┘
```

---

# 🟡 9. `GridView.extent`

Another useful constructor is:

```dart
GridView.extent(
  maxCrossAxisExtent: 200,
  children: [
    ...
  ],
)
```

Instead of saying:

> "I want exactly 2 columns."

you say:

> "Each item should be no wider than approximately 200 logical pixels."

Flutter then determines how many columns can fit.

For example:

```dart
GridView.extent(
  maxCrossAxisExtent: 200,
  children: [
    ...
  ],
)
```

This can be particularly useful for responsive layouts.

---

# 🧠 `count` vs `extent`

### Fixed number of columns

```dart
GridView.count(
  crossAxisCount: 2,
)
```

You control:

> **How many columns?**

### Maximum item width

```dart
GridView.extent(
  maxCrossAxisExtent: 200,
)
```

You control:

> **How wide can each grid item be?**

This distinction becomes very useful for responsive UI.

---

# 🟡 10. `GridView.custom`

Just like `ListView`, `GridView` also has a lower-level constructor:

```dart
GridView.custom(...)
```

It allows more direct control over the children delegate.

Example:

```dart
GridView.custom(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
  ),
  childrenDelegate: SliverChildBuilderDelegate(
    (context, index) {
      return Text('Item $index');
    },
    childCount: 20,
  ),
)
```

You don't need this often at your current level.

For now, focus on:

```text
GridView.count
GridView.extent
GridView.builder
```

---

# 📏 11. Spacing

A professional UI almost always needs spacing between grid items.

You can use:

```dart
mainAxisSpacing: 10,
crossAxisSpacing: 10,
```

Example:

```dart
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
  ),
  itemCount: products.length,
  itemBuilder: (context, index) {
    return Card(
      child: Center(
        child: Text(products[index]),
      ),
    );
  },
)
```

---

# 🧠 12. `childAspectRatio`

This is another **very important GridView property**.

Consider:

```dart
childAspectRatio: 1,
```

This means approximately:

```text
width : height = 1 : 1
```

So the item is roughly square:

```text
┌──────────────┐
│              │
│              │
│              │
└──────────────┘
```

---

## `childAspectRatio: 2`

```dart
childAspectRatio: 2,
```

means approximately:

```text
width : height = 2 : 1
```

So:

```text
┌──────────────────────┐
│                      │
└──────────────────────┘
```

The item is wider than it is tall.

---

## `childAspectRatio: 0.7`

```dart
childAspectRatio: 0.7,
```

The item becomes taller than it is wide.

```text
┌──────────┐
│          │
│          │
│          │
│          │
└──────────┘
```

---

# 🧠 Professional Understanding of `childAspectRatio`

Don't memorize random values like:

```text
0.7
1.2
1.5
```

Instead ask:

> **What visual shape should each grid item have?**

For example:

### Photo gallery

```text
1 : 1
```

Use something around:

```dart
childAspectRatio: 1,
```

### Product card

```text
Width > Height
```

Maybe:

```dart
childAspectRatio: 0.8,
```

depending on the design.

The correct value comes from your desired layout, not from a universal rule.

---

# 📐 13. `mainAxisSpacing` vs `crossAxisSpacing`

This is a common source of confusion.

For a normal vertical grid:

```text
        crossAxis
    ←──────────────→

┌────────┐   ┌────────┐
│        │   │        │
│   1    │   │   2    │
│        │   │        │
└────────┘   └────────┘
      ↑
      │
 crossAxisSpacing


       ↓ main axis

┌────────┐
│   1    │
└────────┘
     ↕
mainAxisSpacing
     ↕
┌────────┐
│   3    │
└────────┘
```

### `crossAxisSpacing`

Space **between columns**.

```dart
crossAxisSpacing: 10,
```

### `mainAxisSpacing`

Space **between rows**.

```dart
mainAxisSpacing: 10,
```

For a normal vertical grid:

```text
crossAxisSpacing → horizontal gap
mainAxisSpacing   → vertical gap
```

---

# 📦 14. Padding

Just like `ListView`, `GridView` can have padding:

```dart
GridView.builder(
  padding: const EdgeInsets.all(16),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
  ),
  itemCount: products.length,
  itemBuilder: (context, index) {
    return Card(
      child: Center(
        child: Text(products[index]),
      ),
    );
  },
)
```

Conceptually:

```text
Screen
┌──────────────────────────────┐
│  ← padding                   │
│                              │
│   ┌───────┐   ┌───────┐      │
│   │       │   │       │      │
│   │   1   │   │   2   │      │
│   └───────┘   └───────┘      │
│                              │
│   ┌───────┐   ┌───────┐      │
│   │   3   │   │   4   │      │
│   └───────┘   └───────┘      │
│                              │
└──────────────────────────────┘
```

A common professional pattern is:

```dart
padding: const EdgeInsets.all(16),
```

combined with:

```dart
crossAxisSpacing: 12,
mainAxisSpacing: 12,
```

---

# ↔️ 15. Horizontal `GridView`

`GridView` can also scroll horizontally.

For example:

```dart
GridView.builder(
  scrollDirection: Axis.horizontal,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
  ),
  itemCount: 20,
  itemBuilder: (context, index) {
    return Card(
      child: Center(
        child: Text('Item $index'),
      ),
    );
  },
)
```

Now the scrolling direction is:

```text
→ → → → → → →
```

The meaning of the axes changes accordingly.

This is another reason to understand:

```text
main axis
cross axis
```

rather than memorizing:

> "`mainAxisSpacing` always means vertical."

It doesn't.

It depends on the scroll direction.

---

# ⚠️ 16. GridView inside `Column`

Just like `ListView`, a `GridView` inside a `Column` can have an unbounded-height problem.

Problematic:

```dart
Column(
  children: [
    const Text('Products'),

    GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
        );
      },
    ),
  ],
)
```

A common solution when the grid should occupy the remaining space:

```dart
Column(
  children: [
    const Text('Products'),

    Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
          );
        },
      ),
    ),
  ],
)
```

Mental model:

```text
Column
│
├── Header
│
└── Expanded
      │
      └── GridView
```

This is the same layout principle you learned with `ListView`.

---

# ⚠️ 17. `shrinkWrap`

You can also write:

```dart
GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  ...
)
```

This can be useful when the grid is inside another scrollable and the **outer scrollable** should own scrolling.

For example:

```text
SingleChildScrollView
│
├── Header
│
├── Some content
│
└── GridView
       │
       └── no independent scrolling
```

But remember:

> **Don't use `shrinkWrap: true` as a universal fix.**

For large grids, measuring the full extent can be more expensive than using a normally constrained scrollable.

Always understand **why the grid needs to shrink-wrap**.

---

# ⚠️ 18. Nested GridView

Be careful with:

```text
GridView
   ↓
GridView
```

or:

```text
ListView
   ↓
GridView
```

or:

```text
SingleChildScrollView
   ↓
GridView
```

These aren't automatically wrong, but they create questions about:

* Who owns scrolling?
* What constraints does the child receive?
* Does the inner grid need to scroll?
* Should `shrinkWrap` be used?
* Is there a better single-scrollable architecture?

For more complex scrolling screens, Flutter's sliver system becomes important:

```text
CustomScrollView
├── SliverAppBar
├── SliverList
└── SliverGrid
```

You will learn these later when you are ready for advanced Flutter.

---

# 🛒 19. Real-World Product Grid

Let's build something closer to production UI.

First, imagine the data:

```dart
final products = [
  {
    'name': 'Laptop',
    'price': '\$1200',
  },
  {
    'name': 'Keyboard',
    'price': '\$80',
  },
  {
    'name': 'Mouse',
    'price': '\$40',
  },
  {
    'name': 'Monitor',
    'price': '\$300',
  },
];
```

Now:

```dart
GridView.builder(
  padding: const EdgeInsets.all(16),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 0.8,
  ),
  itemCount: products.length,
  itemBuilder: (context, index) {
    final product = products[index];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.image,
                    size: 50,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              product['name']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(product['price']!),
          ],
        ),
      ),
    );
  },
)
```

The structure is:

```text
GridView.builder
│
├── ProductCard
├── ProductCard
├── ProductCard
└── ProductCard
```

And each product card contains:

```text
Card
│
└── Padding
     │
     └── Column
          ├── Image area
          ├── Product name
          └── Price
```

This is exactly the kind of composition you should become comfortable with.

---

# 🧠 Important: `Expanded` Inside Grid Items

Notice this:

```dart
Expanded(
  child: Container(...),
)
```

inside the `Column` of each product card.

Why?

Because we want the image area to consume the available remaining vertical space while the product name and price retain their natural size.

The item becomes conceptually:

```text
┌─────────────────────┐
│                     │
│      IMAGE AREA     │
│                     │
│                     │
├─────────────────────┤
│ Laptop              │
│ $1200               │
└─────────────────────┘
```

This connects your previous topics:

```text
Column
   +
Expanded
   +
Container
   +
GridView
```

You are now beginning to combine individual Flutter layout concepts into real UI.

---

# 📱 20. GridView and Responsive UI

Here's an important professional consideration.

Suppose you have:

```dart
crossAxisCount: 2
```

On a phone:

```text
┌───────────────┐
│ ┌────┐ ┌────┐ │
│ │ 1  │ │ 2  │ │
│ └────┘ └────┘ │
└───────────────┘
```

That's fine.

But on a large tablet:

```text
┌──────────────────────────────────────┐
│ ┌────┐ ┌────┐                        │
│ │ 1  │ │ 2  │                        │
│ └────┘ └────┘                        │
│                                      │
└──────────────────────────────────────┘
```

You may be wasting a lot of horizontal space.

A professional developer asks:

> **Should the number of columns adapt to available width?**

This is where `GridView.extent`, `LayoutBuilder`, and responsive design techniques become valuable.

For example:

```dart
GridView.extent(
  maxCrossAxisExtent: 250,
  children: [
    ...
  ],
)
```

can allow the grid to adapt naturally.

Later, when you study **responsive/adaptive UI**, you'll build much more sophisticated solutions.

---

# 🧠 `GridView.count` vs `GridView.extent`

A useful mental model:

```text
GridView.count
      ↓
"I decide the number of columns."

GridView.extent
      ↓
"I decide the maximum item width."
```

Example:

### Phone

```text
2 columns
```

### Tablet

```text
3 columns
```

### Desktop

```text
4–6 columns
```

With a width-based approach, Flutter can determine how many fit.

---

# ⚠️ 21. Common Mistakes

## ❌ Mistake 1 — Forgetting `gridDelegate`

With `GridView.builder`, you need to tell Flutter how the grid should be laid out.

For example:

```dart
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
),
```

Without a grid delegate, Flutter doesn't know how to arrange the children.

---

## ❌ Mistake 2 — Confusing `crossAxisCount`

Remember:

```dart
crossAxisCount: 2
```

means:

```text
2 columns
```

for a normal vertically scrolling grid.

---

## ❌ Mistake 3 — Using a fixed `crossAxisCount` everywhere

This:

```dart
crossAxisCount: 2
```

may look good on a phone but not necessarily on a tablet or desktop.

Think about responsive design.

---

## ❌ Mistake 4 — Ignoring `childAspectRatio`

If your product cards are too tall:

```dart
childAspectRatio: ...
```

may need adjustment.

Don't randomly change it.

Understand:

```text
childAspectRatio = width / height
```

---

## ❌ Mistake 5 — Confusing spacing properties

Remember:

```text
crossAxisSpacing
        ↓
between columns

mainAxisSpacing
        ↓
between rows
```

for a vertically scrolling grid.

---

## ❌ Mistake 6 — Blindly using `shrinkWrap`

Don't automatically do:

```dart
shrinkWrap: true
```

because a grid doesn't fit inside a `Column`.

First understand the constraints.

Often:

```dart
Expanded(
  child: GridView.builder(...)
)
```

is the correct solution.

---

## ❌ Mistake 7 — Putting huge static lists inside `GridView`

If you have dynamic data:

```dart
GridView.builder(...)
```

is generally the better approach.

---

# 🚀 22. Professional Best Practices

### 1. Use `GridView.builder` for dynamic data

```dart
GridView.builder(
  itemCount: products.length,
  itemBuilder: ...
)
```

---

### 2. Use `GridView.count` for small, fixed grids

For example:

```text
Home
Profile
Settings
Help
```

A small fixed grid can be perfectly fine with:

```dart
GridView.count(...)
```

---

### 3. Use `GridView.extent` when item width matters

Especially useful when you want the grid to adapt to available width.

---

### 4. Think about aspect ratio

Ask:

> What should the visual shape of each item be?

Then choose:

```dart
childAspectRatio
```

accordingly.

---

### 5. Use meaningful spacing

Instead of:

```dart
mainAxisSpacing: 3,
crossAxisSpacing: 3,
```

just because it works, establish a consistent spacing system in your app.

Later, your theme/design system can centralize these values.

---

### 6. Extract complex grid items into widgets

Instead of:

```dart
itemBuilder: (context, index) {
  return Container(
    // 100 lines
  );
}
```

prefer:

```dart
itemBuilder: (context, index) {
  return ProductCard(
    product: products[index],
  );
}
```

This improves:

* readability
* reusability
* testing
* maintainability

---

### 7. Keep scrolling responsibility clear

Always ask:

> **Which widget owns scrolling?**

This question will save you from many Flutter layout problems.

---

# 🧠 Professional Mental Model

You should now think about `GridView` like this:

```text
                 DATA
                   │
                   ▼
              List<Product>
                   │
                   ▼
          GridView.builder
                   │
                   ▼
             Grid delegate
                   │
         ┌─────────┴─────────┐
         │                   │
   number/width          item shape
    of columns         aspect ratio
         │                   │
         └─────────┬─────────┘
                   ▼
               ProductCard
                   │
                   ▼
                  UI
```

This is much more useful than memorizing constructor syntax.

---

# 🔍 `GridView` and the Sliver System

You will eventually encounter:

```dart
SliverGridDelegateWithFixedCrossAxisCount
```

and wonder:

> Why does GridView use something called `Sliver`?

At your current level, you don't need to master slivers.

But understand the basic idea:

Flutter's scrolling system is built around **slivers**, which are portions of scrollable content that can participate in a viewport.

`GridView` internally uses this scrolling infrastructure.

Conceptually:

```text
GridView
   │
   ▼
Scrollable
   │
   ▼
Viewport
   │
   ▼
Sliver grid
   │
   ▼
Grid children
```

Later, when you learn:

```dart
CustomScrollView
SliverList
SliverGrid
SliverAppBar
```

this will make much more sense.

---

# 🧪 23. Practice

## 🟢 Beginner — Number Grid

Create a grid:

```text
┌──────┐ ┌──────┐
│  1   │ │  2   │
├──────┤ ├──────┤
│  3   │ │  4   │
├──────┤ ├──────┤
│  5   │ │  6   │
└──────┘ └──────┘
```

Requirements:

* Use `GridView.builder`
* `crossAxisCount: 2`
* Generate 20 items
* Display `index + 1`

---

# 🟢 Beginner — Category Grid

Create:

```dart
final categories = [
  'AI',
  'Flutter',
  'Dart',
  'C++',
  'Python',
  'Java',
];
```

Display them in a 2-column grid.

Each item should have:

* Icon
* Category name
* Rounded card
* Padding

---

# 🟡 Intermediate — Product Grid

Create:

```dart
final products = [
  'Laptop',
  'Phone',
  'Keyboard',
  'Mouse',
  'Monitor',
  'Headphones',
];
```

Requirements:

* `GridView.builder`
* 2 columns
* `crossAxisSpacing`
* `mainAxisSpacing`
* `childAspectRatio`
* `Card`
* Product name
* Price
* Image placeholder

---

# 🟡 Intermediate — Responsive Grid

Try to build a grid that behaves differently depending on available width.

For example:

```text
Small screen
→ 2 columns

Medium screen
→ 3 columns

Large screen
→ 4 columns
```

You don't need to make it perfect yet.

The goal is to start thinking:

> **UI should adapt to available space.**

---

# 🔴 Advanced Challenge — E-commerce Home Screen

Build:

```text
┌─────────────────────────────────┐
│         My Store                │
│                                 │
│ Categories                      │
│                                 │
│ [AI] [Tech] [Books] [Games]     │
│                                 │
│ Products                        │
│                                 │
│ ┌─────────┐  ┌─────────┐        │
│ │         │  │         │        │
│ │ Product │  │ Product │        │
│ │   $100  │  │   $200  │        │
│ └─────────┘  └─────────┘        │
│                                 │
│ ┌─────────┐  ┌─────────┐        │
│ │ Product │  │ Product │        │
│ │   $300  │  │   $400  │        │
│ └─────────┘  └─────────┘        │
└─────────────────────────────────┘
```

Use:

* `Column`
* `GridView`
* `GridView.builder`
* `Card`
* `Padding`
* `Expanded`
* `Container`
* `Text`
* `Icon`

This will force you to combine almost everything you've learned so far.

---

# 🧠 24. Knowledge Check

Before moving to the next topic, make sure you can explain:

1. What is `GridView`?
2. How is `GridView` different from `ListView`?
3. What does `crossAxisCount` mean?
4. What is `GridView.builder`?
5. Why is `builder` useful?
6. What is `GridView.count`?
7. What is `GridView.extent`?
8. What's the difference between `count` and `extent`?
9. What does `childAspectRatio` mean?
10. What does `mainAxisSpacing` control?
11. What does `crossAxisSpacing` control?
12. How do you create a horizontal GridView?
13. Why might GridView inside Column cause a layout problem?
14. Why can `Expanded` solve that problem?
15. What does `shrinkWrap` do?
16. Why shouldn't `shrinkWrap` be used blindly?
17. Why should dynamic product data usually use `GridView.builder`?
18. What is a `SliverGridDelegate`?
19. Why does GridView use slivers internally?
20. How would you make a grid responsive?

If you can explain these concepts rather than merely recognizing the code, you're ready to move forward.

---

# 📌 25. Quick Reference

## Basic Grid

```dart
GridView.count(
  crossAxisCount: 2,
  children: [
    Text('1'),
    Text('2'),
    Text('3'),
    Text('4'),
  ],
)
```

---

## Dynamic Grid

```dart
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Text(items[index]);
  },
)
```

---

## Grid with spacing

```dart
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Card(
      child: Text(items[index]),
    );
  },
)
```

---

## Grid with aspect ratio

```dart
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.8,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Card(
      child: Text(items[index]),
    );
  },
)
```

---

## Responsive-style grid

```dart
GridView.extent(
  maxCrossAxisExtent: 250,
  children: [
    ...
  ],
)
```

---

## Grid inside Column

```dart
Column(
  children: [
    const Text('Products'),

    Expanded(
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
          );
        },
      ),
    ),
  ],
)
```

---

# 🎯 26. Key Takeaways

If you remember only the most important concepts from this lesson:

### `GridView`

> **A scrollable two-dimensional layout for displaying items in rows and columns.**

### `GridView.builder`

> **The go-to choice for dynamic or potentially large grids.**

### `crossAxisCount`

> **Controls the number of items across the cross axis; for a normal vertical grid, this means the number of columns.**

### `childAspectRatio`

> **Controls the width-to-height relationship of each grid item.**

### `mainAxisSpacing`

> **Controls spacing along the scrolling/main axis.**

### `crossAxisSpacing`

> **Controls spacing between items across the cross axis.**

### `GridView.count`

> **Useful when you know the number of columns.**

### `GridView.extent`

> **Useful when you care about maximum item width and want the number of columns to adapt.**

### `shrinkWrap`

> **Makes the grid size itself to its content in the scroll direction; use it intentionally.**

---

# 🧠 Final Mental Model

You have now learned the two most important basic scrolling layouts:

```text
                 SCROLLABLE UI
                      │
             ┌────────┴────────┐
             │                 │
          ListView           GridView
             │                 │
             ▼                 ▼
        One-dimensional   Two-dimensional
             │                 │
             ▼                 ▼
       ┌───────────┐     ┌─────┬─────┐
       │ Item 1    │     │  1  │  2  │
       │ Item 2    │     ├─────┼─────┤
       │ Item 3    │     │  3  │  4  │
       │ Item 4    │     ├─────┼─────┤
       └───────────┘     │  5  │  6  │
                         └─────┴─────┘
```

And the professional data-driven pattern is:

```text
                 DATA
                   │
                   ▼
             List<Product>
                   │
                   ▼
          GridView.builder
                   │
                   ▼
             ProductCard
                   │
                   ▼
                  UI
```

> **The goal isn't to memorize `GridView.builder` syntax. The goal is to understand how Flutter takes a collection of data and turns it into an efficient, responsive, scrollable visual grid.**

That mental model will become increasingly important when you later work with **APIs, models, state management, responsive UI, and slivers**. 
