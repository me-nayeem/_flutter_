# 🟢 Phase 2 — Topic 19: Custom Widgets

> **Custom widgets are one of the most important concepts in Flutter. They allow you to break a large UI into small, reusable, understandable, and maintainable components.**

According to the roadmap, **Custom Widgets** is the final topic of Phase 2 after Gestures. 

---

# 📚 Table of Contents

1. [What Is a Custom Widget?](#-1-what-is-a-custom-widget)
2. [Why Do We Need Custom Widgets?](#-2-why-do-we-need-custom-widgets)
3. [The Problem With One Huge Widget](#-3-the-problem-with-one-huge-widget)
4. [Creating Your First Custom Widget](#-4-creating-your-first-custom-widget)
5. [`StatelessWidget` Custom Widgets](#-5-statelesswidget-custom-widgets)
6. [Understanding `build()`](#-6-understanding-build)
7. [Passing Data to Custom Widgets](#-7-passing-data-to-custom-widgets)
8. [Named Parameters](#-8-named-parameters)
9. [`const` and Custom Widgets](#-9-const-and-custom-widgets)
10. [Reusable Widgets](#-10-reusable-widgets)
11. [`StatefulWidget` Custom Widgets](#-11-statefulwidget-custom-widgets)
12. [Where Should State Live?](#-12-where-should-state-live)
13. [Parent → Child Communication](#-13-parent--child-communication)
14. [Child → Parent Communication](#-14-child--parent-communication)
15. [Callbacks](#-15-callbacks)
16. [Building a Reusable Button](#-16-building-a-reusable-button)
17. [Building a Reusable Card](#-17-building-a-reusable-card)
18. [Composition Over Duplication](#-18-composition-over-duplication)
19. [Custom Widgets vs Helper Methods](#-19-custom-widgets-vs-helper-methods)
20. [Widget Responsibility](#-20-widget-responsibility)
21. [Common Mistakes](#-21-common-mistakes)
22. [Professional Best Practices](#-22-professional-best-practices)
23. [Real-World Example](#-23-real-world-example)
24. [Practice](#-24-practice)
25. [Knowledge Check](#-25-knowledge-check)
26. [Quick Reference](#-26-quick-reference)
27. [Key Takeaways](#-27-key-takeaways)

---

# 🧠 1. What Is a Custom Widget?

A **custom widget** is simply a widget that **you create yourself** by composing Flutter's existing widgets.

For example, Flutter provides:

```dart
Text()
Container()
Row()
Column()
Image()
Icon()
```

You can combine them into your own widget:

```dart
ProfileCard()
```

For example:

```text
ProfileCard
│
├── CircleAvatar
├── Text
├── Text
└── Button
```

Instead of writing that entire structure everywhere, you can simply write:

```dart
ProfileCard()
```

That's the fundamental idea.

---

# 💡 2. Why Do We Need Custom Widgets?

Imagine you're building a social media application.

You have:

```text
Home Screen
 ├── Post Card
 ├── Post Card
 ├── Post Card
 └── Post Card

Profile Screen
 ├── Profile Card
 └── Post Card

Search Screen
 └── Post Card
```

If every screen manually builds the post UI:

```dart
Container(
  ...
  child: Column(
    ...
  ),
)
```

your code becomes:

* repetitive
* difficult to maintain
* difficult to modify
* difficult to test
* harder to understand

Instead:

```dart
PostCard(...)
```

Now the UI becomes much easier to understand.

---

# 🧠 3. The Problem With One Huge Widget

A beginner may create something like:

```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 100+ lines
          // Profile
          // Search
          // Posts
          // Buttons
          // Cards
          // etc.
        ],
      ),
    );
  }
}
```

This can work.

But as the application grows:

```text
HomeScreen
   │
   ├── Header
   ├── Search
   ├── Profile
   ├── Post
   ├── Post
   ├── Post
   └── Bottom section
```

the widget becomes difficult to reason about.

A professional developer asks:

> **Does this section have its own responsibility and can it be understood independently?**

If yes, it may deserve its own widget.

---

# 🏗️ 4. Creating Your First Custom Widget

Let's create:

```text
GreetingWidget
```

```dart
class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Hello Flutter!',
    );
  }
}
```

Now use it:

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: GreetingWidget(),
      ),
    );
  }
}
```

Instead of:

```dart
Text('Hello Flutter!')
```

you now have:

```dart
GreetingWidget()
```

---

# 🧠 What Actually Happened?

You created a new widget type:

```text
GreetingWidget
      │
      ▼
  StatelessWidget
      │
      ▼
    build()
      │
      ▼
    Text()
```

So a custom widget isn't some special Flutter mechanism.

It's simply **your own widget class**.

---

# 📚 5. `StatelessWidget` Custom Widgets

Most reusable UI components start as:

```dart
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ...;
  }
}
```

Example:

```dart
class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Nayeem',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
```

Use it:

```dart
const UserName()
```

---

# 🧠 Why `StatelessWidget`?

Use `StatelessWidget` when the widget doesn't own mutable UI state.

For example:

```text
Profile title
Logo
Static card
Custom heading
Reusable label
Icon + text section
```

The widget can still receive data.

For example:

```dart
UserName(name: 'Nayeem')
```

Receiving data does **not** automatically make a widget stateful.

---

# 🔍 6. Understanding `build()`

Every widget ultimately describes UI through:

```dart
build()
```

For example:

```dart
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Icon(Icons.person),
          const Text('Nayeem'),
        ],
      ),
    );
  }
}
```

Think:

```text
ProfileCard
     │
     ▼
  build()
     │
     ▼
returns widget tree
     │
     ├── Card
     │    └── Column
     │         ├── Icon
     │         └── Text
```

The custom widget is essentially giving a meaningful name to a piece of UI.

---

# 🚀 7. Passing Data to Custom Widgets

This is where custom widgets become genuinely powerful.

Suppose we want:

```dart
ProfileCard(name: 'Nayeem')
```

Create:

```dart
class ProfileCard extends StatelessWidget {
  final String name;

  const ProfileCard({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(name),
      ),
    );
  }
}
```

Now:

```dart
ProfileCard(name: 'Nayeem')
```

or:

```dart
ProfileCard(name: 'Rafi')
```

or:

```dart
ProfileCard(name: 'John')
```

The same widget can display different data.

---

# 🧠 Mental Model

Think of a custom widget like a function:

```text
ProfileCard
     │
     │ input
     ▼
   name
     │
     ▼
   UI
```

For example:

```dart
ProfileCard(
  name: 'Nayeem',
)
```

means:

```text
name = "Nayeem"
        ↓
ProfileCard
        ↓
Text(name)
```

This is one of the foundations of reusable UI architecture.

---

# 📌 8. Named Parameters

Flutter code heavily uses named parameters.

For example:

```dart
class ProfileCard extends StatelessWidget {
  final String name;
  final String role;

  const ProfileCard({
    super.key,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name),
        Text(role),
      ],
    );
  }
}
```

Usage:

```dart
ProfileCard(
  name: 'Nayeem',
  role: 'Flutter Developer',
)
```

This is much more readable than positional parameters such as:

```dart
ProfileCard(
  'Nayeem',
  'Flutter Developer',
)
```

---

# 💡 Why Named Parameters Matter in Flutter

Imagine:

```dart
UserCard(
  'Nayeem',
  'Developer',
  21,
  true,
)
```

What does each value mean?

You have to inspect the constructor.

Compare:

```dart
UserCard(
  name: 'Nayeem',
  role: 'Developer',
  age: 21,
  verified: true,
)
```

Much easier to understand.

That's why Flutter APIs commonly use named parameters.

---

# ⚡ 9. `const` and Custom Widgets

When your custom widget has an immutable configuration, make the constructor `const`.

Example:

```dart
class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Hello');
  }
}
```

Then:

```dart
const GreetingWidget()
```

can be used.

This is good Flutter practice.

---

# 🧠 Important Clarification

Don't think:

> "`const` means this widget will never rebuild."

That's not the correct mental model.

`const` means the object can be created as a compile-time constant when its inputs allow it.

Flutter can also optimize constant widget instances.

The important habit:

> **If a widget can be `const`, prefer using `const`.**

---

# 🔁 10. Reusable Widgets

Let's create a reusable information row.

```dart
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 12),
        Text('$label: $value'),
      ],
    );
  }
}
```

Now:

```dart
Column(
  children: [
    InfoRow(
      icon: Icons.email,
      label: 'Email',
      value: 'nayeem@example.com',
    ),
    InfoRow(
      icon: Icons.phone,
      label: 'Phone',
      value: '+880...',
    ),
  ],
)
```

One widget.

Multiple uses.

That's **reusability**.

---

# 🧠 11. `StatefulWidget` Custom Widgets

Not every custom widget is stateless.

Suppose we create a reusable counter:

```dart
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$count'),
        IconButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
```

Now:

```dart
const Counter()
```

can be placed anywhere.

The widget manages its own state.

---

# 🧠 Stateless vs Stateful Custom Widgets

| Type              | Use when                           |
| ----------------- | ---------------------------------- |
| `StatelessWidget` | UI depends only on external inputs |
| `StatefulWidget`  | Widget owns mutable UI state       |

Example:

```text
ProfileCard
   ↓
StatelessWidget
```

because the parent provides the data.

But:

```text
ExpandableCard
   ↓
StatefulWidget
```

if the card internally tracks:

```dart
bool expanded;
```

---

# 🧠 12. Where Should State Live?

This is one of the most important architectural questions in Flutter.

Suppose:

```text
Parent
  │
  └── Counter
```

Who owns `count`?

You have two choices.

### Option A — Child owns state

```text
Parent
  │
  └── Counter
       │
       └── count
```

Use this when the state is only relevant to the child.

---

### Option B — Parent owns state

```text
Parent
  │
  ├── count
  │
  └── Counter
```

The parent passes the value:

```dart
Counter(
  count: count,
)
```

and the child reports actions back.

This becomes important when multiple widgets need the same state.

---

# 🔄 13. Parent → Child Communication

The most common communication direction is:

```text
Parent
   │
   │ data
   ▼
Child
```

Example:

```dart
class UserCard extends StatelessWidget {
  final String name;

  const UserCard({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}
```

Parent:

```dart
UserCard(
  name: 'Nayeem',
)
```

So:

```text
Parent
  │
  │ name
  ▼
UserCard
```

This is simply **passing data through constructor parameters**.

---

# 🔄 14. Child → Parent Communication

Now the opposite direction.

Suppose a child detects a tap:

```text
Child
  │
  │ "User tapped!"
  ▼
Parent
```

How can the child tell the parent?

Use a **callback**.

---

# 📚 15. Callbacks

A callback is a function passed to another widget.

Example:

```dart
class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Click'),
    );
  }
}
```

Parent:

```dart
CustomButton(
  onPressed: () {
    print('Button clicked');
  },
)
```

The flow:

```text
Parent
  │
  │ passes function
  ▼
CustomButton
  │
  │ user taps
  ▼
onPressed()
  │
  ▼
Parent's function executes
```

This is an extremely important Flutter pattern.

---

# 💡 `VoidCallback`

Flutter provides:

```dart
VoidCallback
```

which essentially represents:

```dart
void Function()
```

So:

```dart
final VoidCallback onPressed;
```

means:

> This widget expects a function that takes no arguments and returns nothing.

---

# 🔍 Callback With Data

Sometimes the child needs to send data back.

For example:

```dart
final ValueChanged<String> onChanged;
```

Then:

```dart
class NameInput extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const NameInput({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
    );
  }
}
```

Parent:

```dart
NameInput(
  onChanged: (value) {
    print(value);
  },
)
```

Flow:

```text
Child
  │
  │ "Nayeem"
  ▼
onChanged("Nayeem")
  │
  ▼
Parent
```

---

# 🏗️ 16. Building a Reusable Button

Let's create a more realistic custom button.

```dart
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
```

Use it:

```dart
PrimaryButton(
  text: 'Login',
  onPressed: () {
    print('Login');
  },
)
```

Another:

```dart
PrimaryButton(
  text: 'Register',
  onPressed: () {
    print('Register');
  },
)
```

Same component.

Different behavior.

---

# 🧠 Why This Is Better

Without a custom widget:

```dart
ElevatedButton(
  ...
)

ElevatedButton(
  ...
)

ElevatedButton(
  ...
)
```

You might repeat styling and configuration.

With:

```dart
PrimaryButton(...)
```

the design can be centralized.

Later, if the application changes its primary button style, you can update one widget.

---

# 🏗️ 17. Building a Reusable Card

Example:

```dart
class UserCard extends StatelessWidget {
  final String name;
  final String role;
  final VoidCallback onTap;

  const UserCard({
    super.key,
    required this.name,
    required this.role,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const CircleAvatar(
                child: Icon(Icons.person),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(role),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

Usage:

```dart
UserCard(
  name: 'Nayeem',
  role: 'Flutter Developer',
  onTap: () {
    print('User selected');
  },
)
```

Notice how the parent controls:

* `name`
* `role`
* what happens when tapped

while the child controls:

* layout
* styling
* internal widget composition

This is a powerful separation of responsibilities.

---

# 🧠 18. Composition Over Duplication

A key Flutter philosophy is **composition**.

Instead of creating one giant widget:

```text
MegaWidget
 ├── Everything
 ├── Everything
 ├── Everything
 └── Everything
```

compose smaller widgets:

```text
HomeScreen
 │
 ├── AppHeader
 ├── SearchBar
 ├── ProfileCard
 ├── PostList
 │    └── PostCard
 └── BottomNavigation
```

Each component has a clear responsibility.

---

# 💡 Think of Widgets Like LEGO

This is a useful mental model.

Flutter provides basic pieces:

```text
Text
Icon
Container
Row
Column
Image
Button
```

You build:

```text
ProfileHeader
```

from those.

Then:

```text
ProfileScreen
```

from:

```text
ProfileHeader
StatsSection
PostList
```

Then:

```text
App
```

from:

```text
HomeScreen
ProfileScreen
SettingsScreen
```

So:

> **Complex interfaces emerge from composing small widgets.**

---

# 🔍 19. Custom Widgets vs Helper Methods

This is a subtle but important topic.

You might see developers create:

```dart
Widget buildProfileCard() {
  return Card(
    ...
  );
}
```

instead of:

```dart
class ProfileCard extends StatelessWidget {
  ...
}
```

Both can work.

But they aren't identical.

---

## Helper method

```dart
Widget buildTitle() {
  return const Text('Flutter');
}
```

This is simply a method returning a widget.

---

## Custom widget

```dart
class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Flutter');
  }
}
```

This creates an actual widget boundary.

---

# 🧠 When Should You Extract a Widget?

Don't follow:

> "Every 5 lines must become a custom widget."

Instead ask:

### 1. Is this UI conceptually meaningful?

For example:

```text
ProfileHeader
OrderSummary
ProductCard
LoginForm
```

These deserve names.

### 2. Is it reused?

If yes, extract it.

### 3. Is it becoming difficult to understand?

Extracting can improve readability.

### 4. Does it have its own state?

A custom widget may be appropriate.

### 5. Does it have a clear responsibility?

If yes, that's a strong signal.

---

# 🏗️ 20. Widget Responsibility

A good custom widget should have a **clear responsibility**.

Good:

```text
ProfileCard
```

Responsible for displaying a profile card.

Good:

```text
SearchBar
```

Responsible for the search UI.

Good:

```text
ProductPrice
```

Responsible for displaying product pricing.

Bad:

```text
EverythingWidget
```

Responsible for:

* profile
* API calls
* navigation
* authentication
* database
* animations
* settings

That's a sign the architecture needs improvement.

---

# ⚠️ 21. Common Mistakes

## ❌ Mistake 1 — Creating one giant widget

Avoid:

```text
HomeScreen
 └── 1000 lines of UI
```

Break it into meaningful components.

---

## ❌ Mistake 2 — Creating too many meaningless widgets

Don't do:

```text
TextWrapper
ContainerWrapper
RowWrapper
ColumnWrapper
```

when they don't provide meaningful abstraction.

A custom widget should make your code **clearer**, not merely longer.

---

## ❌ Mistake 3 — Putting business logic everywhere

For example:

```dart
class ProductCard extends StatelessWidget {
  void processPayment() {
    // complex payment logic
  }
}
```

A UI component shouldn't become responsible for your entire application's business logic.

As your application grows, you'll separate:

```text
UI
 ↓
View Model / Controller
 ↓
Repository
 ↓
Service / API
```

You'll learn this much more deeply in later phases.

---

## ❌ Mistake 4 — Mutating constructor parameters

If you have:

```dart
final String name;
```

don't try to modify it.

Custom widget configuration should generally be immutable.

Instead, state that needs to change belongs in:

```dart
StatefulWidget
```

or a higher-level state-management solution.

---

## ❌ Mistake 5 — Using `StatefulWidget` unnecessarily

Don't create:

```dart
class MyWidget extends StatefulWidget
```

just because the widget is custom.

Custom widgets can absolutely be stateless.

Ask:

> **Does this widget own mutable state?**

If no:

```dart
StatelessWidget
```

If yes:

```dart
StatefulWidget
```

---

# 🚀 22. Professional Best Practices

## 1. Give widgets meaningful names

Prefer:

```dart
ProfileCard()
```

over:

```dart
Widget1()
```

A good name communicates intent.

---

## 2. Keep widgets focused

Prefer:

```text
LoginForm
```

instead of:

```text
LoginEverything
```

---

## 3. Make configuration immutable

Prefer:

```dart
final String title;
final VoidCallback onTap;
```

rather than mutable public fields.

---

## 4. Use `const` constructors

When possible:

```dart
const ProfileCard(...)
```

and:

```dart
const ProfileCard({super.key});
```

---

## 5. Pass data through constructors

Prefer:

```dart
ProductCard(
  title: product.title,
  price: product.price,
)
```

instead of having the child reach into unrelated global state just to obtain basic configuration.

---

## 6. Use callbacks for events

Child:

```dart
final VoidCallback onTap;
```

Parent:

```dart
onTap: _handleTap,
```

This creates a clean communication boundary.

---

## 7. Don't over-engineer early

A custom widget doesn't need:

* a separate architecture layer
* a state-management library
* multiple files
* dozens of abstractions

Start simple.

Increase complexity only when the application actually needs it.

---

# 🔥 23. Real-World Example

Let's imagine a shopping app.

Instead of this:

```text
HomeScreen
 ├── Product image
 ├── Product name
 ├── Price
 ├── Rating
 ├── Add button
 │
 ├── Product image
 ├── Product name
 ├── Price
 ├── Rating
 ├── Add button
 │
 └── ...
```

Create:

```text
HomeScreen
    │
    └── ListView
          │
          ├── ProductCard
          ├── ProductCard
          ├── ProductCard
          └── ProductCard
```

And:

```dart
class ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final VoidCallback onAdd;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.shopping_bag),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  Text('\$${price.toStringAsFixed(2)}'),
                ],
              ),
            ),
            IconButton(
              onPressed: onAdd,
              icon: const Icon(Icons.add_shopping_cart),
            ),
          ],
        ),
      ),
    );
  }
}
```

Then:

```dart
ProductCard(
  name: 'Laptop',
  price: 1200,
  onAdd: () {
    // Add laptop to cart
  },
)
```

The widget is:

* reusable
* configurable
* focused
* easy to read
* easy to test
* easy to modify

That's what professional component design looks like.

---

# 🧠 A Deeper Mental Model

Think about a custom widget as a **contract**.

For example:

```dart
ProductCard(
  name: 'Laptop',
  price: 1200,
  onAdd: addToCart,
)
```

The parent says:

> "Here is the data you need and here is what you should call when the user performs this action."

The child says:

> "I will decide how that information is visually presented."

So:

```text
             Parent
               │
       ┌───────┴────────┐
       │                │
      Data            Events
       │                │
       ▼                ▲
   ┌────────────────────────┐
   │      ProductCard       │
   │                        │
   │  Controls UI structure │
   └────────────────────────┘
```

This separation becomes extremely important when you start learning architecture.

---

# 🧪 24. Practice

## 🟢 Beginner — Custom Greeting

Create:

```dart
GreetingWidget()
```

Requirements:

* `StatelessWidget`
* Display a greeting
* Use a `const` constructor

---

## 🟢 Beginner — Reusable Profile Card

Create:

```dart
ProfileCard(
  name: 'Nayeem',
  role: 'CSE Student',
)
```

Display:

```text
      👤
   Nayeem
 CSE Student
```

---

## 🟡 Intermediate — Reusable Button

Create:

```dart
PrimaryButton(
  text: 'Login',
  onPressed: login,
)
```

Requirements:

* custom widget
* `String text`
* `VoidCallback onPressed`
* internally use `ElevatedButton`

---

## 🟡 Intermediate — Reusable Product Card

Create:

```dart
ProductCard(
  name: 'Laptop',
  price: 120000,
  onAddToCart: () {},
)
```

Requirements:

* Product name
* Price
* Product icon/image
* Add button
* Callback

---

# 🔴 Challenge — Build a Mini Component System

Create these widgets:

```text
AppHeader
PrimaryButton
ProfileCard
InfoRow
ProductCard
```

Then build:

```text
HomeScreen
│
├── AppHeader
│
├── ProfileCard
│
├── InfoRow
├── InfoRow
│
└── ProductCard
```

Your goal is not to make the UI complicated.

Your goal is to practice **component design and communication between widgets**.

---

# 🧠 25. Knowledge Check

Before moving to Phase 3, make sure you can answer these:

1. What is a custom widget?
2. Why do we create custom widgets?
3. What is the difference between a Flutter-provided widget and your custom widget?
4. When should you use `StatelessWidget`?
5. When should you use `StatefulWidget`?
6. How do you pass data from parent to child?
7. How does a child communicate an event to its parent?
8. What is a callback?
9. What is `VoidCallback`?
10. What is `ValueChanged<T>`?
11. Why should widget configuration generally be immutable?
12. Why should custom widgets have meaningful names?
13. When should you extract a widget?
14. When should you avoid creating a custom widget?
15. What is composition?
16. Why is composition better than duplicating UI?
17. Where should state live?
18. Why shouldn't every custom widget be a `StatefulWidget`?
19. Why are `const` constructors useful?
20. What makes a custom widget production-quality?

---

# 📌 26. Quick Reference

## Basic Stateless Widget

```dart
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Hello');
  }
}
```

---

## Widget With Data

```dart
class Greeting extends StatelessWidget {
  final String name;

  const Greeting({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Text('Hello $name');
  }
}
```

Usage:

```dart
Greeting(
  name: 'Nayeem',
)
```

---

## Callback

```dart
class MyButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Click'),
    );
  }
}
```

---

## Callback With Data

```dart
final ValueChanged<String> onChanged;
```

Usage:

```dart
MyWidget(
  onChanged: (value) {
    print(value);
  },
)
```

---

## Stateful Custom Widget

```dart
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Text('$count');
  }
}
```

---

# 🎯 27. Key Takeaways

> **A custom widget is a reusable piece of UI that you define yourself.**

> **Use `StatelessWidget` when the widget doesn't own mutable state.**

> **Use `StatefulWidget` when the widget needs to own mutable UI state.**

> **Pass data from parent → child through constructor parameters.**

> **Use callbacks for child → parent communication.**

> **Good custom widgets have a clear responsibility.**

> **Don't extract widgets just to reduce line count. Extract them to improve meaning, reuse, separation, or maintainability.**

> **Prefer composition over duplicating UI.**

The most important mental model is:

```text
                    PARENT
                      │
            ┌─────────┴─────────┐
            │                   │
          DATA                CALLBACK
            │                   ▲
            ▼                   │
      ┌─────────────────────────────┐
      │         CHILD WIDGET        │
      │                             │
      │       owns presentation     │
      │       and possibly state    │
      └─────────────────────────────┘
```

And the professional mindset is:

> **Don't build Flutter screens as giant blocks of UI. Build them as a composition of small, meaningful components with clear responsibilities and explicit communication.**

---

# 🏁 Phase 2 Complete

You have now covered the complete **Phase 2 — Flutter Fundamentals** curriculum:

```text
1.  Flutter project structure     ✅
2.  MaterialApp                   ✅
3.  Scaffold                      ✅
4.  Widgets                       ✅
5.  Stateless vs Stateful         ✅
6.  BuildContext                  ✅
7.  Text, Image, Icon             ✅
8.  Container                     ✅
9.  Padding / Margin              ✅
10. Row / Column                  ✅
11. Expanded / Flexible           ✅
12. Stack                         ✅
13. ListView                      ✅
14. GridView                      ✅
15. Buttons                       ✅
16. Text fields                   ✅
17. Forms                         ✅
18. Gestures                      ✅
19. Custom widgets                ✅
```

The roadmap now moves to **Phase 3 — Learn to build real apps**, beginning with:

# 🚀 Next: Navigation

You will learn how Flutter moves between screens, how routes work, how to pass data between screens, and how navigation is structured in a real application. 
