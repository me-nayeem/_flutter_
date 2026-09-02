# Phase 6 — Architecture

## 6. Repositories

Now let's go deeper into **Repositories**.

You already saw the basic idea:

```text
UI
 ↓
ViewModel
 ↓
Repository
 ↓
Data Sources
```

Now we need to understand **why repositories exist, what they should own, and how they handle remote data, local data, and caching.**

---

# 1. What is a Repository?

A **Repository is an abstraction that provides data to the application without exposing the details of where or how that data is obtained.**

For example, the ViewModel might say:

```dart
final users = await userRepository.getUsers();
```

It doesn't need to know whether the users came from:

```text
API
Database
Cache
Firebase
File
```

The Repository hides those details.

Think of it as a **single doorway to your application's data**.

```text
                 ViewModel
                     ↓
                Repository
                     ↓
        ┌────────────┼────────────┐
        ↓            ↓            ↓
       API         Cache       Database
```

---

# 2. Repository Responsibilities

A repository commonly handles things like:

### 1. Providing data

```dart
Future<List<User>> getUsers()
```

### 2. Saving data

```dart
Future<void> saveUser(User user)
```

### 3. Choosing the data source

```text
Should I use API?
Should I use local database?
Should I use cache?
```

### 4. Combining multiple data sources

For example:

```text
API + Database + Cache
```

### 5. Hiding data-access complexity

The ViewModel shouldn't have to know the implementation details.

---

# 3. Repository Abstraction

This is one of the most important ideas.

Instead of tightly coupling your ViewModel to a specific implementation:

```dart
class UserViewModel {
  final UserRepository repository;

  UserViewModel(this.repository);
}
```

You can define a contract:

```dart
abstract class UserRepository {
  Future<List<User>> getUsers();
}
```

Then create an implementation:

```dart
class UserRepositoryImpl implements UserRepository {
  @override
  Future<List<User>> getUsers() async {
    // actual implementation
  }
}
```

Now the ViewModel depends on:

```text
UserRepository
```

rather than:

```text
UserRepositoryImpl
```

This is **abstraction** and connects directly to the **Dependency Inversion Principle** you learned earlier.

---

# 4. Why is this useful?

Imagine today you use an API:

```text
UserRepository
      ↓
REST API
```

Later you decide to change the backend:

```text
UserRepository
      ↓
Firebase
```

The ViewModel can remain unchanged:

```dart
final users = await repository.getUsers();
```

The implementation underneath can change.

That's the power of abstraction.

---

# 5. Repository + Remote Data Source

A common structure is:

```text
UserViewModel
      ↓
UserRepository
      ↓
UserRemoteDataSource
      ↓
ApiClient
      ↓
Server
```

Example:

```dart
abstract class UserRepository {
  Future<List<User>> getUsers();
}
```

Implementation:

```dart
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<User>> getUsers() {
    return remoteDataSource.getUsers();
  }
}
```

The repository doesn't need to implement HTTP itself.

It delegates the actual remote access to the data source.

---

# 6. Repository + Local Data Source

Now suppose you also have local storage.

```text
                 Repository
                /           \
               ↓             ↓
           Remote          Local
           Source          Source
               ↓             ↓
              API         Database
```

Example:

```dart
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;
  final UserLocalDataSource local;

  UserRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<List<User>> getUsers() async {
    try {
      final users = await remote.getUsers();

      await local.saveUsers(users);

      return users;
    } catch (e) {
      return local.getUsers();
    }
  }
}
```

Now the repository provides an **offline fallback**.

---

# 7. Caching

Caching is another important repository responsibility.

Suppose the user opens:

```text
Products Screen
```

The app could request the API every time:

```text
Screen opens
     ↓
API request
     ↓
Server
```

This may be unnecessary.

Instead:

```text
Screen opens
     ↓
Repository
     ↓
Is cached data available?
      ↙        ↘
    Yes         No
     ↓           ↓
   Cache        API
                 ↓
               Cache
```

This can improve:

* Performance
* Network usage
* Offline experience
* User experience

---

# 8. Simple Cache Example

Imagine:

```dart
class ProductRepository {
  List<Product>? _cache;

  Future<List<Product>> getProducts() async {
    if (_cache != null) {
      return _cache!;
    }

    final products = await fetchFromApi();

    _cache = products;

    return products;
  }
}
```

First request:

```text
getProducts()
    ↓
Cache empty
    ↓
API
    ↓
Save to cache
    ↓
Return products
```

Second request:

```text
getProducts()
    ↓
Cache available
    ↓
Return cache
```

No API request is needed.

This is a very simple form of caching.

---

# 9. Local Cache vs Memory Cache

There are different types of caching.

### Memory cache

Stored in RAM while the application is running:

```dart
List<Product>? _cache;
```

Fast, but disappears when the app is terminated.

### Persistent cache

Stored locally:

```text
SQLite
Hive
Isar
etc.
```

It can survive app restarts.

So:

```text
Memory Cache
    ↓
Fast
    ↓
Temporary
```

while:

```text
Persistent Cache
    ↓
Local storage
    ↓
Survives restart
```

---

