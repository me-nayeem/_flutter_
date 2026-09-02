# Phase 6 — Architecture

## 1. Why Architecture Exists

Architecture is basically **how we organize an application so it remains manageable as it grows**.

### 1. Complexity

As an app grows, it contains more:

* Screens
* Features
* API calls
* Database operations
* Business logic

Without structure, everything becomes difficult to understand.

> **Architecture helps manage complexity.**

---

### 2. Coupling

**Coupling = how strongly different parts of code depend on each other.**

Bad:

```text
UI → directly depends on API
UI → directly depends on Database
```

Changing the API may break the UI.

Good:

```text
UI → ViewModel → Repository → API
```

Parts are more independent.

> **Good architecture reduces unnecessary coupling.**

---

### 3. Maintainability

**Maintainability = how easily you can modify, fix, or improve the application.**

For example, if your API changes, you should ideally modify the data layer rather than 20 different screens.

> **Good architecture makes changes easier.**

---

### 4. Scalability

**Scalability = the ability to grow the application without the codebase becoming unmanageable.**

A small app might have:

```text
5 screens
2 APIs
```

Later:

```text
50 screens
20 APIs
Database
Authentication
Payments
Notifications
```

Architecture gives you a structure that can handle this growth.

> **Architecture helps the codebase scale with the application.**

---

### 5. Testability

You should be able to test different parts independently.

For example:

```text
ViewModel → test separately
Repository → test separately
Business logic → test separately
UI → test separately
```

Good architecture makes dependencies easier to replace with fake/test implementations.

> **Architecture makes testing easier.**

---

### 6. Separation of Concerns

Each part should have a **clear responsibility**.

Instead of:

```text
UI
 ├── API
 ├── Database
 ├── Business Logic
 ├── Authentication
 └── Everything
```

we separate them:

```text
UI
 ↓
ViewModel
 ↓
Repository
 ↓
Data Source
```

> **Each component focuses on what it is responsible for.**

---

## ⭐ Easy way to remember

```text
Architecture exists to manage:

Complexity      → Keep things organized
Coupling         → Reduce unnecessary dependencies
Maintainability  → Make changes easier
Scalability      → Handle application growth
Testability      → Make testing easier
Separation       → Give each part a clear responsibility
```

### One-line definition:

> **Architecture is about organizing code so that a growing application stays understandable, maintainable, testable, and flexible.**
