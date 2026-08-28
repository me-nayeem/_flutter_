# 🔵 Phase 4 — Data and APIs

## 4. Loading, Empty & Error States

When you fetch data from an API, the UI should handle **four possible states**:

```text
API Request
    │
    ├── Loading
    │
    ├── Success + Data
    │
    ├── Success + Empty
    │
    └── Error
```

This is a fundamental pattern for real Flutter apps.

---

## 1. Loading State

While waiting for the API:

```dart
bool isLoading = true;
```

Show something like:

```dart
const CircularProgressIndicator()
```

Example:

```dart
if (isLoading) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}
```

The user should never be left wondering whether the app is doing something.

---

## 2. Success State

If the request succeeds and data exists:

```dart
if (users.isNotEmpty) {
  return ListView.builder(
    itemCount: users.length,
    itemBuilder: (context, index) {
      return Text(users[index].name);
    },
  );
}
```

---

## 3. Empty State

A successful API request doesn't necessarily mean there is data.

For example:

```json
[]
```

The API worked, but there are no users.

Show a meaningful UI:

```dart
if (users.isEmpty) {
  return const Center(
    child: Text('No users found'),
  );
}
```

Don't treat an empty list as an error.

```text
200 OK + [] → Empty state
500         → Error state
```

---

## 4. Error State

If the request fails:

```dart
String? errorMessage;
```

Then:

```dart
if (errorMessage != null) {
  return Center(
    child: Text(errorMessage!),
  );
}
```

You can also provide a retry button:

```text
Something went wrong.

       [ Retry ]
```

---

# 5. The Complete Mental Model

A typical API screen should behave like:

```text
                API Request
                     │
                     ▼
                  Loading
                     │
             ┌───────┴───────┐
             ▼               ▼
          Success           Error
             │
       ┌─────┴─────┐
       ▼           ▼
     Data         Empty
       │           │
       ▼           ▼
   Show List    Show Empty UI
```

A simple state representation could be:

```dart
bool isLoading = false;
String? errorMessage;
List<User> users = [];
```

But as your apps become larger, managing several booleans becomes harder. Later, **state management and architecture** will give us cleaner ways to represent these states.

### Key principle

> **Every API-driven screen should have a deliberate loading, success, empty, and error experience.**

Next topic: **Repository Concepts**.
