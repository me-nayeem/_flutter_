# Phase 5 — Topic 5: Reactive State Management

**Reactive state management** means the UI **automatically updates when the state changes**.

### Without reactive state

```text
State changes
     ↓
UI doesn't automatically know
     ↓
Need to manually update UI
```

### With reactive state

```text
State changes
     ↓
State notifies UI
     ↓
Widget rebuilds
     ↓
UI shows new data
```

### Simple Flutter example

Suppose:

```dart
int count = 0;
```

When the user presses a button:

```dart
count++;
```

With reactive state management, Flutter knows that `count` changed and rebuilds the relevant UI:

```text
count = 0
   ↓
User taps button
   ↓
count = 1
   ↓
UI automatically updates
```

### Real-world example

For a shopping cart:

```text
Cart State
   ↓
items = 2
   ↓
User adds product
   ↓
items = 3
   ↓
┌───────────────┐
│ Cart (3) 🛒   │ ← automatically updates
└───────────────┘
```

### Key idea

> **Reactive state = State changes → UI reacts automatically.**

This is the foundation behind state-management approaches such as **Provider, Riverpod, Bloc, Cubit**, etc.
