# Phase 6 — Architecture

## 11. Testability

The final topic of Phase 6 is **Testability**.

The main idea is:

> **Good architecture makes your code easier to test by keeping responsibilities separate and dependencies replaceable.**

Remember the architecture we've built:

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

Because these parts are separated, we can test them independently.

---

# 1. What is Testability?

**Testability** means how easily you can verify that a piece of software works correctly.

For example, suppose you have:

```dart
int add(int a, int b) {
  return a + b;
}
```

You can easily test:

```text
add(2, 3) → 5
```

That's highly testable.

But imagine a function that simultaneously:

```text
UI
 ↓
API
 ↓
Database
 ↓
Authentication
 ↓
Business logic
 ↓
Navigation
```

Testing it becomes much harder.

---

# 2. Why Architecture Affects Testing

Consider this:

```dart
class LoginScreen {
  Future<void> login() async {
    // API request
    // database
    // authentication
    // business logic
    // UI changes
  }
}
```

How would you test this?

You might need:

```text
Real API
Database
Authentication
Flutter UI
Network
```

That's complicated.

Now separate the responsibilities:

```text
LoginScreen
     ↓
LoginViewModel
     ↓
AuthRepository
     ↓
AuthService
```

You can test each part independently.

---

# 3. Three Important Types of Flutter Tests

At a high level, you'll commonly encounter:

```text
Unit Tests
Widget Tests
Integration Tests
```

They test different levels of your application.

---

# 4. Unit Tests

A **unit test** tests a small piece of logic independently.

For example:

```dart
int calculateTotal(int price, int quantity) {
  return price * quantity;
}
```

You can test:

```text
calculateTotal(100, 3)
       ↓
      300
```

Unit tests are usually:

* Fast
* Focused
* Easy to run
* Independent

---

# 5. Testing a ViewModel

Suppose:

```dart
class UserViewModel {
  final UserRepository repository;

  UserViewModel(this.repository);

  Future<List<User>> loadUsers() {
    return repository.getUsers();
  }
}
```

We don't want the test to call the real API.

So we create a fake repository:

```dart
class FakeUserRepository implements UserRepository {
  @override
  Future<List<User>> getUsers() async {
    return [
      User(name: "Nayeem"),
      User(name: "Rahim"),
    ];
  }
}
```

Then:

```dart
final repository = FakeUserRepository();

final viewModel = UserViewModel(repository);

final users = await viewModel.loadUsers();
```

Now we're testing the ViewModel without:

```text
❌ Internet
❌ Real API
❌ Real database
```

That's where **Dependency Injection** becomes extremely valuable.

---

# 6. Widget Tests

A **widget test** tests Flutter UI components.

For example:

```dart
testWidgets('shows login button', (tester) async {
  await tester.pumpWidget(
    const LoginScreen(),
  );

  expect(
    find.text('Login'),
    findsOneWidget,
  );
});
```

You're testing the widget's behavior/rendering.

For example:

```text
Does the button exist?
Does text appear?
Does loading indicator appear?
Does tapping a button trigger the expected behavior?
```

---

# 7. Integration Tests

Integration tests test a larger part of the application working together.

For example:

```text
Open App
   ↓
Login
   ↓
Fetch Profile
   ↓
Open Dashboard
   ↓
Logout
```

You're testing a complete user flow.

Integration tests are usually:

* Slower
* More expensive to run
* More realistic
* Useful for critical workflows

---

# 8. Testing the Repository

Suppose:

```dart
abstract class UserRepository {
  Future<List<User>> getUsers();
}
```

You could test the repository separately.

For example, if your repository uses:

```text
Remote Data Source
Local Data Source
```

you can verify things like:

```text
API succeeds
      ↓
returns remote data

API fails
      ↓
returns cached/local data
```

So the repository's behavior can be tested without involving the UI.

---

# 9. Testing Services

Suppose you have:

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

You can provide a fake `ApiClient`.

```text
AuthService
     ↓
Fake ApiClient
```

Then you can verify:

```text
Was the correct endpoint used?
Was the correct request sent?
Was the response handled correctly?
```

Again, no real server is necessary.

---

# 10. Mock vs Fake

You'll encounter these terms frequently.

### Fake

A simple working replacement.

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

It provides predictable data.

### Mock

A test double primarily used to verify interactions.

For example:

```text
Was getUsers() called?
How many times?
With what arguments?
```

Both are forms of **test doubles**.

You don't need to memorize every testing technique yet. The important concept is:

> **Replace real dependencies with controlled test versions.**

---

# 11. Why Dependency Injection Helps

Remember:

