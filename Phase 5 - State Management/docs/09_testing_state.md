## Phase 5 — Topic 9: Testing State

**Testing state** means checking whether your state-management logic behaves correctly when the state changes.

For example, if a user logs in:

```text
Login
  ↓
Loading
  ↓
Success
```

You want to verify that each state is produced correctly.

### What should you test?

For a typical state:

```text
Initial
  ↓
Loading
  ↓
Success
```

and also:

```text
Initial
  ↓
Loading
  ↓
Error
```

For example, when loading tasks:

```text
API request
    ↓
Loading state
    ↓
 ┌───────────┐
 ↓           ↓
Success     Error
 ↓           ↓
Tasks       Error message
```

### Example

Suppose you have:

```dart
class TaskState {
  final bool isLoading;
  final List<String> tasks;
  final String? error;
}
```

You should test things like:

```text
✓ Initially → not loading
✓ Request starts → loading = true
✓ API succeeds → tasks are available
✓ API fails → error is available
✓ Retry → request starts again
```

### Why test state separately?

Your UI might look correct but the underlying logic could still be wrong.

Testing state lets you verify:

> **Given this action/input → does the application produce the correct state?**

### Professional mental model

```text
Action
   ↓
State Logic
   ↓
New State
   ↓
Test whether state is correct
```

For example:

```text
"Add Task"
    ↓
TaskController
    ↓
Task Added State
    ↓
Test ✓
```

In larger Flutter applications, state-management logic is often tested independently from widgets, making bugs easier to find and the code easier to maintain.

