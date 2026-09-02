# Phase 6 — Architecture

## 8. Dependency Injection (DI)

Now we reach one of the **most important architecture concepts**:

> **Dependency Injection means giving an object the dependencies it needs from outside instead of making the object create those dependencies itself.**

It sounds complicated, but the idea is actually simple.

---

# 1. First: What is a Dependency?

A **dependency** is something a class needs in order to do its job.

For example:

```dart
class UserViewModel {
  final UserRepository repository;

  UserViewModel(this.repository);
}
```

Here:

```text
UserViewModel
      ↓
needs
      ↓
UserRepository
```

So `UserRepository` is a **dependency** of `UserViewModel`.

---

# 2. The Problem Without Dependency Injection

Suppose you write:

```dart
class UserViewModel {
  final UserRepository repository = UserRepository();

  void loadUsers() {
    repository.getUsers();
  }
}
```

The ViewModel is creating its own dependency:

```text
UserViewModel
      │
      └── creates → UserRepository
```

This creates **tight coupling**.

The ViewModel is now directly tied to a specific implementation.

---

# 3. The Better Approach

Instead:

```dart
class UserViewModel {
  final UserRepository repository;

  UserViewModel(this.repository);

  void loadUsers() {
    repository.getUsers();
  }
}
```

Now somebody else creates the repository:

```dart
final repository = UserRepository();
final viewModel = UserViewModel(repository);
```

The dependency is **injected** into the ViewModel.

```text
Outside
  │
  ├── creates Repository
  │
  ↓
ViewModel
  ↑
  │
Repository
```

That's Dependency Injection.

---

# 4. Constructor Injection

The most common and straightforward form is **constructor injection**.

```dart
class UserViewModel {
  final UserRepository repository;

  UserViewModel(this.repository);
}
```

The dependency is passed through the constructor:

```dart
final viewModel = UserViewModel(repository);
```

This is called:

> **Constructor Injection**

---

# 5. Why Constructor Injection Is Good

It makes dependencies explicit.

When you see:

```dart
UserViewModel(
  repository,
)
```

you immediately know:

> "This ViewModel requires a repository."

Compare that with hidden dependencies:

```dart
class UserViewModel {
  void loadUsers() {
    final repository = UserRepository();
  }
}
```

You can't easily control or replace that repository.

---

# 6. Dependency Inversion

DI is closely related to the **Dependency Inversion Principle (DIP)** from SOLID.

The basic idea is:

> **High-level code should depend on abstractions, not concrete implementations.**

Instead of:

```text
ViewModel
    ↓
UserRepositoryImpl
```

prefer:

```text
ViewModel
    ↓
UserRepository (abstraction)
    ↑
UserRepositoryImpl
```

For example:

```dart
abstract class UserRepository {
  Future<List<User>> getUsers();
}
```

Implementation:

```dart
class UserRepositoryImpl implements UserRepository {
  @override
  Future<List<User>> getUsers() async {
    // actual implementation
    return [];
  }
}
```

ViewModel:

```dart
class UserViewModel {
  final UserRepository repository;

  UserViewModel(this.repository);
}
```

Now the ViewModel doesn't care about the concrete implementation.

---

# 7. Why Abstraction Matters

Suppose you have:

```dart
class UserRepositoryImpl implements UserRepository {
  ...
}
```

Today you inject:

```dart
UserViewModel(
  UserRepositoryImpl(),
);
```

Tomorrow you might want:

```dart
FakeUserRepository
```

for testing.

```dart
class FakeUserRepository implements UserRepository {
  @override
  Future<List<User>> getUsers() async {
    return [
      User(name: "Test User"),
    ];
  }
}
```

Then:

```dart
final viewModel = UserViewModel(
  FakeUserRepository(),
);
```

The ViewModel doesn't need to change.

That's a major benefit of DI.

---

# 8. Dependency Graph

In a real application, dependencies form a graph.

For example:

```text
UserViewModel
      ↓
UserRepository
      ↓
UserApiService
      ↓
ApiClient
```

Someone needs to create all of these:

```text
ApiClient
   ↓
UserApiService
   ↓
UserRepository
   ↓
UserViewModel
```

Without DI, each class might create the next one itself.

With DI, we can construct them externally.

---

# 9. Manual Dependency Injection

You don't need a package to use Dependency Injection.

You can simply do it manually:

```dart
void main() {
  final apiClient = ApiClient();

  final apiService = UserApiService(
    apiClient,
  );

  final repository = UserRepositoryImpl(
    apiService,
  );

  final viewModel = UserViewModel(
    repository,
  );
}
```

This is already Dependency Injection.

Notice the direction:

```text
ApiClient
    ↓
ApiService
    ↓
Repository
    ↓
ViewModel
```

Each dependency is created outside and passed in.

---

# 10. Service Registration

As an application becomes larger, manually creating everything can become annoying.

For example:

```dart
final apiClient = ApiClient();

final authService = AuthService(apiClient);

final userService = UserService(apiClient);

final userRepository = UserRepositoryImpl(
  userService,
);

final authRepository = AuthRepositoryImpl(
  authService,
);
```

You need some place responsible for creating and providing these dependencies.

This is often called a:

> **Dependency Container**

or

> **Service Locator / DI Container**

Conceptually:

```text
              DI Container
             /     |      \
            ↓      ↓       ↓
       ApiClient Auth  Repository
            ↓
        ViewModels
```

---

# 11. Provider-Based Dependency Injection

Since you're learning Flutter, this is particularly important.

Flutter applications commonly use state-management/dependency mechanisms such as **Provider**.

For example:

