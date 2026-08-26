# 🟢 Phase 3 — Building Complete Apps

# 5. State and `setState()`

> **Goal:** Understand what state is, why Flutter needs state management, how `setState()` works, and when you should—and should not—use it.

---

# 🧠 1. What Is State?

**State** is data that can change while your application is running and that change can affect what the user sees.

For example:

```text
Counter App

Count: 0
   ↓
User taps +
   ↓
Count: 1
```

The value:

```dart
0
```

changed to:

```dart
1
```

That changing value is **state**.

Other examples:

```text
Login status
Selected tab
Checkbox value
Text field value
Loading status
Selected product
Dark/light mode
Counter value
```

---

# 2. State vs Normal Data

Not every variable is necessarily application state.

Consider:

```dart
final String appName = 'My App';
```

This doesn't normally change.

But:

```dart
int counter = 0;
```

can change during the lifetime of the screen.

If the UI depends on that changing value, it is state.

Think:

```text
Data
 │
 ├── Doesn't change → ordinary configuration/data
 │
 └── Changes and affects UI → State
```

---

# 3. Why Does Flutter Need to Know About State Changes?

Consider this:

```dart
int counter = 0;

counter++;
```

The value changed.

But will Flutter automatically know that it needs to redraw the UI?

**No.**

Changing a Dart variable does not automatically tell Flutter:

> "Hey, the UI needs to update."

You need to notify Flutter.

That's where:

```dart
setState()
```

comes in.

---

# 4. `setState()` in One Sentence

> **`setState()` tells Flutter that the state of a `State` object has changed and that its UI should be rebuilt.**

The basic pattern is:

```dart
setState(() {
  counter++;
});
```

---

# 5. `StatelessWidget` vs `StatefulWidget`

This is extremely important.

## `StatelessWidget`

Use it when the widget doesn't need to manage changing local state.

```dart
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Welcome');
  }
}
```

---

## `StatefulWidget`

Use it when the widget needs mutable state that affects its UI.

```dart
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() {
    return _CounterPageState();
  }
}
```

Then:

```dart
class _CounterPageState extends State<CounterPage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Text('$counter');
  }
}
```

The state lives inside:

```text
_CounterPageState
```

---

# 6. The Structure of a StatefulWidget

A `StatefulWidget` has two important pieces:

```text
StatefulWidget
      │
      ├── Widget configuration
      │
      └── State object
             │
             ├── mutable data
             └── build()
```

Example:

```dart
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() {
    return _CounterPageState();
  }
}
```

and:

```dart
class _CounterPageState extends State<CounterPage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return ...;
  }
}
```

---

# 7. A Complete Counter Example

Let's build the classic example.

```dart
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() {
    return _CounterPageState();
  }
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: Text(
          '$counter',
          style: const TextStyle(
            fontSize: 40,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

When the button is pressed:

```text
counter
   │
   │ +1
   ▼
setState()
   │
   ▼
build()
   │
   ▼
UI updates
```

---

# 8. What Exactly Happens When `setState()` Runs?

Suppose:

```dart
int counter = 0;
```

Initially:

```text
UI

0
```

Then:

```dart
setState(() {
  counter++;
});
```

The sequence is approximately:

```text
1. counter changes
       ↓
2. setState() tells Flutter
       ↓
3. Flutter schedules the State object for rebuild
       ↓
4. build() runs again
       ↓
5. New widget configuration is produced
       ↓
6. Flutter updates the necessary parts of the UI
```

So:

```text
State changes
     ↓
setState()
     ↓
build()
     ↓
UI reflects new state
```

---

# 9. Why Put the Change Inside `setState()`?

Correct:

```dart
setState(() {
  counter++;
});
```

A common mistake is:

```dart
counter++;

setState(() {});
```

This can technically cause the UI to rebuild, but it is less clear because the state mutation isn't grouped with the notification.

Prefer:

```dart
setState(() {
  counter++;
});
```

It clearly communicates:

> "This change is part of the state update."

---

# 10. `setState()` Doesn't Actually Change Your Variable

This is a subtle but important point.

`setState()` doesn't magically modify:

```dart
counter
```

You do that:

```dart
counter++;
```

`setState()` tells Flutter:

```text
"The state has changed.
Please rebuild this State's UI."
```

So:

```dart
setState(() {
  counter++;
});
```

contains two ideas:

```text
counter++  → change the state

