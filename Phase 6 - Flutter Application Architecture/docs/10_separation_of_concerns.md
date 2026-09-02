# Phase 6 — Architecture

## 10. Separation of Concerns

This is one of the **most important architectural principles** to understand.

> **Separation of Concerns (SoC) means dividing an application into different parts where each part has one clear responsibility.**

In simple words:

> **Don't make one class or layer responsible for everything.**

---

# 1. The Problem: Everything in the UI

A beginner might build a screen like this:

```text
UserScreen
 ├── UI
 ├── API calls
 ├── JSON parsing
 ├── Database queries
 ├── Business logic
 ├── Authentication
 ├── Validation
 ├── Caching
 └── Navigation
```

For example:

```dart
class UserScreen extends StatelessWidget {
  Future<void> loadUsers() async {
    // HTTP request
    // JSON parsing
    // Database
    // Business logic
    // Authentication
    // etc.
  }

  @override
  Widget build(BuildContext context) {
    // UI
  }
}
```

It might work initially.

But as the application grows, it becomes difficult to maintain.

---

# 2. Why Is This a Problem?

Imagine your `UserScreen` contains:

```text
500+ lines
```

and suddenly the API changes.

You need to search through the UI code to find:

```text
HTTP request
JSON parsing
model conversion
state updates
error handling
```

Then you modify the screen.

Later, the database changes.

Again, modify the screen.

Then authentication changes.

Again, modify the screen.

The screen becomes a **God class**.

---

# 3. The Better Approach

Separate responsibilities:

```text
UI
 ↓
ViewModel
 ↓
Repository
 ↓
Data Source
 ↓
API / Database
```

Each part has a job.

### UI

```text
Display information
Receive user interactions
```

### ViewModel

```text
Manage UI state
Handle UI events
```

### Repository

```text
Provide application data
Coordinate data sources
```

### Data Source

```text
Communicate with API/database
```

Now each component has a clear responsibility.

---

# 4. Think of a Restaurant

Imagine a restaurant.

You wouldn't ask the waiter to:

```text
Take order
Cook food
Wash dishes
Manage inventory
Handle payments
Clean tables
```

Instead:

```text
Waiter
 ↓
Takes order

Chef
 ↓
Cooks food

Cashier
 ↓
Handles payment

Inventory Manager
 ↓
Manages ingredients
```

Each person has a responsibility.

Software architecture works similarly.

```text
UI
→ Displays

ViewModel
→ Manages state

Repository
→ Manages data access

Service
→ Communicates with external systems
```

---

# 5. Separation of Concerns in Flutter

Suppose we have:

```text
Login Screen
```

A poor implementation might look like:

```dart
class LoginScreen extends StatelessWidget {
  Future<void> login() async {
    // validate
    // HTTP request
    // JSON parsing
    // save token
    // update state
    // navigate
  }

  @override
  Widget build(BuildContext context) {
    // UI
  }
}
```

The screen is doing too much.

Instead:

```text
LoginScreen
     ↓
LoginViewModel
     ↓
AuthRepository
     ↓
AuthService
     ↓
API
```

Now:

### LoginScreen

```text
UI
```

### LoginViewModel

```text
State + events
```

### AuthRepository

```text
Application data access
```

### AuthService

```text
Authentication communication
```

---

# 6. UI Responsibility

The UI should primarily be concerned with:

```text
What should be displayed?
What user interaction occurred?
```

For example:

```dart
ElevatedButton(
  onPressed: () {
    viewModel.login();
  },
  child: const Text("Login"),
)
```

The UI says:

> "The user clicked Login."

It doesn't need to know how authentication works.

---

# 7. ViewModel Responsibility

The ViewModel handles the UI-facing behavior.

For example:

```dart
class LoginViewModel extends ChangeNotifier {
  final AuthRepository repository;

  LoginViewModel(this.repository);

  bool isLoading = false;
  String? error;

  Future<void> login(
    String email,
    String password,
  ) async {
    isLoading = true;
    notifyListeners();

    try {
      await repository.login(email, password);
    } catch (e) {
      error = "Login failed";
    }

    isLoading = false;
    notifyListeners();
  }
}
```

The ViewModel doesn't need to know:

```text
HTTP headers
API URLs
JSON parsing
Database queries
```

That's not its concern.

---

# 8. Repository Responsibility

The Repository provides application-level data operations:

```dart
abstract class AuthRepository {
  Future<void> login(
    String email,
    String password,
  );
}
```

Implementation:

```dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthService service;

  AuthRepositoryImpl(this.service);

  @override
  Future<void> login(
    String email,
    String password,
  ) {
    return service.login(email, password);
  }
}
```

The ViewModel doesn't need to know how authentication is implemented.

---

# 9. Service Responsibility

The service communicates with the external system:

```dart
class AuthService {
  final ApiClient client;

  AuthService(this.client);

  Future<void> login(
    String email,
    String password,
  ) async {
    await client.post(
      "/login",
      {
        "email": email,
        "password": password,
      },
    );
  }
}
```

