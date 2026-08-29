# Phase 5 — Topic 7: State Management Architecture

Now we're moving from **"how to manage state"** to **"how to organize state management in a real application."**

The main idea is:

> **State management architecture defines where your state lives, who can change it, and how the UI gets the updated data.**

---

## 1. Why do we need architecture?

In a small app, you might do:

```dart
setState(() {
  count++;
});
```

That's fine.

But imagine a large app:

```text
Login
Profile
Home
Cart
Orders
Notifications
Settings
```

If every widget directly handles API calls, business logic, and state, your code can become messy:

```text
UI
 ├── API calls
 ├── Database
 ├── Business logic
 ├── State
 └── Validation
```

This becomes difficult to:

* maintain
* test
* debug
* reuse
* modify

So we separate responsibilities.

---

# 2. Basic Architecture

A common idea is:

```text
UI
 ↓
State Management
 ↓
Business Logic
 ↓
Repository / Data Layer
 ↓
API / Database
```

For example:

```text
┌──────────────┐
│     UI       │
│   Widgets    │
└──────┬───────┘
       ↓
┌──────────────┐
│ State/Logic  │
└──────┬───────┘
       ↓
┌──────────────┐
│ Repository   │
└──────┬───────┘
       ↓
┌──────────────┐
│ API / Local  │
│   Database   │
└──────────────┘
```

Each layer has a clear responsibility.

---

## 3. UI Layer

The UI's primary job is to **display state and receive user actions**.

For example:

```text
User taps "Add Task"
        ↓
UI sends event/action
        ↓
State management handles it
```

The UI shouldn't contain lots of business logic.

Instead of:

```dart
onPressed: () {
  // 100 lines of business logic
}
```

you ideally have something conceptually like:

```dart
onPressed: () {
  taskController.addTask();
}
```

The UI says **what happened**, while another layer handles **what should happen**.

---

# 4. State Management Layer

This layer manages application state.

For example:

```text
Task State
├── loading
├── tasks
├── error
└── success
```

When something changes:

```text
User adds task
      ↓
State changes
      ↓
UI reacts
```

This is where solutions such as Provider, Riverpod, Bloc/Cubit, etc. can be used.

---

# 5. Repository / Data Layer

The repository handles **where data comes from**.

For example:

```text
TaskRepository
    │
    ├── API
    │
    └── Local Database
```

The UI doesn't need to know whether the task came from:

```text
REST API
```

or:

```text
Local database
```

It simply asks:

```dart
final tasks = await repository.getTasks();
```

This separation is very useful.

---

# 6. Real Example

Imagine a Flutter Study Tracker.

User opens the task screen:

```text
          TaskScreen
              ↓
        TaskController
              ↓
        TaskRepository
          ↙       ↘
      Local DB    REST API
```

Suppose the repository gets tasks from the API:

```text
API
 ↓
Repository
 ↓
Controller
 ↓
State updated
 ↓
UI rebuilds
```

If the API fails:

```text
API ❌
 ↓
Repository
 ↓
Error State
 ↓
UI shows error
```

The UI doesn't need to implement the networking logic itself.

---

# 7. Why this architecture is useful

### Separation of concerns

Each part has a specific responsibility:

```text
UI              → Display
State management → Manage state
Business logic   → Decide what should happen
Repository       → Coordinate data
Data source      → API / Database
```

This follows the same general goal you've seen in **SOLID**: keep responsibilities separated and make code easier to maintain. Your uploaded Dart material describes SOLID as principles for maintainable and scalable code. 

---

# 8. The Professional Mental Model

Don't think:

> "Where should I put my Provider/Bloc/Riverpod?"

Think:

> **"Who owns this state?"**
> **"Who is allowed to change it?"**
> **"Where does the data come from?"**
> **"How does the UI react to changes?"**

A good architecture might look like:

```text
                    UI
                     │
                     ▼
              State Management
                     │
                     ▼
               Business Logic
                     │
                     ▼
                Repository
                /         \
               ↓           ↓
          Local Data    Remote Data
               │           │
               ↓           ↓
          Database        API
```

### Remember

> **UI displays → State manages → Logic decides → Repository provides data → Data sources store/fetch data.**

That's the core idea behind **state management architecture**.