setState() → notify Flutter
```

---

# 11. `setState()` and `build()`

Suppose:

```dart
int counter = 0;
```

and:

```dart
Text('$counter')
```

When:

```dart
setState(() {
  counter++;
});
```

runs, Flutter calls the `build()` method again.

Conceptually:

```text
Before

counter = 0
    ↓
build()
    ↓
Text("0")
```

After:

```text
counter = 1
    ↓
build()
    ↓
Text("1")
```

---

# ⚠️ Important: Don't Think of `build()` as "Draw This Exact Pixel"

Flutter's rendering system is more sophisticated.

Your `build()` method describes the widget configuration.

Flutter then determines what needs to change in the underlying UI.

So a good mental model is:

> **`build()` describes the UI for the current state.**

---

# 12. State Should Be the Source of Truth

Consider:

```dart
bool isFavorite = false;
```

Your UI:

```dart
Icon(
  isFavorite
      ? Icons.favorite
      : Icons.favorite_border,
)
```

The state:

```text
isFavorite = false
```

determines what the UI displays.

After:

```dart
setState(() {
  isFavorite = true;
});
```

the UI becomes:

```text
❤️
```

This gives us a very important principle:

> **UI should be a representation of the current state.**

Think:

```text
          STATE
            │
            ▼
           UI
```

not:

```text
UI manually changing itself
```

---

# 13. Example: Favorite Button

```dart
class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() {
    return _FavoritePageState();
  }
}

class _FavoritePageState extends State<FavoritePage> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: toggleFavorite,
          icon: Icon(
            isFavorite
                ? Icons.favorite
                : Icons.favorite_border,
          ),
        ),
      ),
    );
  }
}
```

The important relationship:

```text
isFavorite
    │
    ├── false → favorite_border
    │
    └── true  → favorite
```

---

# 14. State Can Be More Than One Variable

Example:

```dart
class _ProfilePageState extends State<ProfilePage> {
  String username = 'Nayeem';
  bool isEditing = false;
  int followers = 100;
}
```

These can all be state if they:

* can change
* affect the UI
* belong to this widget's local responsibility

You can update them:

```dart
setState(() {
  isEditing = true;
});
```

or:

```dart
setState(() {
  followers++;
});
```

---

# 15. Multiple State Changes in One `setState()`

You can update multiple related values together.

```dart
setState(() {
  username = 'Flutter Developer';
  isEditing = false;
});
```

This is often clearer than calling:

```dart
setState(() {
  username = 'Flutter Developer';
});

setState(() {
  isEditing = false;
});
```

when the changes are part of the same logical state transition.

---

# 16. Example: Checkbox

A checkbox is a perfect example of local state.

```dart
class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() {
    return _TermsPageState();
  }
}

class _TermsPageState extends State<TermsPage> {
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: accepted,
      onChanged: (value) {
        setState(() {
          accepted = value ?? false;
        });
      },
    );
  }
}
```

Flow:

```text
User taps checkbox
       ↓
onChanged()
       ↓
accepted changes
       ↓
setState()
       ↓
build()
       ↓
Checkbox reflects new value
```

---

# 17. Example: Show / Hide Password

This is another common use case.

```dart
bool obscurePassword = true;
```

Then:

```dart
TextField(
  obscureText: obscurePassword,
  decoration: InputDecoration(
    suffixIcon: IconButton(
      onPressed: () {
        setState(() {
          obscurePassword = !obscurePassword;
        });
      },
      icon: Icon(
        obscurePassword
            ? Icons.visibility_off
            : Icons.visibility,
      ),
    ),
  ),
)
```

The state controls:

```text
obscurePassword
       │
       ├── true  → hide password
       │
       └── false → show password
```

---

# 18. Example: Loading State

This is particularly important for real applications.

Suppose you are making an API request.

You might have:

```dart
bool isLoading = false;
```

When starting:

```dart
setState(() {
  isLoading = true;
});
```

After completion:

```dart
setState(() {
  isLoading = false;
});
```

Then your UI can do:

```dart
if (isLoading)
  const CircularProgressIndicator()
else
  const Text('Data loaded');
```

The flow:

```text
Start request
     ↓
isLoading = true
     ↓
Show loading indicator
     ↓
API completes
     ↓
isLoading = false
     ↓
