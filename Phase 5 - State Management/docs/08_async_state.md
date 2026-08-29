# Phase 5 — Topic 8: Async State

**Async state** is the state of an operation that takes time to complete, such as:

* API requests
* Database operations
* File loading
* Authentication
* Any `Future`/`Stream` operation

The key idea:

> **Async state tells the UI what is happening while waiting for an asynchronous operation.**

---

## 1. The Problem

Suppose your Flutter app loads tasks from an API:

```text
Flutter App
    ↓
API Request
    ↓
     ?
```

The request doesn't finish immediately.

During that time, what should the UI show?

Usually:

```text
Loading...
```

If the request succeeds:

```text
Tasks displayed
```

If it fails:

```text
Something went wrong
```

So we need to represent different states.

---

# 2. Common Async States

A simple model is:

```text
Async State
   │
   ├── Loading
   ├── Success
   └── Error
```

For example:

```text
Loading
   ↓
API request
   ↓
 ┌───────────┐
 │           │
 ▼           ▼
Success     Error
```

---

## Loading

The operation is currently running.

```text
┌─────────────────────┐
│                     │
│     Loading...      │
│        ⟳            │
│                     │
└─────────────────────┘
```

---

## Success

The operation completed successfully.

```text
┌─────────────────────┐
│ Today's Tasks       │
│                     │
│ ☑ Learn Dart        │
│ ☐ Learn Flutter     │
│ ☐ Learn REST API    │
│                     │
└─────────────────────┘
```

---

## Error

Something went wrong.

```text
┌─────────────────────┐
│                     │
│ Failed to load      │
│ tasks.              │
│                     │
│      [Retry]        │
│                     │
└─────────────────────┘
```

---

# 3. Why Async State Matters

Without proper async state management, you might have code like:

```text
API request
   ↓
???
```

The user doesn't know whether:

* the app is loading
* the request failed
* there is no data
* the request succeeded

With async state:

```text
Loading → Success
Loading → Error
```

the UI can accurately represent what's happening.

---

# 4. Example with Flutter

Conceptually:

```dart
enum Status {
  loading,
  success,
  error,
}
```

Then your state might contain:

```dart
Status status;
List<Task> tasks;
String? error;
```

When requesting data:

```text
status = loading
```

After success:

```text
status = success
tasks = [...]
```

After failure:

```text
status = error
error = "Failed to load tasks"
```

The UI reacts accordingly.

---

# 5. Async State with `Future`

A common Flutter operation is:

```dart
Future<List<Task>> getTasks()
```

The `Future` represents a value that will become available **later**.

Conceptually:

```text
Future
  │
  ├── Waiting
  │
  ├── Completed successfully
  │
  └── Completed with error
```

For example:

```dart
Future<List<Task>> getTasks() async {
  // API request
}
```

The UI needs to handle the possible outcomes.

---

# 6. Real Application Example

Imagine opening your Study Tracker:

```text
App starts
   ↓
Request tasks
   ↓
Loading
   ↓
Server responds
   ↓
Success
   ↓
Display tasks
```

If the server fails:

```text
App starts
   ↓
Request tasks
   ↓
Loading
   ↓
Network error
   ↓
Error
   ↓
Show Retry
```

This is the basic pattern you'll see repeatedly in real Flutter applications.

---

# 7. Async State Is More Than Loading/Success/Error

In larger applications, you may need more detailed states:

```text
Initial
Loading
Success
Error
Refreshing
Empty
Loading More
```

For example:

```text
Success
   ↓
User pulls to refresh
   ↓
Refreshing
   ↓
New data
   ↓
Success
```

Notice that during **refreshing**, you may want to keep showing the existing data rather than replacing the whole screen with a loading spinner.

That's an important UX consideration.

---

# Professional Mental Model

Whenever your Flutter code performs an asynchronous operation, think:

```text
          Async Operation
                │
        ┌───────┼────────┐
        ↓       ↓        ↓
     Loading  Success   Error
                │
                ↓
               Data
```

Then ask:

> **"What should my UI display in each state?"**

That's the heart of **async state management**.