Now HTTP details are isolated.

---

# 10. Data Source Responsibility

A data source is responsible for actually obtaining/storing data.

For example:

```dart
class UserRemoteDataSource {
  final ApiClient client;

  UserRemoteDataSource(this.client);

  Future<List<User>> getUsers() async {
    final response = await client.get("/users");

    // Convert response
    return [];
  }
}
```

The data source doesn't manage UI state.

It doesn't navigate screens.

It doesn't display error messages.

It just deals with the data source.

---

# 11. Separation of Concerns in One Diagram

A clean architecture might look like:

```text
                    UI
                     │
                     │ User Event
                     ↓
                 ViewModel
                     │
                     │
                     ↓
                Use Case
                     │
                     ↓
                Repository
                     │
              ┌──────┴──────┐
              ↓             ↓
        Remote Source    Local Source
              ↓             ↓
             API         Database
```

Each layer has a **different concern**.

---

# 12. What Does "Concern" Mean?

A **concern** is simply a responsibility or area of functionality.

For example:

```text
UI rendering       → one concern
Authentication      → one concern
Networking          → one concern
Database access     → one concern
Business rules      → one concern
State management    → one concern
```

Separation of Concerns means:

> Don't mix unrelated concerns together unnecessarily.

---

# 13. A Bad Example

Imagine this:

```dart
class ProductScreen extends StatelessWidget {
  Future<void> buyProduct() async {
    // Validate product
    if (...) {}

    // API request
    final response = await http.post(...);

    // Parse JSON
    final data = jsonDecode(response.body);

    // Save to database
    await database.insert(...);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(...);

    // Navigate
    Navigator.push(...);
  }
}
```

Look at how many responsibilities this class has:

```text
❌ Validation
❌ Networking
❌ JSON parsing
❌ Database
❌ UI state
❌ Notifications
❌ Navigation
```

That's poor separation.

---

# 14. Better Design

Break it apart:

```text
ProductScreen
      ↓
ProductViewModel
      ↓
BuyProductUseCase
      ↓
ProductRepository
      ↓
ProductService
      ↓
API
```

Now:

### ProductScreen

Displays UI.

### ProductViewModel

Manages state.

### BuyProductUseCase

Contains the business operation.

### ProductRepository

Handles application data access.

### ProductService

Communicates with external API.

Much easier to reason about.

---

# 15. Separation of Concerns ≠ Creating Hundreds of Classes

This is extremely important.

Some developers misunderstand architecture and create:

```text
UserNameValidator
UserEmailValidator
UserPasswordValidator
UserApiService
UserRepository
UserRepositoryImpl
UserUseCase
UserUseCaseImpl
UserMapper
UserFormatter
UserManager
UserHelper
UserProvider
...
```

for a simple screen.

That's **over-engineering**.

Separation of concerns means:

> **Separate meaningful responsibilities.**

It does NOT mean:

> **Create a separate class for every function.**

---

# 16. A Simple App

For a small Todo app, this may be enough:

```text
TodoScreen
    ↓
TodoViewModel
    ↓
TodoRepository
    ↓
Local Database
```

You might not need:

```text
UseCase
Service
RemoteDataSource
Multiple repositories
```

if the application doesn't need them.

---

# 17. A Large App

For a large application:

```text
UI
 ↓
ViewModel
 ↓
Use Cases
 ↓
Repositories
 ↓
Services / Data Sources
 ↓
API / Database / External Systems
```

Now separation becomes much more valuable.

---

# 18. Benefits of Separation of Concerns

### 1. Easier maintenance

If the API changes:

```text
Change API-related code
```

rather than changing every screen.

---

### 2. Easier testing

You can test:

```text
ViewModel
Repository
Use Case
Service
```

independently.

---

### 3. Easier teamwork

One developer can work on:

```text
UI
```

while another works on:

```text
Repository/API
```

without constantly modifying the same code.

---

### 4. Easier replacement

You can replace:

```text
REST API
```

with:

```text
GraphQL
```

without rewriting the entire UI.

---

### 5. Better readability

When you open a class, you can understand:

> "This class is responsible for X."

instead of:

> "This class does everything."

---

# 19. The Golden Rule

When writing a class, ask:

> **"What is this class responsible for?"**

If the answer is:

```text
"Almost everything."
```

you probably have a separation-of-concerns problem.

A healthier answer is:

```text
"This class manages user UI state."

"This class handles product data."

"This service communicates with the payment provider."

"This repository coordinates product data."
```

Clear responsibility = easier architecture.

---

# ⭐ Final Mental Model

Remember:

```text
UI
→ What should the user see?

ViewModel
→ What state should the UI have?

Use Case
→ What business operation should happen?

Repository
→ How should the application access data?

Service
→ How do we communicate with an external system?

Data Source
→ Where/how is data actually stored or retrieved?
```

That's **Separation of Concerns**.

> **Good architecture doesn't mean having more layers. It means having clear responsibilities and keeping unrelated responsibilities from becoming unnecessarily tangled.**
