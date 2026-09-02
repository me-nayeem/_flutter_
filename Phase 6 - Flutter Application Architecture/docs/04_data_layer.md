# Phase 6 — Architecture

## 4. Data Layer

Now we move to the **Data Layer**.

The main goal is to understand:

* **Repositories**
* **Data Sources**
* **Services**
* **API Clients**
* **Local Data Sources**

The most important idea is:

> **The Data Layer is responsible for getting, storing, and providing data to the rest of the application.**

---

# 1. Why do we need a Data Layer?

Imagine your Flutter UI directly calls an API:

```dart
onPressed: () async {
  final response = await http.get(
    Uri.parse("https://api.example.com/users"),
  );

  // parse JSON
  // handle errors
  // ...
};
```

This works for a small app.

But as the application grows, you may have:

```text
UI
 ├── API calls
 ├── JSON parsing
 ├── Database queries
 ├── Cache logic
 ├── Authentication
 └── Error handling
```

This becomes difficult to maintain.

Instead:

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

Now the UI doesn't care where the data comes from.

---

# 2. What is the Data Layer?

Think of the Data Layer as the application's **data-access department**.

For example, suppose your app needs a list of products.

The Data Layer may contain:

```text
Data Layer
│
├── Repository
│
├── Remote Data Source
│      ↓
│     API
│
├── Local Data Source
│      ↓
│    Database
│
├── API Service
│
└── API Client
```

Different components have different responsibilities.

---

# 3. Data Source

A **Data Source** is something that actually interacts with where the data lives.

There are two major types:

```text
Data Sources
     │
     ├── Remote Data Source
     │       ↓
     │      API
     │
     └── Local Data Source
             ↓
          Database / Cache
```

---

## Remote Data Source

A remote data source gets data from an external system.

For example:

```dart
class UserRemoteDataSource {
  Future<List<User>> getUsers() async {
    // API request
  }
}
```

It might internally call:

```text
GET /users
```

The important point is:

> **Remote Data Source = communicates with remote data.**

Examples:

* REST API
* GraphQL API
* Firebase
* Cloud service

---

## Local Data Source

A local data source gets or stores data locally on the device.

For example:

```dart
class UserLocalDataSource {
  Future<void> saveUsers(List<User> users) async {
    // Save to local database
  }

  Future<List<User>> getUsers() async {
    // Read from local database
  }
}
```

Possible storage:

* SQLite
* Hive
* Isar
* SharedPreferences
* secure storage

So:

> **Local Data Source = communicates with local storage.**

---

# 4. Services

A **Service** usually encapsulates communication with an external system or platform.

For example:

```dart
class AuthService {
  Future<String> login(
    String email,
    String password,
  ) async {
    // Communicate with authentication API
  }
}
```

Other examples:

```text
AuthService
PaymentService
NotificationService
LocationService
StorageService
```

The exact organization depends on the application.

For example:

```text
AuthService
    ↓
Authentication API

PaymentService
    ↓
Payment Provider

LocationService
    ↓
Device GPS
```

We'll study Services more deeply in **Topic 7**.

---

# 5. API Client

An **API Client** is responsible for communicating with an HTTP/API server.

For example, you might create:

```dart
class ApiClient {
  Future<dynamic> get(String endpoint) async {
    // HTTP GET request
  }

  Future<dynamic> post(
    String endpoint,
    dynamic body,
  ) async {
    // HTTP POST request
  }
}
```

Then your remote data source can use it:

```dart
class UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSource(this.apiClient);

  Future<dynamic> getUsers() {
    return apiClient.get("/users");
  }
}
```

This gives you:

```text
UserRemoteDataSource
        ↓
     ApiClient
        ↓
       HTTP
        ↓
       Server
```

The remote data source understands **what data it wants**.

The API client understands **how to communicate over HTTP**.

---

# 6. Repository

Now we reach one of the most important concepts.

A **Repository provides an abstraction for accessing application data.**

Suppose the app needs users.

The ViewModel shouldn't have to care whether users come from:

```text
API
Database
Cache
```

It simply asks:

```dart
repository.getUsers();
```

The repository decides where the data should come from.

For example:

```dart
class UserRepository {
  final UserRemoteDataSource remote;
  final UserLocalDataSource local;

  UserRepository({
    required this.remote,
    required this.local,
  });

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

Now we have:

```text
ViewModel
    ↓