Show content
```

This pattern becomes very important when we study APIs in **Phase 4**.

---

# 19. State and User Interaction

A useful way to identify local state is to ask:

> **"Can the user interact with this widget and cause its value to change?"**

Examples:

| UI                  | Possible State    |
| ------------------- | ----------------- |
| Counter             | `count`           |
| Checkbox            | `isChecked`       |
| Switch              | `isEnabled`       |
| Favorite button     | `isFavorite`      |
| Tab selection       | `selectedIndex`   |
| Password visibility | `obscurePassword` |
| Loading indicator   | `isLoading`       |
| Search field        | `query`           |

---

# 20. `setState()` Is Local State Management

This is an important distinction.

`setState()` is a form of **local state management**.

It works extremely well when the state belongs to one screen or one small widget tree.

For example:

```text
CounterPage
    │
    └── counter
```

or:

```text
LoginForm
    │
    ├── email
    ├── password
    └── isLoading
```

You don't need a state-management package for every small state change.

---

# 21. When `setState()` Is a Good Choice

Use `setState()` when state is:

### Local

```text
One screen
```

### Simple

```text
bool
int
String
small model
```

### Closely tied to the UI

For example:

```text
selected tab
expanded/collapsed
loading
checkbox
visibility
```

---

# 22. When `setState()` Starts Becoming Difficult

Imagine:

```text
                    App
                     │
          ┌──────────┼──────────┐
          │          │          │
        Home       Cart      Profile
          │          │          │
          └──────┬───┴──────────┘
                 │
          Shared application state
```

Suppose all three screens need:

```text
Current User
Cart Items
Authentication Status
```

If you try to manually pass everything around:

```text
Home
 ↓ user
Cart
 ↓ user
Checkout
 ↓ user
Payment
```

your architecture can become difficult to maintain.

This is called **prop drilling** in some UI architectures: repeatedly passing data through layers that don't actually need to use it.

That's when dedicated state-management approaches become useful.

We'll study them later.

---

# 23. `setState()` Does Not Mean "Rebuild Everything"

Beginners sometimes think:

> "`setState()` rebuilds my entire application."

That's not the correct mental model.

`setState()` marks the associated `State` object as needing to rebuild.

Flutter then rebuilds the relevant widget subtree and efficiently updates the rendered result.

So don't be afraid of `setState()` just because a widget tree contains many widgets.

However, **where you place state** matters for performance and architecture.

---

# 24. State Placement Matters

Suppose you have:

```text
Screen
│
├── Header
├── Product List
└── Footer
```

If only the product list changes frequently, don't automatically make the entire screen responsible for every piece of state.

A better design may keep state closer to the widgets that need it.

Think:

> **Keep state as local as reasonably possible.**

This is a very useful professional principle.

---

# 25. A Bad Example

Imagine:

```dart
class _HomePageState extends State<HomePage> {
  bool isMenuOpen = false;
  bool isFavorite = false;
  bool isExpanded = false;
  int selectedTab = 0;
  bool isLoading = false;
}
```

This isn't automatically wrong.

But if the screen becomes huge and controls unrelated pieces of state, it may be a sign that responsibilities should be separated into smaller widgets.

For example:

```text
HomePage
│
├── Header
│   └── menu state
│
├── ProductCard
│   └── favorite state
│
└── BottomNavigation
    └── selected tab
```

State can often live closer to where it is used.

---

# 26. `setState()` and Async Code

You will frequently see:

```dart
Future<void> loadData() async {
  setState(() {
    isLoading = true;
  });

  final data = await fetchData();

  setState(() {
    isLoading = false;
  });
}
```

Conceptually:

```text
set loading
    ↓
await API
    ↓
update data
    ↓
set loading false
```

But there is an important lifecycle issue.

If the user leaves the screen while the asynchronous operation is running, the `State` object may no longer be mounted.

So in real asynchronous code, you may need:

```dart
if (!mounted) return;
```

before calling `setState()` after an `await`.

Example:

```dart
Future<void> loadData() async {
  setState(() {
    isLoading = true;
  });

  final data = await fetchData();

  if (!mounted) return;

  setState(() {
    isLoading = false;
  });
}
```

Don't worry if this feels unfamiliar.

We'll study asynchronous API work more deeply in Phase 4.

---

# 27. Never Call `setState()` After `dispose()`

A `State` object has a lifecycle.

Eventually it can be removed:

```text
Created
   ↓
Mounted
   ↓
Updated
   ↓
