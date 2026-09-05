# Phase 7 — Advanced Flutter

## Topic 3: Slivers and Advanced Scrolling

> **Core idea:** A **Sliver** is a scrollable area that can participate in a `CustomScrollView` and dynamically change its layout based on the scroll position.

---

## 1. What Are Slivers?

Normally, you might use:

```dart
ListView(...)
```

But `ListView` gives you a fairly fixed scrolling structure.

Slivers let you **combine different types of scrolling content into one scrollable area**.

Mental model:

```text
CustomScrollView
│
├── SliverAppBar
├── SliverList
├── SliverGrid
└── Other Slivers
```

Think of a Sliver as:

> **A piece of a larger scrollable layout.**

---

## 2. CustomScrollView

`CustomScrollView` is the container that combines multiple slivers.

```dart
CustomScrollView(
  slivers: [
    SliverAppBar(
      expandedHeight: 200,
      pinned: true,
    ),

    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(
          title: Text('Item $index'),
        ),
        childCount: 20,
      ),
    ),
  ],
)
```

The important difference:

```text
ListView
   ↓
One main scrolling structure

CustomScrollView
   ↓
Multiple coordinated slivers
```

---

## 3. SliverAppBar

`SliverAppBar` is an app bar designed specifically for scrolling layouts.

One of its most useful features is a **collapsing header**.

```dart
SliverAppBar(
  expandedHeight: 200,
  pinned: true,
  flexibleSpace: FlexibleSpaceBar(
    title: const Text('Profile'),
  ),
)
```

As you scroll:

```text
Before scrolling:

┌────────────────────┐
│                    │
│      Header        │
│                    │
│      Profile       │
└────────────────────┘

After scrolling:

┌────────────────────┐
│ Profile            │
└────────────────────┘
```

### Important properties

* `expandedHeight` → expanded size
* `pinned` → remains visible when collapsed
* `floating` → appears when scrolling toward it
* `flexibleSpace` → content that participates in the collapse

---

## 4. SliverList

`SliverList` is essentially the sliver version of a `ListView`.

```dart
SliverList(
  delegate: SliverChildBuilderDelegate(
    (context, index) {
      return ListTile(
        title: Text('Item $index'),
      );
    },
    childCount: 50,
  ),
)
```

Use it when a list needs to be part of a larger `CustomScrollView`.

---

## 5. SliverGrid

`SliverGrid` provides grid content inside the same scrolling area.

```dart
SliverGrid(
  delegate: SliverChildBuilderDelegate(
    (context, index) {
      return Card(
        child: Center(
          child: Text('$index'),
        ),
      );
    },
    childCount: 20,
  ),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
  ),
)
```

Now you can have:

```text
CustomScrollView
│
├── Collapsing Header
├── List
├── Grid
└── More Content
```

—all controlled by **one scrollable area**.

---

## 6. When Should You Use Slivers?

Don't replace every `ListView` with a `CustomScrollView`.

### Use `ListView` when:

```text
Simple scrolling list
```

### Use Slivers when:

```text
Complex scrolling layout
       +
Multiple scrollable sections
       +
Collapsing/floating headers
       +
List + Grid + other sections
```

---

## 🧠 Mental Model

Remember:

```text
CustomScrollView
      │
      ├── SliverAppBar
      │       ↓
      │   collapses
      │
      ├── SliverList
      │       ↓
      │     list
      │
      └── SliverGrid
              ↓
             grid
```

> **`CustomScrollView` manages the overall scroll. Slivers are the individual pieces of that scrollable layout.**

That's the key concept you need before moving into more advanced scrolling patterns.