UserRepository
    ↓
 ┌───────────────┐
 ↓               ↓
Remote          Local
 ↓               ↓
API            Database
```

This is a powerful separation.

---

# 7. Why is the Repository useful?

Imagine your app initially uses an API:

```text
API → Users
```

Later, you add caching:

```text
API → Cache → Users
```

Then you add offline support:

```text
API
 ↓
Database
 ↓
Users
```

If your UI directly communicates with the API, you may need to change lots of UI code.

But with a repository:

```text
UI
 ↓
ViewModel
 ↓
Repository
 ↓
Data sources
```

The UI can remain unchanged.

The repository hides the details.

---

# 8. Complete Data Flow

Let's put everything together.

Suppose the user opens the **Users screen**.

```text
User opens screen
       ↓
     UI
       ↓
 UserViewModel
       ↓
 UserRepository
       ↓
 RemoteDataSource
       ↓
    ApiClient
       ↓
     Server
```

The response comes back:

```text
Server
  ↓
ApiClient
  ↓
RemoteDataSource
  ↓
Repository
  ↓
ViewModel
  ↓
UI
```

And if caching exists:

```text
                 Repository
                /           \
               ↓             ↓
       Remote Data Source   Local Data Source
               ↓             ↓
           API Server       Database
```

---

# 9. Realistic Flutter Structure

A project could look like:

```text
lib/
│
├── features/
│   └── users/
│       ├── user_screen.dart
│       ├── user_view_model.dart
│       └── user_state.dart
│
├── data/
│   ├── repositories/
│   │   └── user_repository.dart
│   │
│   ├── data_sources/
│   │   ├── user_remote_data_source.dart
│   │   └── user_local_data_source.dart
│   │
│   ├── services/
│   │   └── auth_service.dart
│   │
│   └── api/
│       └── api_client.dart
│
└── core/
```

The exact folder structure isn't mandatory.

What's important is the **responsibility of each component**.

---

# 10. Who should do what?

This is the part you should remember.

| Component              | Responsibility                              |
| ---------------------- | ------------------------------------------- |
| **UI**                 | Display state and capture user actions      |
| **ViewModel**          | Manage UI state and coordinate actions      |
| **Repository**         | Provide application data                    |
| **Remote Data Source** | Get data from remote systems                |
| **Local Data Source**  | Read/write local data                       |
| **API Client**         | Handle HTTP/API communication               |
| **Service**            | Communicate with external/platform services |

Think of it like this:

```text
UI
 │
 │ "I need users."
 ↓
ViewModel
 │
 │ "Repository, give me users."
 ↓
Repository
 │
 │ "I'll decide where to get them."
 ├──────────────┐
 ↓              ↓
Remote         Local
 ↓              ↓
API           Database
```

---

# 11. A Common Beginner Mistake

Don't create layers just for the sake of creating layers.

For a tiny application:

```text
UI → Repository → API
```

might be perfectly reasonable.

You don't necessarily need:

```text
UI
 ↓
ViewModel
 ↓
UseCase
 ↓
Repository
 ↓
Service
 ↓
RemoteDataSource
 ↓
ApiClient
 ↓
HTTP
```

for every single feature.

That creates unnecessary complexity.

The goal of architecture is:

> **Manage complexity, not create complexity.**

This principle is especially important because your roadmap explicitly says not to introduce architectural layers simply because a tutorial says every app must have them. 

---

# 12. The Big Picture

At this point, connect **Topic 3** and **Topic 4** together:

```text
                 UI
                  ↓
            ViewModel
                  ↓
             Repository
                  ↓
        ┌─────────┴─────────┐
        ↓                   ↓
 Remote Data Source    Local Data Source
        ↓                   ↓
    API Client            Database
        ↓
      Server
```

And the responsibilities are:

```text
ViewModel
→ "What does the UI need?"

Repository
→ "Where should I get the data?"

Data Source
→ "How do I access that data?"

API Client
→ "How do I communicate with the API?"

Local Data Source
→ "How do I access local storage?"
```

### ⭐ Core takeaway

> **The Data Layer isolates data access from the rest of the application.**

And the most important relationship to remember is:

**UI → ViewModel → Repository → Data Source → API/Database**