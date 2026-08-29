# Phase 5 — State Management

## 03 — `setState()`

### 📚 What is `setState()`?

`setState()` is Flutter's simplest way to manage **local state** inside a `StatefulWidget`.

It tells Flutter:

> **"The state has changed. Rebuild this widget."**

---

## 🧠 How It Works

```text
User action
    ↓
Change state
    ↓
setState()
    ↓
Flutter rebuilds widget
    ↓
UI reflects new state
```

Example:

```dart
int count = 0;

void increment() {
  setState(() {
    count++;
  });
}
```

Here:

* `count++` → changes the state
* `setState()` → notifies Flutter
* `build()` → runs again
* `Text('$count')` → displays the new value

---

## 💻 Example

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

---

## ⚠️ Why `setState()` Is Necessary

This:

```dart
count++;
```

changes the variable, but Flutter isn't notified.

This:

```dart
setState(() {
  count++;
});
```

changes the variable **and tells Flutter to rebuild**.

So remember:

> **`setState()` does not magically manage your state. It tells Flutter that a state change occurred.**

---

## 🎯 When to Use It

Good use cases:

```text
isLoading
isPasswordVisible
selectedIndex
counter
checkbox value
temporary UI state
```

Use `setState()` when the state is **local to a widget or small part of the UI**.

For state shared across many parts of an application, we'll need a different approach.

---

## 🚀 Important Rule

Keep the state-changing operation inside `setState()`:

```dart
setState(() {
  count++;
});
```

Don't put expensive or unrelated work inside it.

The roadmap's next concept is **Shared State**, where we'll see why `setState()` alone becomes insufficient as an application grows. 
