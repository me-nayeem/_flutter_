# Phase 6 — Architecture

## 7. Services

Now let's understand **Services**.

You already learned that a Repository is mainly concerned with **providing application data**.

A Service is slightly different.

> **A Service usually encapsulates communication with an external system, platform, or specialized infrastructure.**

The roadmap identifies four important types:

* **API services**
* **Authentication services**
* **Platform services**
* **External integrations**

---

# 1. What is a Service?

Suppose your application needs to communicate with an external system.

Instead of putting that communication everywhere:

```text
UI → HTTP
ViewModel → HTTP
Repository → HTTP
```

you can create a dedicated service:

```text
API Service
```

For example:

```dart
class UserApiService {
  Future<dynamic> getUsers() async {
    // API communication
  }
}
```

Now the code that knows **how to communicate with the API** is centralized.

---

# 2. Why do we need Services?

Without services, external communication can become scattered:

```text
LoginScreen
 ├── API request

ProfileScreen
 ├── API request

SettingsScreen
 ├── API request

PaymentScreen
 ├── Payment API
```

This makes the application harder to maintain.

Instead:

```text
LoginViewModel
       ↓
AuthService

ProfileRepository
       ↓
UserApiService

PaymentRepository
       ↓
PaymentService
```

Each service handles a particular external capability.

---

# 3. API Services

An **API Service** communicates with a backend/API.

For example:

```dart
class UserApiService {
  Future<List<User>> getUsers() async {
    // GET /users
  }

  Future<User> getUser(String id) async {
    // GET /users/:id
  }

  Future<User> createUser(User user) async {
    // POST /users
  }
}
```

The service knows things such as:

```text
Endpoints
HTTP methods
Request headers
Request body
API responses
```

For example:

```text
UserApiService
      ↓
GET /users
      ↓
Backend
```

---

# 4. API Client vs API Service

This is an important distinction.

You may have:

```text
API Client
    ↓
HTTP communication
```

and:

```text
API Service
    ↓
Application-specific API operations
```

For example:

```dart
class ApiClient {
  Future<dynamic> get(String endpoint) async {
    // Generic HTTP GET
  }

  Future<dynamic> post(
    String endpoint,
    dynamic body,
  ) async {
    // Generic HTTP POST
  }
}
```

Then:

```dart
class UserApiService {
  final ApiClient client;

  UserApiService(this.client);

  Future<dynamic> getUsers() {
    return client.get("/users");
  }
}
```

So:

```text
UserApiService
      ↓
  "Get users"
      ↓
   ApiClient
      ↓
  "Make HTTP request"
```

### Easy distinction

**API Client:**

> "How do I make an HTTP request?"

**API Service:**

> "Which API operation does my application need?"

---

# 5. Authentication Services

Authentication is another common service.

For example:

```dart
class AuthService {
  Future<void> login(
    String email,
    String password,
  ) async {
    // Authentication
  }

  Future<void> logout() async {
    // Logout
  }

  Future<void> refreshToken() async {
    // Refresh authentication
  }
}
```

It may communicate with:

```text
Login API
Token API
Refresh-token API
Logout API
```

The ViewModel doesn't need to know the low-level authentication details.

```text
LoginScreen
      ↓
LoginViewModel
      ↓
AuthService
      ↓
Authentication API
```

---

# 6. Platform Services

Not every service communicates with a server.

Some communicate with the **device/platform**.

Examples:

```text
Location
Camera
Notifications
Storage
Bluetooth
Device information
```

For example:

```dart
class LocationService {
  Future<Location> getCurrentLocation() async {
    // Access device location
  }
}
```

Your application can then use:

```dart
final location = await locationService.getCurrentLocation();
```

instead of putting platform-specific code throughout the UI.

---

# 7. External Integrations

Sometimes your application needs to communicate with another company's system.

For example:

```text
Payment Provider
Maps Provider
Analytics Platform
Cloud Storage
Social Login
```

You could isolate that integration:

```dart
class PaymentService {
  Future<void> processPayment(double amount) async {
    // Communicate with payment provider
  }
}
```

Then the rest of the application doesn't need to know the provider's internal API.

---

# 8. Service + Repository

This is where beginners often get confused.

Suppose you're building a shopping app.

You might have:

```text
ProductRepository
       ↓
ProductApiService
       ↓
ApiClient
       ↓
Backend
```

The responsibilities are different.

### Repository

> "How does my application get product data?"

### API Service

> "How do I interact with the product API?"

### API Client

> "How do I perform HTTP communication?"

