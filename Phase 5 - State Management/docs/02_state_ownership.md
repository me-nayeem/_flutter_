# Phase 5 — State Management

## 02 — State Ownership

### 📚 Concept

**State ownership** means deciding **which widget should be responsible for storing and changing a piece of state**.

The key question is:

> **"Who needs this state?"**

---

### 🧠 Mental Model

If only one widget needs the state:

```text
Widget
 └── owns the state
```

If multiple widgets need the same state:

```text
       State Owner
        /       \
       ▼         ▼
   Widget A   Widget B
```

The state should generally live at the **lowest common ancestor** of the widgets that need it.

---

### 💻 Example

Suppose a parent has two children:

```text
Parent
 ├── CounterText
 └── IncrementButton
```

Both need `count`.

So the **Parent should own `count`**:

```dart
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$count'),
        ElevatedButton(
          onPressed: increment,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

The parent owns the state and provides what the children need.

---

### 🚀 Best Practice

Don't keep state higher in the widget tree **unless necessary**.

```text
Too high
    ↓
More widgets depend on it
    ↓
More unnecessary rebuilds / complexity
```

Keep state as close as reasonably possible to where it is needed.

> **State should have a clear owner.**

---

# 03 — `setState()`

### 📚 Concept

`setState()` is Flutter's basic mechanism for telling a `StatefulWidget`:

> **"My state changed. Rebuild this widget."**

```dart
setState(() {
  count++;
});
```

Here:

```text
count++     → changes the state
setState()  → notifies Flutter
build()     → runs again
UI          → updates
```

---

### 💻 Example

```dart
int count = 0;

void increment() {
  setState(() {
    count++;
  });
}
```

Without `setState()`:

```dart
count++;
```

the variable changes, but Flutter isn't explicitly told to rebuild.

---

### ⚠️ Important

`setState()` is mainly for **local state**.

Good:

```dart
bool isLoading = false;
bool isVisible = true;
int selectedIndex = 0;
```

Not ideal when the same state must be shared across many unrelated screens.

---

### 🎯 Core Idea

```text
setState()
    ↓
Notify Flutter
    ↓
Rebuild State object's widget subtree
```

---

# 04 — Shared State

### 📚 Concept

**Shared state** is state that multiple widgets or screens need to access or modify.

Example:

```text
              Cart State
             /    |    \
            ▼     ▼     ▼
         Home   Cart   Checkout
```

All three parts of the application may need the same cart information.

---

### 💻 Example

Imagine:

```dart
List<Product> cart = [];
```

If `HomeScreen` adds products and `CartScreen` displays them, both need access to the same state.

Keeping separate copies creates problems:

```text
Home → cart A
Cart → cart B
```

They can become inconsistent.

We want:

```text
        One source of truth
               │
       ┌───────┼───────┐
       ▼       ▼       ▼
     Home     Cart   Checkout
```

---

### 🧠 Key Idea

**Shared state should have a single source of truth.**

Don't duplicate the same state across multiple widgets unless there is a good reason.

---

# 05 — Reactive State Management

### 📚 Concept

Flutter follows a **reactive UI model**.

Instead of manually telling every UI component how to change, we describe:

> **"Given the current state, this is what the UI should look like."**

```text
       State
         │
         ▼
        UI
```

When state changes:

```text
State changes
      ↓
Notification
      ↓
Relevant UI rebuilds
```

---

### 💻 Example

```dart
Text(isLoading ? 'Loading...' : 'Loaded')
```

The UI depends on `isLoading`.

If:

```dart
isLoading = true;
```

the UI represents loading.

If:

```dart
isLoading = false;
```

the UI represents the loaded state.

You don't manually change the `Text`.

You change the **state**, and the UI reacts.

---

### 🧠 Mental Model

Think:

```text
UI = f(state)
```

Same state → same UI representation.

This reactive mindset becomes extremely important when we move to Riverpod/BLoC.

---

# 06 — Choosing a State Management Solution

### 📚 Concept

There is no single state-management solution that is best for every application.

The choice depends on:

* How much state you have
* How widely it is shared
* How complex state transitions are
* Team/project requirements
* Testing needs
* Developer familiarity

---

### 🧭 Our Learning Path

We don't need to learn five libraries.

```text
setState
   ↓
Understand state
   ↓
Understand shared state
   ↓
Choose ONE solution
   ↓
Use it properly
```

For this roadmap, we'll focus on **one modern solution deeply**, rather than superficially learning many.

The roadmap specifically recommends not learning multiple state-management libraries at once. 

---

### 🚫 Don't Do This

```text
setState
Riverpod
BLoC
Provider
Redux
GetX
MobX
...
```

all at the same time.

That teaches APIs, not state-management concepts.

---

# 07 — State Management Architecture

### 📚 Concept

As applications grow, the important question becomes:

> **Where should state, business logic, and UI logic live?**

A basic structure might look like:

```text
UI
 │
 ▼
State / ViewModel
 │
 ▼
Repository / Data
```

The UI should not become responsible for everything.

---

### ❌ Poor Structure

```text
UI
 ├── API call
 ├── JSON parsing
 ├── business logic
 ├── state
 └── UI
```

This becomes difficult to maintain.

### ✅ Better Separation

```text
UI
 │
 ▼
State / Logic
 │
 ▼
Repository
 │
 ▼
API / Database
```

This makes responsibilities clearer.

---

### 🧠 Key Idea

State management is not only about:

> "Which package should I use?"

It is also about **how state flows through the application**.

This connects directly with the architecture phase, where we'll study UI/data layers, view models, repositories, dependency injection, unidirectional data flow, separation of concerns, and testability. 

---

# 08 — Async State

### 📚 Concept

Real applications often have state that comes from asynchronous operations:

* API requests
* Database queries
* Authentication
* File operations

An async operation usually has multiple possible states.

For example:

```text
Loading
   ↓
Success
```

or:

```text
Loading
   ↓
Error
```

---

### 💻 Example

Instead of thinking only:

```dart
List<Movie> movies;
```

think about the complete state:

```text
Loading
Success(data)
Error(message)
```

A UI can then react appropriately:

```text
Loading → show progress indicator

Success → show movies

Error → show error message
```

---

### 🧠 Mental Model

```text
        Async Operation
              │
      ┌───────┼────────┐
      ▼       ▼        ▼
   Loading  Success   Error
```

This becomes especially important when using Riverpod/BLoC.

---

# 09 — Testing State

### 📚 Concept

State-management logic should be **testable without depending heavily on the UI**.

For example, suppose:

```text
Initial count = 0
       ↓
increment()
       ↓
Expected count = 1
```

You should be able to test that logic independently.

---

### 🧪 Example

Conceptually:

```text
Given: count = 0

When: increment()

Then: count = 1
```

For async state:

```text
Given: initial state

When: API succeeds

Then: state becomes Success(data)
```

And:

```text
Given: initial state

When: API fails

Then: state becomes Error
```

---

### 🚀 Why This Matters

If your state logic is mixed tightly with UI code:

```text
UI + State + Business Logic
```

testing becomes harder.

If responsibilities are separated:

```text
UI
 ↓
State Logic
 ↓
Repository
```

each part becomes easier to test.

---

# 🎯 Phase 5 Flow

You should now have this mental model:

```text
What is State?
      ↓
Who owns State?
      ↓
How does setState update it?
      ↓
How do we share State?
      ↓
How does UI react to State?
      ↓
Which solution should we use?
      ↓
How should State be architected?
      ↓
How do we handle async State?
      ↓
How do we test State?
```