```dart
Provider(
  create: (_) => UserRepository(),
  child: UserScreen(),
)
```

Then a descendant widget can obtain the dependency.

Conceptually:

```text
Provider
   ↓
UserRepository
   ↓
UserScreen
   ↓
UserViewModel
```

The exact implementation depends on the state-management approach you're using.

The important idea is:

> **The dependency is provided from outside rather than created directly inside the consumer.**

---

# 12. DI + ViewModel

Let's connect this to our previous topic.

Suppose:

```dart
class UserViewModel {
  final UserRepository repository;

  UserViewModel(this.repository);
}
```

We can provide it:

```dart
ChangeNotifierProvider(
  create: (_) => UserViewModel(
    UserRepository(),
  ),
  child: UserScreen(),
)
```

Now:

```text
UserScreen
    ↓
gets
    ↓
UserViewModel
    ↓
has
    ↓
UserRepository
```

The UI doesn't need to construct everything itself.

---

# 13. DI Makes Testing Easier

This is one of the biggest reasons professionals use DI.

Suppose your ViewModel depends on:

```dart
abstract class UserRepository {
  Future<List<User>> getUsers();
}
```

For production:

```dart
final viewModel = UserViewModel(
  RealUserRepository(),
);
```

For testing:

```dart
final viewModel = UserViewModel(
  FakeUserRepository(),
);
```

Same ViewModel.

Different dependency.

```text
Production
ViewModel → Real Repository → API

Testing
ViewModel → Fake Repository → Fake Data
```

No real API is required.

---

# 14. DI Makes Dependencies Replaceable

Imagine your application currently uses:

```text
REST API
```

Later you switch to:

```text
GraphQL
```

If your ViewModel depends on an abstraction:

```dart
abstract class UserRepository {
  Future<List<User>> getUsers();
}
```

you can change the implementation:

```text
Old:
UserRepository
     ↓
REST implementation

New:
UserRepository
     ↓
GraphQL implementation
```

The ViewModel doesn't need to care.

---

# 15. DI vs Dependency Inversion

These are related but **not the same thing**.

### Dependency Inversion Principle

A **design principle**:

> High-level modules should depend on abstractions rather than concrete implementations.

### Dependency Injection

A **technique** for providing dependencies from outside.

Think:

```text
DIP
→ Design principle

DI
→ Practical technique
```

You can use DI to help implement the Dependency Inversion Principle.

---

# 16. A Full Example

Let's create a small architecture.

### Repository abstraction

```dart
abstract class UserRepository {
  Future<List<User>> getUsers();
}
```

### Repository implementation

```dart
class UserRepositoryImpl implements UserRepository {
  final UserApiService apiService;

  UserRepositoryImpl(this.apiService);

  @override
  Future<List<User>> getUsers() {
    return apiService.getUsers();
  }
}
```

### ViewModel

```dart
class UserViewModel extends ChangeNotifier {
  final UserRepository repository;

  UserViewModel(this.repository);

  Future<void> loadUsers() async {
    final users = await repository.getUsers();

    // Update state
    notifyListeners();
  }
}
```

### Construct dependencies

```dart
void main() {
  final apiClient = ApiClient();

  final apiService = UserApiService(
    apiClient,
  );

  final repository = UserRepositoryImpl(
    apiService,
  );

  final viewModel = UserViewModel(
    repository,
  );
}
```

The dependency chain is:

```text
ApiClient
    ↓
UserApiService
    ↓
UserRepository
    ↓
UserViewModel
```

---

# 17. The Dependency Direction

This is worth remembering.

Bad design:

```text
ViewModel
    ↓
creates
Repository
    ↓
creates
Service
    ↓
creates
ApiClient
```

Everything creates everything.

Better:

```text
Composition Root / DI
       │
       ├── creates ApiClient
       ├── creates Service
       ├── creates Repository
       └── creates ViewModel
```

Then:

```text
ViewModel ← Repository ← Service ← ApiClient
```

The dependencies are supplied from outside.

---

# 18. Don't Overuse DI

Dependency Injection is useful, but you don't need to inject **every tiny object**.

For example, injecting:

```dart
final String name;
```

into ten different layers just because "DI is good" can make code unnecessarily complicated.

Use DI when a dependency:

* Has meaningful behavior
* May have multiple implementations
* Needs to be replaced in tests
* Represents an external resource
* Has a lifecycle worth managing

Examples:

```text
Repository
API Client
Database
Authentication Service
Payment Service
```

are good DI candidates.

---

# 19. Professional Mental Model

When you create a class, ask:

> **"What does this class need?"**

For example:

```dart
class ProductViewModel {
  final ProductRepository repository;
}
```

Answer:

```text
ProductViewModel needs ProductRepository.
```

Then ask:

> **"Who should create it?"**

Usually:

```text
DI / Composition layer
```

And finally:

> **"Can I replace it?"**

If you can easily replace it with:

```text
FakeRepository
MockRepository
DifferentRepository
```

your architecture is generally more testable and flexible.

---

# ⭐ Final Mental Model

Remember this:

```text
Dependency
    ↓
Something a class needs

Injection
    ↓
Give that dependency from outside

Constructor Injection
    ↓
Pass it through constructor

Dependency Inversion
    ↓
Depend on abstractions, not concrete implementations

DI Container / Provider
    ↓
Manage and provide dependencies
```

And the most important example:

```text
              DI
               │
               ↓
         UserViewModel
               ↓
       UserRepository
               ↓
        UserApiService
               ↓
           ApiClient
```

> **DI doesn't make your application magically better. It makes dependencies explicit, replaceable, and easier to test.**