So:

```text
Repository
    ↓
API Service
    ↓
API Client
    ↓
Server
```

---

# 9. Example

### API Client

```dart
class ApiClient {
  Future<dynamic> get(String endpoint) async {
    // HTTP request
  }
}
```

### API Service

```dart
class ProductApiService {
  final ApiClient apiClient;

  ProductApiService(this.apiClient);

  Future<dynamic> getProducts() {
    return apiClient.get("/products");
  }
}
```

### Repository

```dart
class ProductRepository {
  final ProductApiService apiService;

  ProductRepository(this.apiService);

  Future<List<Product>> getProducts() async {
    final data = await apiService.getProducts();

    // Convert API data into application models

    return [];
  }
}
```

### ViewModel

```dart
class ProductViewModel {
  final ProductRepository repository;

  ProductViewModel(this.repository);

  Future<void> loadProducts() async {
    final products = await repository.getProducts();

    // Update UI state
  }
}
```

Now the entire flow is:

```text
UI
 ↓
ViewModel
 ↓
Repository
 ↓
API Service
 ↓
API Client
 ↓
Server
```

---

# 10. Why not let the Repository call HTTP directly?

You **can**, especially in a small application.

For example:

```dart
class ProductRepository {
  Future<List<Product>> getProducts() async {
    // HTTP request
  }
}
```

That's not automatically wrong.

But when your application becomes larger, separating the responsibilities can help:

```text
Repository
→ Application data access

API Service
→ Specific external API

API Client
→ Generic HTTP communication
```

The important thing is not to create layers mechanically.

---

# 11. Service Should Not Contain UI Logic

A service shouldn't do things like:

```dart
class AuthService {
  void showLoginDialog(BuildContext context) {
    // ❌ UI responsibility
  }
}
```

Instead:

```dart
class AuthService {
  Future<void> login(...) async {
    // Authentication responsibility
  }
}
```

The UI decides how to display the result.

---

# 12. Service Should Focus on One External Capability

A good service usually has a focused responsibility.

Good:

```text
AuthService
PaymentService
LocationService
NotificationService
```

Less ideal:

```text
AppService
 ├── Authentication
 ├── Payment
 ├── Location
 ├── Notifications
 ├── Database
 └── Everything else
```

The second one can become a **God class**.

---

# 13. Complete Example

Imagine a delivery application.

The user wants to see their current location.

```text
UI
 ↓
DeliveryViewModel
 ↓
LocationService
 ↓
Device GPS
```

The user wants to see their orders:

```text
UI
 ↓
DeliveryViewModel
 ↓
OrderRepository
 ↓
OrderApiService
 ↓
ApiClient
 ↓
Server
```

The user wants to pay:

```text
UI
 ↓
PaymentViewModel
 ↓
PaymentRepository
 ↓
PaymentService
 ↓
Payment Provider
```

Different responsibilities, different paths.

---

# 14. Services and Dependency Injection

Later, you'll learn **Dependency Injection**.

Instead of creating a service inside a ViewModel:

```dart
class LoginViewModel {
  final AuthService authService = AuthService();
}
```

you can provide it from outside:

```dart
class LoginViewModel {
  final AuthService authService;

  LoginViewModel(this.authService);
}
```

Now:

```text
AuthService
     ↓
LoginViewModel
```

This makes the code easier to:

* Replace
* Test
* Maintain
* Configure

And this will become particularly important in **Topic 8 — Dependency Injection**.

---

# 15. The Complete Picture So Far

We've now covered Topics 3–7.

The architecture is starting to look like:

```text
                    UI
                     ↓
                ViewModel
                     ↓
                Use Case
                     ↓
                Repository
                     ↓
              ┌──────┴──────┐
              ↓             ↓
          API Service    Local Source
              ↓
          API Client
              ↓
            Server
```

And services can also interact with:

```text
Device
External APIs
Payment providers
Authentication systems
Other platforms
```

---

# ⭐ Remember This

### Repository

**Provides application data.**

```text
"What data does my application need?"
```

### Service

**Communicates with an external system/platform.**

```text
"How do I communicate with this external system?"
```

### API Client

**Handles generic API/HTTP communication.**

```text
"How do I make this HTTP request?"
```

So the mental model is:

> **Repository = data access boundary**
> **Service = external/platform communication**
> **API Client = low-level API communication**

And don't forget: these boundaries are **architectural tools, not mandatory ceremonies**. For a small Flutter app, combining some of these responsibilities can be perfectly reasonable.