# 10. Repository and Data Ownership

This is another important concept.

Ask:

> **Who is responsible for deciding where the application's data comes from?**

Usually, the Repository is a good place for that decision.

For example:

```text
Repository
     │
     ├── Fresh API data available?
     │        ↓
     │       Use API
     │
     └── API unavailable?
              ↓
          Use local data
```

The ViewModel shouldn't need to write:

```dart
if (internetAvailable) {
  // API
} else {
  // database
}
```

That is data-access logic.

The repository can hide it.

---

# 11. Repository as a Single Source of Data Access

Consider:

```text
UserViewModel
     ↓
UserRepository
```

The ViewModel can use:

```dart
repository.getUser();
repository.updateUser();
repository.deleteUser();
```

It doesn't need to know:

```text
Where user data lives
How HTTP works
How database queries work
How caching works
How authentication headers work
```

That gives you a clean boundary.

---

# 12. What a Repository Should NOT Do

A repository shouldn't become a **"God class"**.

Avoid:

```text
UserRepository
 ├── API requests
 ├── UI logic
 ├── navigation
 ├── widget creation
 ├── authentication UI
 ├── database implementation
 ├── random business logic
 └── everything else
```

For example, don't do:

```dart
class UserRepository {
  void navigateToProfile(BuildContext context) {
    // ❌ UI responsibility
  }
}
```

The repository shouldn't know about Flutter UI.

---

# 13. Repository vs Service

This can be confusing because both may communicate with external systems.

A useful distinction is:

### Service

Usually focuses on **communication with a specific external system**.

```text
AuthService
     ↓
Authentication API
```

```text
PaymentService
     ↓
Payment provider
```

### Repository

Focuses on **providing application data** and deciding how that data is obtained/stored.

```text
UserRepository
      ↓
 ┌────┴────┐
API      Database
```

So:

```text
Service
→ "How do I communicate with this external system?"

Repository
→ "How does my application access this data?"
```

We'll explore Services separately in Topic 7.

---

# 14. Repository Example in a Flutter App

Suppose we're building a product screen.

### UI

```dart
ProductScreen()
```

The UI doesn't fetch anything directly.

```text
ProductScreen
      ↓
ProductViewModel
```

### ViewModel

```dart
class ProductViewModel {
  final ProductRepository repository;

  ProductViewModel(this.repository);

  Future<void> loadProducts() async {
    final products = await repository.getProducts();

    // update UI state
  }
}
```

### Repository

```dart
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;
  final ProductLocalDataSource local;

  ProductRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<List<Product>> getProducts() async {
    try {
      final products = await remote.getProducts();

      await local.saveProducts(products);

      return products;
    } catch (_) {
      return local.getProducts();
    }
  }
}
```

### Data Sources

```text
RemoteDataSource → API
LocalDataSource  → Database
```

Now the responsibilities are nicely separated.

---

# 15. Full Flow

Let's visualize the complete process:

```text
User opens Product Screen
          ↓
     ProductScreen
          ↓
     ProductViewModel
          ↓
     ProductRepository
          ↓
      ┌───┴────┐
      ↓        ↓
   Remote     Local
      ↓        ↓
     API    Database
      ↓
   New Data
      ↓
   Repository
      ↓
   ViewModel
      ↓
   New State
      ↓
      UI
```

Notice something important:

The Repository is **between the ViewModel and the actual data sources**.

---

# 16. When Repository Abstraction Is Valuable

A repository becomes especially useful when you have:

### Multiple data sources

```text
API + Database
```

### Caching

```text
API + Cache
```

### Offline support

```text
API + Local Database
```

### Complex data access

```text
Multiple APIs
Multiple endpoints
Multiple storage systems
```

### Testing

You can replace the real repository with a fake implementation:

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

Now your ViewModel can be tested without making a real API request.

This is one of the biggest benefits of good architecture.

---

# 17. Don't Over-Engineer

Just like with the Domain Layer, don't automatically create repositories for every tiny piece of data.

For a very small app:

```text
UI
 ↓
Repository
 ↓
API
```

may be enough.

For a more complex application:

```text
UI
 ↓
ViewModel
 ↓
Use Case
 ↓
Repository
 ↓
Remote + Local Data Sources
 ↓
API / Database
```

may make more sense.

The correct architecture depends on **complexity and requirements**.

---

# 18. Professional Mental Model

Remember these questions:

### ViewModel asks:

> "What does the UI need?"

### Repository asks:

> "How should the application access this data?"

### Data Source asks:

> "How do I actually retrieve/store this data?"

### API Client asks:

> "How do I communicate over HTTP?"

So:

```text
ViewModel
     ↓
Repository
     ↓
Data Source
     ↓
API / Database
```

---

## ⭐ Final Takeaway

A Repository is the **boundary between application logic and data access**.

Its major responsibilities are:

```text
Repository
│
├── Provide data
├── Save/update data
├── Choose data sources
├── Coordinate remote/local sources
├── Handle caching
└── Hide data-access complexity
```

And the key principle is:

> **The ViewModel should ask the Repository for data; it shouldn't care whether that data came from an API, database, cache, or another source.**
