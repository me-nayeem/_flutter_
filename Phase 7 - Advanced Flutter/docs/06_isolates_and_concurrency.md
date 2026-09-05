# Phase 7 — Advanced Flutter

## Topic 6: Isolates and Concurrency

> **Core idea:** Flutter's UI runs on the **main isolate**. Keep heavy CPU work away from it so the UI remains responsive.

---

## 1. Main Isolate

When your Flutter app starts, your Dart code normally runs on the **main isolate**.

It handles things such as:

```text
User input
    ↓
Flutter framework
    ↓
Build / layout / paint
    ↓
UI
```

If you perform a heavy CPU operation there, the isolate becomes busy and the UI can **freeze or stutter**.

---

## 2. `async` Does NOT Solve CPU-Heavy Work

This is important.

`async/await` is excellent for **waiting on asynchronous operations** such as network requests:

```dart
final data = await fetchData();
```

But it doesn't automatically move CPU-intensive work to another isolate.

For example:

```dart
// Heavy computation
for (var i = 0; i < 1000000000; i++) {
  // expensive calculation
}
```

Running this on the main isolate can block the UI.

---

## 3. Isolates

An **isolate** is an independent Dart execution environment with its own memory.

Mental model:

```text
Main Isolate                 Worker Isolate
┌──────────────┐             ┌──────────────┐
│ UI           │             │ Heavy CPU    │
│ Widgets      │             │ computation  │
│ User input   │             │              │
└──────┬───────┘             └──────▲───────┘
       │                              │
       └──── Messages ───────────────┘
```

Unlike threads that share memory, isolates communicate by **passing messages**.

---

## 4. Message Passing

Isolates don't directly access each other's variables.

Instead:

```text
Main Isolate
     │
     │ send data
     ▼
Worker Isolate
     │
     │ process
     ▼
Main Isolate
```

This makes concurrency safer because the isolates don't share mutable memory.

---

## 5. `compute()`

For a relatively simple CPU-intensive function, Flutter provides `compute()`.

```dart
final result = await compute(calculate, data);
```

The computation runs away from the main isolate, allowing the UI to remain responsive.

The function passed to `compute()` should be suitable for isolate execution—for example, a **top-level or static function** rather than a closure that depends on surrounding state.

---

## 6. When Should You Use Isolates?

Don't use isolates for every asynchronous operation.

### Usually unnecessary:

```text
HTTP request
Database waiting
File I/O
```

These are generally **I/O-bound** operations.

### Consider isolates for:

```text
Large JSON parsing
Image/data processing
Complex calculations
Large data transformations
Other CPU-intensive work
```

The key question is:

> **Will this operation spend significant CPU time and potentially block the UI?**

If yes, consider moving it to another isolate.

---

## 🧠 Mental Model

Remember these three concepts:

```text
async/await
    ↓
Good for waiting

Isolate
    ↓
Separate execution + memory

compute()
    ↓
Convenient way to run a computation in another isolate
```

And the most important rule:

> **Keep the main isolate responsive. Move genuinely CPU-intensive work away from it.**
