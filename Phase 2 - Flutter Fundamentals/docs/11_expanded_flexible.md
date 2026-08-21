# 🟢 Phase 2 — Topic 11: `Expanded` & `Flexible`

> **`Expanded` and `Flexible` are Flutter's primary tools for controlling how children share available space inside a `Row`, `Column`, or other `Flex` layouts.**

The roadmap places **`Expanded / Flexible` immediately after `Row / Column`**, because they depend heavily on the flex concepts you just learned. 

---

## 📚 Table of Contents

* [1. Why Do We Need Expanded and Flexible?](#-1-why-do-we-need-expanded-and-flexible)
* [2. The Core Problem: Available Space](#-2-the-core-problem-available-space)
* [3. What Is Expanded?](#-3-what-is-expanded)
* [4. Basic Expanded Example](#-4-basic-expanded-example)
* [5. Expanded and Remaining Space](#-5-expanded-and-remaining-space)
* [6. Multiple Expanded Widgets](#-6-multiple-expanded-widgets)
* [7. Understanding flex](#-7-understanding-flex)
* [8. Flex Factor Examples](#-8-flex-factor-examples)
* [9. The Most Important Expanded Mental Model](#-9-the-most-important-expanded-mental-model)
* [10. What Is Flexible?](#-10-what-is-flexible)
* [11. Expanded vs Flexible](#-11-expanded-vs-flexible)
* [12. `FlexFit.tight` vs `FlexFit.loose`](#-12-flexfittight-vs-flexfitloose)
* [13. Why Expanded Is Basically Flexible + Tight](#-13-why-expanded-is-basically-flexible--tight)
* [14. Flexible Example](#-14-flexible-example)
* [15. A Critical Difference Between Expanded and Flexible](#-15-a-critical-difference-between-expanded-and-flexible)
* [16. Text Overflow and Expanded](#-16-text-overflow-and-expanded)
* [17. Real-World Example: Profile Row](#-17-real-world-example-profile-row)
* [18. Real-World Example: Dashboard Cards](#-18-real-world-example-dashboard-cards)
* [19. Expanded in Column](#-19-expanded-in-column)
* [20. Expanded with Spacer](#-20-expanded-with-spacer)
* [21. Common Mistakes](#-21-common-mistakes)
* [22. Expanded Inside Scrollables](#-22-expanded-inside-scrollables)
* [23. Understanding Constraints](#-23-understanding-constraints)
* [24. Professional Decision-Making](#-24-professional-decision-making)
* [25. Best Practices](#-25-best-practices)
* [26. Practice](#-26-practice)
* [27. Knowledge Check](#-27-knowledge-check)
* [28. Quick Reference](#-28-quick-reference)
* [29. Key Takeaways](#-29-key-takeaways)

---

# 🧠 1. Why Do We Need `Expanded` and `Flexible`?

You already learned:

```dart
Row(
  children: [
    Widget1(),
    Widget2(),
  ],
)
```

and:

```dart
Column(
  children: [
    Widget1(),
    Widget2(),
  ],
)
```

But there's a problem.

Suppose we have:

```dart
Row(
  children: [
    Container(
      width: 200,
      color: Colors.blue,
    ),
    Container(
      width: 200,
      color: Colors.red,
    ),
  ],
)
```

What happens if the screen is only `300` logical pixels wide?

```text
Available width = 300

Child 1 = 200
Child 2 = 200

Required = 400

400 > 300
```

The children don't fit.

You can get:

```text
RenderFlex overflowed by ... pixels
```

This is where `Expanded` and `Flexible` become extremely important.

---

# 📐 2. The Core Problem: Available Space

Imagine this screen:

```text
┌────────────────────────────────────────┐
│                                        │
│            Available Space             │
│                                        │
└────────────────────────────────────────┘
```

Suppose we want two widgets to share it.

Without flex:

```text
┌────────────────────────────────────────┐
│   Widget A   │   Widget B              │
└────────────────────────────────────────┘
```

We might have to manually calculate widths.

That's not ideal.

Instead, we can say:

> "Flutter, divide the available space between these widgets."

Using:

```dart
Expanded
```

or:

```dart
Flexible
```

Flutter's flex layout system can calculate the appropriate sizes.

---

# 🟢 3. What Is `Expanded`?

`Expanded` tells its parent `Row`/`Column`:

> **"I want to take the available remaining space allocated to me."**

Basic example:

```dart
Row(
  children: [
    Expanded(
      child: Container(
        color: Colors.blue,
      ),
    ),
    Expanded(
      child: Container(
        color: Colors.red,
      ),
    ),
  ],
)
```

Conceptually:

```text
┌────────────────────────────────────┐
│             │                      │
│    Blue     │        Red           │
│             │                      │
└────────────────────────────────────┘
       50%              50%
```

No matter whether the screen is:

```text
300 px
400 px
600 px
1000 px
```

the two children can divide the available width proportionally.

---

# 💻 4. Basic `Expanded` Example

```dart
Row(
  children: [
    Expanded(
      child: Container(
        height: 100,
        color: Colors.blue,
      ),
    ),
    Expanded(
      child: Container(
        height: 100,
        color: Colors.red,
      ),
    ),
  ],
)
```

The important part is:

```dart
Expanded(
  child: ...
)
```

The `Expanded` itself doesn't draw anything.

It controls **how much space its child receives**.

Think:

```text
Expanded
   │
   │ controls available size
   ▼
Child
```

---

# 🧠 5. Expanded and Remaining Space

This phrase is extremely important:

> **Expanded distributes the available remaining space among flex children.**

Consider:

```dart
Row(
  children: [
    Container(
      width: 100,
      color: Colors.black,
    ),
    Expanded(
      child: Container(
        color: Colors.blue,
      ),
    ),
  ],
)
```

Suppose the screen width is:

```text
400
```

The first child uses:

```text
100
```

Remaining space:

```text
400 - 100 = 300
```

The `Expanded` child gets:

```text
300
```

Conceptually:

```text
400 total
┌──────────────────────────────────────┐
│  100  │            300               │
│ Fixed │          Expanded            │
└──────────────────────────────────────┘
```

This is one of the most important uses of `Expanded`.

---

# 📊 6. Multiple `Expanded` Widgets

You can have multiple `Expanded` widgets.

```dart
Row(
  children: [
    Expanded(
      child: Container(color: Colors.blue),
    ),
    Expanded(
      child: Container(color: Colors.red),
    ),
    Expanded(
      child: Container(color: Colors.green),
    ),
  ],
)
```

By default, each has:

```text
flex = 1
```

Therefore:

```text
1 : 1 : 1
```

The available space is divided equally.

```text
┌──────────────────────────────────────┐
│       │       │       │              │
│ Blue  │  Red  │ Green │              │
│       │       │       │              │
└──────────────────────────────────────┘
    1       1       1
```

---

# 🔢 7. Understanding `flex`

Now we reach one of the most important concepts.

`Expanded` has a property:

```dart
flex
```

Example:

```dart
Expanded(
  flex: 2,
  child: Container(),
)
```

`flex` determines the **proportion of the available flex space** allocated to that child.

---

# 💡 The Mental Model

Suppose:

```dart
Expanded(flex: 1)
Expanded(flex: 2)
```

Think:

```text
Total flex = 1 + 2 = 3
```

Therefore:

```text
First  = 1/3
Second = 2/3
```

Conceptually:

```text
┌──────────────────────────────────────┐
│          │                           │
│  1 part  │          2 parts          │
│          │                           │
└──────────────────────────────────────┘
     1                 2
```

This is much better than memorizing percentages.

---

# 📊 8. Flex Factor Examples

## Example 1 — `1 : 1`

```dart
Row(
  children: [
    Expanded(
      flex: 1,
      child: Container(),
    ),
    Expanded(
      flex: 1,
      child: Container(),
    ),
  ],
)
```

Result:

```text
50% : 50%
```

---

## Example 2 — `1 : 2`

```dart
Row(
  children: [
    Expanded(
      flex: 1,
      child: Container(),
    ),
    Expanded(
      flex: 2,
      child: Container(),
    ),
  ],
)
```

Result:

```text
33.33% : 66.67%
```

---

## Example 3 — `1 : 3`

```dart
Row(
  children: [
    Expanded(
      flex: 1,
      child: Container(),
    ),
    Expanded(
      flex: 3,
      child: Container(),
    ),
  ],
)
```

Result:

```text
25% : 75%
```

---

## Example 4 — `2 : 3`

```dart
Row(
  children: [
    Expanded(
      flex: 2,
      child: Container(),
    ),
    Expanded(
      flex: 3,
      child: Container(),
    ),
  ],
)
```

Total:

```text
2 + 3 = 5
```

Therefore:

```text
First  = 2/5 = 40%
Second = 3/5 = 60%
```

---

# 🧠 9. The Most Important `Expanded` Mental Model

Don't think:

> "`flex: 2` means 2 pixels."

It does **not**.

Don't think:

> "`flex: 2` means twice the screen width."

It does **not**.

Think:

> **`flex` is a ratio used to distribute available flex space.**

For:

```dart
Expanded(flex: 1)
Expanded(flex: 2)
Expanded(flex: 3)
```

think:

```text
1 : 2 : 3
```

Total:

```text
6 parts
```

Therefore:

```text
First  → 1/6
Second → 2/6
Third  → 3/6
```

---

# 🔵 10. What Is `Flexible`?

`Flexible` is similar to `Expanded`, but it gives its child **more freedom about how much of its allocated space it actually uses**.

Basic example:

```dart
Row(
  children: [
    Flexible(
      child: Text(
        'This is some text that can adapt to the available space.',
      ),
    ),
  ],
)
```

The key idea is:

> **`Flexible` allows a child to fit within its allocated flex space without requiring it to fill all of that space.**

This distinction becomes clearer when we understand `FlexFit`.

---

# 🔍 11. `Expanded` vs `Flexible`

This is the most important comparison in this lesson.

| Feature                               | `Expanded`           | `Flexible`                 |
| ------------------------------------- | -------------------- | -------------------------- |
| Based on                              | `Flexible`           | Flex layout                |
| Default fit                           | `FlexFit.tight`      | `FlexFit.loose`            |
| Child must fill allocated flex space? | Yes                  | No                         |
| Can child be smaller?                 | No                   | Yes                        |
| Common use                            | Fill remaining space | Adapt without forcing fill |
| Flex factor                           | Yes                  | Yes                        |

The simplest mental model:

```text
Expanded
→ "Take the space."

Flexible
→ "You may take the space."
```

---

# 🧠 12. `FlexFit.tight` vs `FlexFit.loose`

This is the key technical concept behind the difference.

`Flexible` has:

```dart
fit
```

and it can use:

```dart
FlexFit.tight
FlexFit.loose
```

---

## `FlexFit.tight`

Means:

> The child is required to fill the flex allocation.

Conceptually:

```text
Allocated space
┌─────────────────────┐
│                     │
│       CHILD         │
│                     │
└─────────────────────┘

Child must use it.
```

This is what `Expanded` uses.

---

## `FlexFit.loose`

Means:

> The child can be smaller than the maximum flex allocation.

Conceptually:

```text
Allocated space
┌─────────────────────┐
│  CHILD              │
│                     │
│                     │
└─────────────────────┘

Child can use less.
```

This is the default behavior of `Flexible`.

---

# ⭐ 13. Why `Expanded` Is Basically `Flexible` + Tight

This is an excellent technical detail to understand.

Conceptually, `Expanded` is equivalent to:

```dart
Flexible(
  fit: FlexFit.tight,
  child: ...
)
```

So:

```dart
Expanded(
  child: MyWidget(),
)
```

is essentially a convenient way of saying:

```dart
Flexible(
  fit: FlexFit.tight,
  child: MyWidget(),
)
```

with the default flex factor.

This explains the relationship:

```text
Flexible
   │
   ├── FlexFit.tight
   │       ↓
   │   Expanded behavior
   │
   └── FlexFit.loose
           ↓
       Flexible behavior
```

This is much better than memorizing them as completely unrelated widgets.

---

# 💻 14. Flexible Example

Consider:

```dart
Row(
  children: [
    Flexible(
      child: Container(
        width: 100,
        height: 100,
      ),
    ),
  ],
)
```

The child can use up to the space allocated to it, but it isn't forced to fill all of it.

With:

```dart
Flexible(
  fit: FlexFit.loose,
  child: ...
)
```

the child's own size can remain smaller than the maximum allocation.

---

# ⚖️ 15. A Critical Difference Between `Expanded` and `Flexible`

Let's make the difference extremely clear.

Suppose a `Row` has a large amount of available width.

### `Expanded`

```dart
Row(
  children: [
    Expanded(
      child: Container(
        width: 100,
        height: 50,
      ),
    ),
  ],
)
```

Even though the child says:

```dart
width: 100
```

the tight flex constraint from `Expanded` means the child is required to fill the flex allocation along the main axis.

So you should think:

```text
Expanded
↓
"You have this flex allocation.
Use it."
```

---

### `Flexible`

```dart
Row(
  children: [
    Flexible(
      child: Container(
        width: 100,
        height: 50,
      ),
    ),
  ],
)
```

Here, the child can remain smaller than its maximum flex allocation.

Think:

```text
Flexible
↓
"You may use up to this allocation.
You don't have to fill all of it."
```

---

# 📱 16. Text Overflow and `Expanded`

One of the most practical uses of `Expanded` is handling text inside a `Row`.

Consider:

```dart
Row(
  children: [
    Icon(Icons.person),
    Text(
      'This is a very long username or description...',
    ),
  ],
)
```

If the text is too long, you can run into horizontal overflow.

A common solution is:

```dart
Row(
  children: [
    const Icon(Icons.person),
    const SizedBox(width: 8),
    Expanded(
      child: Text(
        'This is a very long username or description...',
      ),
    ),
  ],
)
```

Now the text receives the remaining horizontal space.

You can also control how the text behaves:

```dart
Expanded(
  child: Text(
    'This is a very long username or description...',
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  ),
)
```

Result conceptually:

```text
┌─────────────────────────────────────┐
│ 👤  This is a very long user...     │
└─────────────────────────────────────┘
```

This is a **real-world pattern you'll use constantly**.

---

# 🏗️ 17. Real-World Example — Profile Row

Consider:

```text
┌────────────────────────────────────────┐
│ 👤  Nayeem Islam                 >     │
│     Flutter Developer                 │
└────────────────────────────────────────┘
```

A professional implementation could be:

```dart
Row(
  children: [
    const CircleAvatar(
      child: Icon(Icons.person),
    ),

    const SizedBox(width: 12),

    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Nayeem Islam',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Flutter Developer',
          ),
        ],
      ),
    ),

    const Icon(Icons.arrow_forward_ios),
  ],
)
```

Widget tree:

```text
Row
├── CircleAvatar
├── SizedBox
├── Expanded
│   └── Column
│       ├── Text
│       └── Text
└── Icon
```

Why use `Expanded`?

Because the middle section should:

* use available space
* not push the trailing icon outside the screen
* adapt to different screen widths

This is exactly how a professional developer thinks about responsive layout.

---

# 📊 18. Real-World Example — Dashboard Cards

Suppose you want:

```text
┌────────────────────┐ ┌────────────────────┐
│ Total Users        │ │ Revenue            │
│ 1,250              │ │ $25,000            │
└────────────────────┘ └────────────────────┘
```

You can write:

```dart
Row(
  children: [
    Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Users'),
              SizedBox(height: 8),
              Text('1,250'),
            ],
          ),
        ),
      ),
    ),

    SizedBox(width: 16),

    Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Revenue'),
              SizedBox(height: 8),
              Text('\$25,000'),
            ],
          ),
        ),
      ),
    ),
  ],
)
```

Conceptually:

```text
Available width
│
├── Card → Expanded
│
├── 16px gap
│
└── Card → Expanded
```

The cards automatically share the remaining width.

---

# 📐 19. `Expanded` in `Column`

`Expanded` isn't only for `Row`.

It also works inside `Column`.

For example:

```dart
Column(
  children: [
    Container(
      height: 100,
      color: Colors.blue,
    ),

    Expanded(
      child: Container(
        color: Colors.red,
      ),
    ),
  ],
)
```

Suppose the available height is:

```text
600
```

The first child uses:

```text
100
```

Remaining:

```text
500
```

The `Expanded` child gets:

```text
500
```

Conceptually:

```text
┌──────────────────────┐
│      Blue            │ 100
├──────────────────────┤
│                      │
│                      │
│        Red           │
│                      │
│                      │
└──────────────────────┘ 500
```

Remember:

```text
Row    → Expanded controls horizontal space
Column → Expanded controls vertical space
```

because that is each widget's main axis.

---

# ↔️ 20. `Expanded` with `Spacer`

Remember `Spacer` from the previous lesson?

```dart
Spacer()
```

is itself based on flex behavior.

You can think of:

```dart
Spacer()
```

as a flexible empty space.

For example:

```dart
Row(
  children: [
    Text('Left'),
    Spacer(),
    Text('Right'),
  ],
)
```

is conceptually similar to using a flex child that consumes remaining space.

You can also control its flex:

```dart
Spacer(
  flex: 2,
)
```

So:

```text
Expanded
Flexible
Spacer
```

are all closely connected through Flutter's **Flex layout system**.

---

# ⚠️ 21. Common Mistakes

## ❌ Mistake 1 — Using `Expanded` Outside a Flex

This is invalid:

```dart
Container(
  child: Expanded(
    child: Text('Hello'),
  ),
)
```

`Expanded` must be a descendant of a compatible `Flex` layout such as:

```dart
Row
Column
Flex
```

Correct:

```dart
Column(
  children: [
    Expanded(
      child: Text('Hello'),
    ),
  ],
)
```

---

# ❌ Mistake 2 — Using `Expanded` When You Don't Need Flexible Space

Don't automatically write:

```dart
Row(
  children: [
    Expanded(
      child: Text('Hello'),
    ),
  ],
)
```

if the child simply needs to be its natural size.

Use the simplest layout that communicates your intention.

---

# ❌ Mistake 3 — Thinking `flex` Means Pixels

Wrong:

```text
flex: 2 = 2 pixels
```

Correct:

```text
flex: 2 = 2 proportional units
```

For example:

```text
flex 1 : flex 2
=
1 part : 2 parts
```

---

# ❌ Mistake 4 — Putting `Expanded` Inside `Padding` Without Understanding the Tree

This is valid in some arrangements:

```dart
Column(
  children: [
    Expanded(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('Hello'),
      ),
    ),
  ],
)
```

The important thing is that the `Expanded` itself is directly participating in the `Column`'s flex layout.

Think carefully about which widget is the **flex child**.

---

# ❌ Mistake 5 — Using `Expanded` to Hide a Layout Problem

Suppose you have:

```dart
Row(
  children: [
    Expanded(
      child: Expanded(
        child: Text('Hello'),
      ),
    ),
  ],
)
```

This isn't a meaningful solution.

More `Expanded` widgets don't automatically make a layout better.

First understand:

```text
What space does each widget need?
Who should control that space?
```

---

# ⚠️ 22. `Expanded` Inside Scrollables

This is a very important source of errors.

Consider:

```dart
SingleChildScrollView(
  child: Column(
    children: [
      Expanded(
        child: Container(),
      ),
    ],
  ),
)
```

This can cause problems because a vertical scrollable may provide the `Column` with an unbounded height in the scrolling direction, while `Expanded` needs a finite amount of remaining space to divide.

You may encounter errors involving:

```text
RenderFlex children have non-zero flex but incoming height constraints are unbounded
```

The deeper lesson is:

> **Flex widgets need meaningful constraints along their main axis.**

Don't just memorize the error. Understand why it happens.

We'll revisit this when we study `ListView`, scrolling, and constraints.

---

# 🔍 23. Understanding Constraints

This connects directly to the previous `Container` lesson.

You already learned:

> **Constraints go down → sizes go up → parents set positions.**

With `Expanded`, the process becomes more interesting.

Consider:

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

Conceptually:

```text
Parent
  │
  │ gives Row available width
  ▼
Row
  │
  │ calculates flex allocation
  ├───────────────┐
  ▼               ▼
Expanded        Expanded
  │               │
  │ constraints   │ constraints
  ▼               ▼
Child           Child
```

The `Row` determines how the available main-axis space should be divided among its flex children.

This is why `Expanded` isn't simply a "bigger Container."

It is a **layout mechanism**.

---

# 🧠 `Expanded` vs `Flexible`: The Deep Mental Model

Let's make the entire relationship clear.

```text
                 Flex Layout
                     │
          ┌──────────┴──────────┐
          │                     │
      Flexible               Expanded
          │                     │
      flex factor          flex factor
          │                     │
      fit: loose           fit: tight
          │                     │
          ▼                     ▼
 Child may use less       Child fills its
 than allocation          allocation
```

Or simply:

```text
Flexible
"Up to this amount."

Expanded
"Use this amount."
```

That is the distinction you should remember.

---

# 🎯 24. Professional Decision-Making

When designing a layout, ask yourself:

### Question 1

> Does this widget need to consume the remaining available space?

If **yes**:

```dart
Expanded(...)
```

---

### Question 2

> Should this widget be allowed to remain smaller than its flex allocation?

If **yes**:

```dart
Flexible(...)
```

---

### Question 3

> Do I simply need fixed spacing?

Use:

```dart
SizedBox(...)
```

---

### Question 4

> Do I need flexible empty space?

Use:

```dart
Spacer(...)
```

---

### Question 5

> Do multiple widgets need proportional widths?

Use:

```dart
Expanded(
  flex: ...,
)
```

---

# 🚀 25. Best Practices

## 1. Use `Expanded` for genuinely flexible regions

Good:

```dart
Row(
  children: [
    Icon(Icons.search),
    Expanded(
      child: TextField(),
    ),
  ],
)
```

The text field should consume the remaining width.

---

## 2. Use `Flexible` when natural child size matters

For example, when you want a child to be able to shrink or stay smaller than its maximum allocation.

```dart
Row(
  children: [
    Flexible(
      child: Text('Some text'),
    ),
  ],
)
```

---

## 3. Use flex ratios instead of hardcoded responsive widths

Instead of:

```dart
Container(width: 137)
Container(width: 263)
```

you might use:

```dart
Expanded(flex: 1)
Expanded(flex: 2)
```

when the design is fundamentally proportional.

---

## 4. Don't overuse flex

Not every layout needs:

```dart
Expanded
Flexible
Spacer
```

Sometimes the correct solution is simply:

```dart
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.home),
    SizedBox(width: 8),
    Text('Home'),
  ],
)
```

Use flex when the **layout requirement** calls for flexible space.

---

## 5. Think about constraints first

When you see:

```text
RenderFlex overflowed
```

don't immediately add:

```dart
Expanded(...)
```

Ask:

```text
Why is the child too large?

Is the content too long?

Should it wrap?

Should it scroll?

Should it shrink?

Should it fill remaining space?

Should it have a maximum width?
```

Then choose the appropriate widget.

That's professional Flutter development.

---

# 🧪 26. Practice

## 🟢 Beginner — Equal Width Boxes

Build:

```text
┌────────────┬────────────┐
│            │            │
│   Blue     │    Red     │
│            │            │
└────────────┴────────────┘
```

Requirements:

* Use `Row`
* Use two `Expanded` widgets
* Both should have equal width

---

## 🟢 Beginner — Three Equal Sections

Build:

```text
┌────────┬────────┬────────┐
│        │        │        │
│   1    │   2    │   3    │
│        │        │        │
└────────┴────────┴────────┘
```

Use:

```dart
Expanded(flex: 1)
```

for each child.

---

## 🟡 Intermediate — 1:2 Layout

Build:

```text
┌──────────┬────────────────────┐
│          │                    │
│ Sidebar  │       Content      │
│          │                    │
└──────────┴────────────────────┘
```

Requirements:

```text
Sidebar  → flex: 1
Content  → flex: 2
```

---

## 🟡 Intermediate — Profile Row

Build:

```text
┌─────────────────────────────────────┐
│ 👤  Very Long User Name       →     │
└─────────────────────────────────────┘
```

Requirements:

* `Row`
* `CircleAvatar`
* `SizedBox`
* `Expanded`
* trailing `Icon`
* long text should not cause horizontal overflow

---

## 🔴 Advanced Challenge — Dashboard

Create:

```text
┌─────────────────────────────────────┐
│ Dashboard                    ⚙      │
├─────────────────────────────────────┤
│                                     │
│ ┌──────────────┐ ┌────────────────┐ │
│ │ Users        │ │ Revenue        │ │
│ │ 1,250        │ │ $25,000        │ │
│ └──────────────┘ └────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

Requirements:

* Use `Column`
* Header uses `Row`
* Cards use `Row`
* Cards use `Expanded`
* Add a fixed gap between cards
* Don't use hardcoded screen widths

---

# 🧪 Challenge: Predict Before Running

Consider:

```dart
Row(
  children: [
    Expanded(
      flex: 1,
      child: Container(),
    ),
    Expanded(
      flex: 2,
      child: Container(),
    ),
    Expanded(
      flex: 3,
      child: Container(),
    ),
  ],
)
```

Before running the code, answer:

### What percentage does each child receive?

Don't calculate it with a tool.

Think:

```text
1 + 2 + 3 = 6
```

Therefore:

```text
Child 1 → 1/6
Child 2 → 2/6
Child 3 → 3/6
```

So:

```text
16.67%
33.33%
50%
```

This kind of mental calculation will make flex layouts much easier to reason about.

---

# 🧠 27. Knowledge Check

Before moving forward, make sure you can answer these:

1. Why do we need `Expanded`?
2. What problem does `Expanded` solve?
3. What does `Expanded` do inside a `Row`?
4. What does `Expanded` do inside a `Column`?
5. What does `flex` mean?
6. Does `flex: 2` mean 2 pixels?
7. What happens with `flex: 1` and `flex: 2`?
8. What is `Flexible`?
9. What is the main difference between `Expanded` and `Flexible`?
10. What is `FlexFit.tight`?
11. What is `FlexFit.loose`?
12. Why is `Expanded` essentially a tight `Flexible`?
13. When should you use `Flexible` instead of `Expanded`?
14. Why can `Expanded` help prevent text overflow?
15. Why can't `Expanded` be placed arbitrarily inside any widget?
16. Why can `Expanded` cause problems inside a vertically scrolling `Column`?
17. How does `Expanded` relate to Flutter's constraint system?
18. How does `Spacer` relate to flex?
19. When should you use `SizedBox` instead of `Expanded`?
20. Why shouldn't you automatically fix every overflow with `Expanded`?

---

# 📌 28. Quick Reference

## `Expanded`

```dart
Expanded(
  child: MyWidget(),
)
```

Means approximately:

> **Fill the flex allocation.**

---

## `Expanded` with `flex`

```dart
Expanded(
  flex: 2,
  child: MyWidget(),
)
```

Means:

> **Give this child 2 proportional flex units.**

---

## `Flexible`

```dart
Flexible(
  child: MyWidget(),
)
```

Means approximately:

> **Allow the child to use up to its flex allocation without forcing it to fill the entire allocation.**

---

## `Flexible` with fit

```dart
Flexible(
  fit: FlexFit.loose,
  child: MyWidget(),
)
```

The child may be smaller than its maximum flex allocation.

```dart
Flexible(
  fit: FlexFit.tight,
  child: MyWidget(),
)
```

The child must fill its flex allocation.

---

## Relationship

```text
Expanded
    ≈
Flexible(
  fit: FlexFit.tight,
)
```

---

# 🧠 29. Key Takeaways

### `Expanded`

> **Use `Expanded` when a child should fill the flexible space allocated to it.**

### `Flexible`

> **Use `Flexible` when a child should be allowed to use flexible space but should not necessarily be forced to fill all of its allocation.**

### `flex`

> **`flex` is a ratio, not a pixel value.**

For:

```dart
Expanded(flex: 1)
Expanded(flex: 2)
```

think:

```text
1 : 2
```

---

## ⭐ The Most Important Diagram

```text
                    Row / Column
                         │
                  Available Space
                         │
                         ▼
                  ┌─────────────┐
                  │ Flex layout │
                  └──────┬──────┘
                         │
              ┌──────────┴──────────┐
              │                     │
          Expanded               Flexible
              │                     │
        FlexFit.tight          FlexFit.loose
              │                     │
              ▼                     ▼
       MUST fill its          MAY use less
       allocation             than allocation
```

And remember the professional mental model:

```text
SizedBox
→ "Give me this fixed amount."

Flexible
→ "Give me up to this flexible amount."

Expanded
→ "Give me my flexible allocation."

Spacer
→ "Give me flexible empty space."
```

> **Don't memorize `Expanded` and `Flexible` as two random widgets. Understand them as different behaviors within Flutter's Flex layout system.**
