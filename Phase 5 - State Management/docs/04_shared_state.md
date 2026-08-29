## Phase 5 — Topic 4: Shared State

**Shared state** means **state that needs to be accessed or changed by multiple widgets or different parts of your Flutter app**.

### Simple example

Imagine:

```text
HomeScreen
   │
   ├── Counter
   │
   └── Cart
```

Both widgets need to know the same:

```dart
int cartCount = 5;
```

Instead of keeping separate copies, you keep the state somewhere shared:

```text
             Shared State
                 │
          ┌──────┴──────┐
          ↓             ↓
      HomeScreen     CartScreen
          │             │
          └──────┬──────┘
                 ↓
          Same state/data
```

### Local state vs shared state

**Local state:**

```text
Counter Widget
     ↓
counter = 0
```

Only that widget cares about it.

**Shared state:**

```text
              counter = 0
                   │
          ┌────────┴────────┐
          ↓                 ↓
      Widget A          Widget B
```

Multiple widgets need the same state.

### Why do we need shared state?

Without it, you may end up:

* Passing data through many widget constructors
* Duplicating the same state
* Making state updates difficult to manage
* Creating inconsistent UI

### Common examples

Shared state is useful for:

```text
🛒 Shopping cart
👤 Logged-in user
🌙 Theme
🔔 Notifications
❤️ Favorites
🌐 App-wide settings
```

### Important idea

> **Local state = one part of the UI owns the state.**
> **Shared state = multiple parts of the UI need the same state.**

And this naturally leads to the next topics in your Phase 5:

```text
04 Shared State
      ↓
05 Reactive State Management
      ↓
06 Choosing a State Management Solution
      ↓
07 State Management Architecture
```