Disposed
```

Once disposed, it should no longer update its UI.

So code like:

```dart
setState(...)
```

after disposal can cause errors.

That's why:

```dart
if (!mounted) return;
```

is useful after asynchronous operations.

---

# 28. Don't Put Expensive Work Inside `setState()`

Avoid:

```dart
setState(() {
  performVeryExpensiveCalculation();
  counter++;
});
```

The callback should generally contain the state mutation.

Prefer:

```dart
final result = performVeryExpensiveCalculation();

setState(() {
  counter++;
  data = result;
});
```

The exact architecture depends on the situation, but the principle is:

> Keep `setState()` focused on state changes.

---

# 29. Don't Put API Calls Inside `build()`

This is a very common mistake.

❌ Avoid:

```dart
@override
Widget build(BuildContext context) {
  fetchData();

  return Scaffold(
    // ...
  );
}
```

Why?

Because `build()` can run many times.

You could accidentally trigger:

```text
build()
 ↓
API request
 ↓
build()
 ↓
API request
 ↓
build()
 ↓
...
```

We'll learn proper lifecycle methods such as:

```dart
initState()
```

when we discuss asynchronous data and lifecycle more deeply.

---

# 30. `setState()` and Immutability

This is a deeper concept.

Suppose:

```dart
List<String> names = [];
```

You can technically do:

```dart
setState(() {
  names.add('Nayeem');
});
```

and the UI can update.

But as applications grow, you'll encounter patterns where state is treated more immutably:

```dart
setState(() {
  names = [
    ...names,
    'Nayeem',
  ];
});
```

Why?

Because creating a new value can make state transitions easier to reason about.

Don't treat this as a strict requirement for every small Flutter example.

It's a concept that becomes much more important with modern state-management and architecture patterns.

---

# 🧠 31. The Most Important Mental Model

Think of your widget as a function of its state:

```text
UI = f(State)
```

For example:

```text
isFavorite = false
        ↓
UI = outline heart
```

Then:

```text
isFavorite = true
        ↓
UI = filled heart
```

The state changes.

Then Flutter rebuilds the relevant UI.

This is one of the fundamental ideas behind declarative UI.

---

# 32. Imperative vs Declarative Thinking

### Imperative thinking

You might think:

```text
"Change this icon to a filled heart."
```

### Declarative Flutter thinking

You say:

```dart
Icon(
  isFavorite
      ? Icons.favorite
      : Icons.favorite_border,
)
```

And change:

```dart
isFavorite
```

The UI description changes automatically when rebuilt.

So:

```text
State
  ↓
describes
  ↓
UI
```

This is a very important shift in mindset.

---

# 33. Complete Example — Todo Item

Let's combine everything.

```dart
class TodoItem extends StatefulWidget {
  final String title;

  const TodoItem({
    super.key,
    required this.title,
  });

  @override
  State<TodoItem> createState() {
    return _TodoItemState();
  }
}

class _TodoItemState extends State<TodoItem> {
  bool completed = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.title,
        style: TextStyle(
          decoration: completed
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      trailing: Checkbox(
        value: completed,
        onChanged: (value) {
          setState(() {
            completed = value ?? false;
          });
        },
      ),
    );
  }
}
```

Notice something new:

```dart
widget.title
```

Why?

Because:

```text
TodoItem
   │
   ├── immutable configuration
   │      └── title
   │
   └── mutable state
          └── completed
```

The `title` belongs to the `StatefulWidget`.

The changing `completed` value belongs to the `State`.

This distinction is extremely important.

---

# 34. Widget vs State

Think of it like this:

```text
StatefulWidget
│
│ immutable configuration
│
├── title
├── id
└── initial values
        │
        ▼
