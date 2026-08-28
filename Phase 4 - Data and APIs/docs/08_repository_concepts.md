# 🔵 Phase 4 — Data and APIs

## 5. Repository Concepts

> **Goal:** Understand why we use a Repository and what responsibility it has.

As your app grows, you don't want your UI to directly communicate with APIs.

Instead:

```text
UI
 ↓
Repository
 ↓
API / Service
 ↓
Backend
```

---

## 1. The Problem

Without a repository:

```dart
// UI
final response = await http.get(url);
```

Now your widget knows about:

* HTTP
* URLs
* API endpoints
* Response handling
* Data fetching

This makes the UI harder to maintain and test.

---

## 2. What Is a Repository?

A **Repository** acts as an abstraction between your application and its data sources.

For example:

```dart
class UserRepository {
  final UserService service;

  UserRepository(this.service);

  Future<List<User>> getUsers() async {
    return service.fetchUsers();
  }
}
```

The UI doesn't need to know **where** the users come from.

It simply asks:

```dart
final users = await repository.getUsers();
```

---

## 3. Repository vs Service

A simple distinction:

### Service

Deals with the actual data source/API:

```text
HTTP
API endpoint
JSON
```

Example:

```text
UserService
    ↓
GET /users
```

### Repository

Provides data to the rest of the application:

```text
UserRepository
    ↓
UserService
    ↓
API
```

Think:

```text
UI
 ↓
Repository → "I need users"
 ↓
Service    → "I'll call the API"
 ↓
API
```

---

## 4. Why Is This Useful?

Suppose later you change your data source:

```text
Today:
Repository → REST API

Later:
Repository → Local Database
```

Your UI can remain mostly unchanged.

That's the main idea:

> **The UI should care about the data it needs, not where that data comes from.**

---

## 5. Important Mental Model

For now, remember:

```text
┌──────────────┐
│      UI      │
└──────┬───────┘
       ↓
┌──────────────┐
│ Repository   │  ← Application-facing data access
└──────┬───────┘
       ↓
┌──────────────┐
│   Service    │  ← API / external source
└──────┬───────┘
       ↓
┌──────────────┐
│   Backend    │
└──────────────┘
```

You don't need to build a complex repository architecture yet. **Understand the responsibility and separation first.**

### Next: **6. Local Persistence**
