> (conceptual contents....)

# Phase 5 — State Management

## Topic 1: Understanding State

### 📚 What is State?

**State is data that can change during the lifetime of a widget/app and affects what the UI displays.**

For example:

```dart
int counter = 0;
```

Initially:

```text
Counter: 0
```

After the user presses a button:

```text
Counter: 1
```

The value `counter` changed, so the UI needs to update.

That changing data is **state**.

---

## 🧠 The Most Important Mental Model

Think of Flutter UI as a function of state:

```text
        State
          │
          ▼
        UI
```

When state changes:

```text
State changes
     │
     ▼
Flutter rebuilds relevant UI
     │
     ▼
User sees updated UI
```

So, instead of thinking:

> "How do I manually change this Text?"

Think:

> "What state should this Text represent?"

---

## 💻 Simple Example

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
    return Scaffold(
      body: Center(
        child: Text('$count'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

Here:

```dart
int count = 0;
```

is the **state**.

When:

```dart
count++;
```

the state changes.

But Flutter doesn't automatically know that it needs to rebuild the UI.

That's why we use:

```dart
setState(() {
  count++;
});
```

---

## 🔑 What `setState()` Actually Means

`setState()` essentially tells Flutter:

> **"The state used by this widget has changed. Rebuild this widget's UI."**

For example:

```dart
setState(() {
  count++;
});
```

The important part is not that `setState()` changes the variable.

This changes the variable:

```dart
count++;
```

`setState()` **notifies Flutter that the change should be reflected in the UI.**

---

## State vs Normal Variable

Consider:

```dart
int count = 0;

void increment() {
  count++;
}
```

The variable changes, but Flutter isn't notified.

Therefore, the UI may still show:

```text
0
```

With:

```dart
void increment() {
  setState(() {
    count++;
  });
}
```

Flutter knows it needs to rebuild.

```text
count changes
     ↓
setState()
     ↓
build() runs again
     ↓
Text('$count')
     ↓
UI shows new value
```

---

## 🎯 What Counts as State?

Common examples:

* Counter value
* Whether a button is loading
* Whether a password is visible
* Selected tab
* Selected item
* Text entered by the user
* Whether a checkbox is checked
* Data loaded from an API
* Current user information
* Shopping cart items

For example:

```dart
bool isLoading = false;
bool isLoggedIn = false;
int selectedIndex = 0;
String username = '';
```

These can all represent state.

---

## 🏗️ Local State vs App State

Not all state needs a state-management library.

### Local State

State used by one widget or a small part of the UI.

Example:

```dart
bool isPasswordVisible = false;
```

A simple `StatefulWidget` + `setState()` is often enough.

### Shared/App State

State needed by multiple unrelated parts of the application.

For example:

```text
User
 ├── Profile Screen
 ├── Home Screen
 ├── Settings Screen
 └── Checkout Screen
```

If all these screens need the same user information, managing it individually becomes difficult.

This is where **state-management solutions** such as Riverpod or BLoC become useful.

---

## 🧠 Why State Management Exists

Imagine an application with:

```text
        App State
           │
     ┌─────┼─────┐
     ▼     ▼     ▼
   Home  Cart  Profile
```

As an application grows, you need a reliable way to:

* Store state
* Update state
* Share state
* React to state changes
* Keep UI and business logic organized

That's the problem **state management** tries to solve.

---

## 🚀 Our Learning Path

For this phase, don't memorize state-management libraries.

We'll build the concept progressively:

```text
setState
   ↓
Understand State
   ↓
Understand shared state
   ↓
Understand state flow
   ↓
Riverpod / BLoC
```

The important thing is to understand **why** a state-management solution is needed before learning its API.

> **Core idea:** Flutter UI should be a predictable representation of your current state.