```dart
class UserViewModel {
  final UserRepository repository;

  UserViewModel(this.repository);
}
```

This makes testing easy.

Production:

```text
UserViewModel
      ↓
RealUserRepository
      ↓
API
```

Test:

```text
UserViewModel
      ↓
FakeUserRepository
      ↓
Fake Data
```

The ViewModel itself doesn't change.

That's excellent testability.

---

# 12. Bad Architecture vs Testable Architecture

### ❌ Hard to test

```text
UserScreen
 ├── Creates API client
 ├── Calls API
 ├── Parses JSON
 ├── Queries database
 ├── Business logic
 └── Updates UI
```

Everything is connected.

### ✅ Easier to test

```text
UI
 ↓
ViewModel
 ↓
Repository
 ↓
Data Source
```

Each component can be tested independently.

---

# 13. Testing Business Logic

Suppose you have a discount rule:

```dart
double calculateDiscount(double price) {
  if (price >= 1000) {
    return price * 0.10;
  }

  return 0;
}
```

You can test:

```text
price = 500
→ discount = 0

price = 1000
→ discount = 100

price = 2000
→ discount = 200
```

No Flutter UI.

No API.

No database.

Just business logic.

This is exactly why separating business logic from UI is useful.

---

# 14. Testing State

Suppose a ViewModel has:

```text
Loading
Success
Error
```

You can test the state transitions:

```text
Initial
  ↓
Loading
  ↓
Success
```

And:

```text
Initial
  ↓
Loading
  ↓
Error
```

For example:

```text
loadUsers()
     ↓
isLoading = true
     ↓
repository.getUsers()
     ↓
Success
     ↓
isLoading = false
users = [...]
```

This verifies that your state management behaves correctly.

---

# 15. Testability and Separation of Concerns

These two concepts are strongly connected.

If you have:

```text
UI
 ↓
ViewModel
 ↓
Repository
 ↓
Service
```

each layer can be tested independently.

For example:

```text
UI
→ Widget test

ViewModel
→ Unit test

Repository
→ Unit test

Service
→ Unit test

Complete application
→ Integration test
```

This is one of the major reasons we separate responsibilities.

---

# 16. Don't Make Everything Testable at Any Cost

There's another important architectural lesson:

> **Don't sacrifice simplicity just to make every tiny thing mockable.**

For example, creating an interface for a trivial class that has no meaningful alternative may add unnecessary complexity.

Good architecture balances:

```text
Testability
+
Simplicity
+
Maintainability
```

The goal isn't:

```text
"Everything must have an interface."
```

The goal is:

```text
"Important behavior should be easy to verify."
```

---

# 17. Testing Pyramid

A useful mental model is the **testing pyramid**:

```text
             /\
            /  \
           /    \
          /      \
         /Integration\
        /--------------\
       /   Widget Tests \
      /------------------\
     /     Unit Tests     \
    /______________________\
```

Generally:

```text
Many unit tests
       ↓
Some widget tests
       ↓
Fewer integration tests
```

Why?

Because unit tests are generally faster and more focused, while integration tests cover more but cost more to run and maintain.

---

# 18. Example: E-commerce App

Suppose you have:

```text
ProductViewModel
ProductRepository
ProductApiService
```

You can test each separately.

### ViewModel test

```text
Given repository returns products
       ↓
ViewModel should expose products
```

### Repository test

```text
Given API succeeds
       ↓
Return products
```

### Repository fallback test

```text
Given API fails
       ↓
Return cached products
```

### Widget test

```text
Given products exist
       ↓
Product names appear on screen
```

### Integration test

```text
Open app
 ↓
Login
 ↓
Open products
 ↓
Add product to cart
 ↓
Checkout
```

Each test level serves a different purpose.

---

# 19. The Architecture → Testability Connection

This is the big picture of Phase 6:

```text
Separation of Concerns
          ↓
Clear responsibilities
          ↓
Dependency Injection
          ↓
Replaceable dependencies
          ↓
Independent components
          ↓
Easier testing
```

So these topics aren't isolated.

They're connected.

---

# ⭐ Final Mental Model

Remember the purpose of each testing level:

| Test                 | Main purpose                       |
| -------------------- | ---------------------------------- |
| **Unit Test**        | Test individual logic/components   |
| **Widget Test**      | Test Flutter UI/widget behavior    |
| **Integration Test** | Test larger real application flows |

And remember:

```text
Good Architecture
       ↓
Less Coupling
       ↓
Easier Dependencies Replacement
       ↓
Easier Testing
```

### The most important idea:

> **Testability is not just about writing tests. It's about designing your application so that important parts can be tested independently.**

With that, **Phase 6 — Architecture is complete.**