State
│
│ mutable state
│
├── isLoading
├── selected
└── counter
```

Inside the `State` class:

```dart
widget.title
```

accesses the widget's configuration.

While:

```dart
completed
```

accesses the mutable state.

---

# 35. Why Is the Widget Immutable?

Flutter widgets are designed to be immutable.

For example:

```dart
class TodoItem extends StatefulWidget {
  final String title;
}
```

Once created:

```dart
TodoItem(title: 'Learn Flutter')
```

that widget configuration doesn't simply mutate itself.

Instead, Flutter can create/update widget configurations while the associated `State` object manages the mutable state.

This separation is one of the reasons Flutter's widget system works the way it does.

---

# 36. Practical Examples of Local State

You should now be able to recognize state in everyday Flutter UI.

### Counter

```dart
int count;
```

### Switch

```dart
bool enabled;
```

### Checkbox

```dart
bool checked;
```

### Tab

```dart
int selectedIndex;
```

### Search

```dart
String query;
```

### Loading

```dart
bool isLoading;
```

### Password

```dart
bool obscureText;
```

### Expansion

```dart
bool isExpanded;
```

---

# ⚠️ Common Mistakes

## ❌ Mistake 1 — Changing state without `setState()`

```dart
counter++;
```

If the UI depends on `counter`, Flutter isn't notified.

Prefer:

```dart
setState(() {
  counter++;
});
```

---

## ❌ Mistake 2 — Calling `setState()` from a `StatelessWidget`

`setState()` belongs to the `State` object of a `StatefulWidget`.

You cannot do:

```dart
class MyWidget extends StatelessWidget {
  void change() {
    setState(() {});
  }
}
```

There is no `State` object there.

---

## ❌ Mistake 3 — Putting everything in one giant StatefulWidget

This can make your code difficult to maintain.

Break large UI into meaningful widgets and keep state close to where it belongs.

---

## ❌ Mistake 4 — Using state management packages for trivial state

You don't need a state-management library just to toggle:

```dart
bool isExpanded;
```

A simple:

```dart
setState()
```

may be exactly the right solution.

---

## ❌ Mistake 5 — Calling `setState()` after async work without considering lifecycle

Be aware of:

```dart
await
```

and whether the widget is still mounted.

---

# 📊 `setState()` Decision Guide

| Situation                      | `setState()`                |
| ------------------------------ | --------------------------- |
| Counter                        | ✅ Excellent                 |
| Checkbox                       | ✅ Excellent                 |
| Switch                         | ✅ Excellent                 |
| Selected tab                   | ✅ Excellent                 |
| Password visibility            | ✅ Excellent                 |
| Small form state               | ✅ Good                      |
| Loading state on one screen    | ✅ Good                      |
| Shared auth state              | ⚠️ Usually not enough       |
| Global cart                    | ⚠️ Usually not ideal        |
| Large shared application state | ❌ Consider state management |

---

# 🧪 Practice Project

Build a **Shopping Cart Screen** using only `StatefulWidget` and `setState()`.

Create:

```text
Product
├── name
├── price
└── quantity
```

Your screen should display:

```text
┌───────────────────────────┐
│ Shopping Cart             │
├───────────────────────────┤
│ Keyboard      $50         │
│             [-] 2 [+]     │
│                           │
│ Mouse         $30         │
│             [-] 1 [+]     │
├───────────────────────────┤
│ Total: $130               │
└───────────────────────────┘
```

### Requirements

Implement:

* Increase quantity
* Decrease quantity
* Prevent quantity from going below `0` or `1`
* Calculate total
* Update the UI using `setState()`
* Display an empty-cart message when appropriate

### ⭐ Challenge

Create separate widgets:

```text
CartPage
   │
   ├── CartItem
   │
   └── CartSummary
```

Then think carefully about:

> **Where should the state live?**

Don't immediately put everything inside `CartItem`.

This challenge is designed to prepare you for the next stage of Flutter architecture.

---

# 🎯 What You Should Know After This Lesson

You should be able to explain:

* What state means
* State vs ordinary data
* `StatelessWidget` vs `StatefulWidget`
* What `setState()` does
* Why `setState()` is necessary
* How `setState()` triggers a rebuild
* How state controls UI
* Local state management
* State placement
* `widget` vs `State`
* State with user interactions
* State with async operations
* Why `mounted` matters
* When `setState()` is appropriate
* When `setState()` starts becoming insufficient

---

# 🏁 Final Mental Model

Remember this:

```text
              USER ACTION
                   │
                   ▼
            Event / Callback
                   │
                   ▼
             Change State
                   │
                   ▼
              setState()
                   │
                   ▼
                build()
                   │
                   ▼
              Updated UI
```

And the fundamental relationship:

```text
                STATE
                  │
                  │ describes
                  ▼
                  UI
                  ▲
                  │
              user action
```

> **Don't think of `setState()` as "refresh the screen." Think of it as "the state changed; rebuild this part of the widget tree so the UI reflects the new state."**

---

## ⏭️ Next Topic

### **6. Form Validation**

We'll learn how to build professional Flutter forms with:

* `Form`
* `TextFormField`
* `GlobalKey<FormState>`
* Validators
* Validation messages
* `autovalidateMode`
* Submit handling
* Multiple-field validation
* Resetting forms
* Common form mistakes

This will take us from simple UI interactions toward **real application input handling**.
