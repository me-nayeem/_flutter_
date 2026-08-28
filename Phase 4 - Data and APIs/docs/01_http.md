# 🔵 Phase 4 — Data and APIs

# 1. HTTP & REST APIs

> **Goal:** Understand how a Flutter application communicates with a backend server, how HTTP requests work, and how REST APIs are used to send and receive data.

Until now, most of our Flutter applications have worked with data already available inside the app.

Real applications need external data:

```text
Flutter App
    ↓
Backend / API
    ↓
Database
```

For example:

```text
Flutter App
    ↓
GET /products
    ↓
Server
    ↓
Database
    ↓
Products
    ↓
Flutter App
```

Understanding this communication is the foundation for working with APIs, authentication, databases, and real-world applications.

---

## 1. What Is an API?

**API** stands for **Application Programming Interface**.

In a Flutter application, an API is commonly used as a communication interface between your app and a backend server.

For example, imagine a weather application.

Your Flutter app needs the current weather:

```text
Flutter App
    │
    │ "Give me the weather for Dhaka"
    ▼
Weather API
    │
    ▼
Weather Server
    │
    ▼
Weather Data
    │
    ▼
Flutter App
```

The Flutter application doesn't directly access the server's database.

It communicates through the API.

---

# 2. What Is HTTP?

**HTTP** stands for **Hypertext Transfer Protocol**.

It is one of the main protocols used for communication between clients and servers on the web.

In a Flutter application:

```text
Flutter
   ↓
HTTP Request
   ↓
Server
   ↓
HTTP Response
   ↓
Flutter
```

A request contains information such as:

```text
Method
URL
Headers
Body
```

The server responds with information such as:

```text
Status Code
Headers
Body
```

---

# 3. Client and Server

You should clearly understand these two terms.

### Client

The application making the request.

In our case:

```text
Flutter App
```

### Server

The system receiving the request and processing it.

For example:

```text
Flutter App
      │
      │ HTTP Request
      ▼
   Backend
      │
      ▼
   Database
```

The server may:

* Validate the request
* Read/write database data
* Authenticate users
* Perform business logic
* Return a response

---

# 4. What Is a REST API?

**REST** stands for **Representational State Transfer**.

A REST API is an API designed around resources and standard HTTP methods.

For example, suppose our application manages users.

The resource is:

```text
users
```

The API might expose:

```text
GET    /users
GET    /users/10
POST   /users
PUT    /users/10
DELETE /users/10
```

The URL represents the resource.

The HTTP method describes what we want to do with it.

---

# 5. HTTP Methods

You must understand these four methods well:

| Method   | Purpose              |
| -------- | -------------------- |
| `GET`    | Retrieve data        |
| `POST`   | Create/send new data |
| `PUT`    | Replace/update data  |
| `DELETE` | Delete data          |

There is also:

```text
PATCH
```

which is commonly used for partial updates.

For now, focus strongly on:

```text
GET
POST
PUT
DELETE
```

---

# 6. GET

`GET` is used to retrieve data.

Example:

```http
GET /users
```

Meaning:

> Give me the users.

Or:

```http
GET /users/10
```

Meaning:

> Give me the user whose ID is 10.

Conceptually:

```text
Flutter
   │
   │ GET /users
   ▼
Server
   │
   │ users data
   ▼
Flutter
```

A `GET` request normally shouldn't be used to modify server data.

---

# 7. POST

`POST` is commonly used to create a new resource or submit data.

Example:

```http
POST /users
```

with a request body:

```json
{
  "name": "Nayeem",
  "email": "nayeem@example.com"
}
```

Conceptually:

```text
Flutter
   │
   │ POST /users
   │
   │ { user data }
   ▼
Server
   │
   ▼
Create user
```

The server may then return the newly created resource.

---

# 8. PUT

`PUT` is commonly used to update/replace a resource.

Example:

```http
PUT /users/10
```

with:

```json
{
  "name": "Nayeem",
  "email": "new@example.com"
}
```

Conceptually:

```text
Flutter
   │
   │ PUT /users/10
   ▼
Server
   │
   ▼
Update user 10
```

---

# 9. PATCH

`PATCH` is commonly used when you only want to modify part of a resource.

For example:

```http
PATCH /users/10
```

with:

```json
{
  "name": "New Name"
}
```

Only the name needs to change.

You don't necessarily need to send the entire user object.

---

# 10. DELETE

`DELETE` is used to remove a resource.

Example:

```http
DELETE /users/10
```

Meaning:

> Delete user 10.

Conceptually:

```text
Flutter
   │
   │ DELETE /users/10
   ▼
Server
   │
   ▼
Delete resource
```

---

# 11. HTTP Request

A request can be thought of as:

```text
HTTP Request
│
├── Method
├── URL
├── Headers
└── Body
```

For example:

```http
POST https://api.example.com/users
Content-Type: application/json

{
  "name": "Nayeem"
}
```

Here:

```text
Method  → POST
URL     → https://api.example.com/users
Header  → Content-Type: application/json
Body    → {"name": "Nayeem"}
```

---

# 12. URL

An API URL usually contains:

```text
Base URL
+
Endpoint
```

Example:

```text
https://api.example.com
```

is the base URL.

Then:

```text
/users
```

is an endpoint.

Together:

```text
https://api.example.com/users
```

Another endpoint:

```text
/products
```

becomes:

```text
https://api.example.com/products
```

---

# 13. Path Parameters

Suppose:

```text
GET /users/25
```

Here:

```text
25
```

is a path parameter.

In Flutter, you might construct:

```dart
final userId = 25;

final url = Uri.parse(
  'https://api.example.com/users/$userId',
);
```

The server can use that ID to identify the requested user.

---

# 14. Query Parameters

Sometimes we want to filter or customize a request.

Example:

```text
GET /products?category=phone
```

Here:

```text
category=phone
```

is a query parameter.

Another example:

```text
GET /products?page=2&limit=20
```

This might mean:

```text
page  = 2
limit = 20
```

In Dart, it's better to construct query parameters using `Uri` rather than manually concatenating strings:

```dart
final uri = Uri.https(
  'api.example.com',
  '/products',
  {
    'page': '2',
    'limit': '20',
  },
);
```

---

# 15. HTTP Response

The server sends a response back.

Conceptually:

```text
HTTP Response
│
├── Status Code
├── Headers
└── Body
```

Example:

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "name": "Nayeem",
  "age": 20
}
```

The important parts are:

```text
200
    ↓
Status code

application/json
    ↓
Content type

{ ... }
    ↓
Response body
```

---

# 16. HTTP Status Codes

You don't need to memorize hundreds of codes.

Understand the major categories.

### `2xx` — Success

```text
200 OK
201 Created
204 No Content
```

### `4xx` — Client/request problem

```text
400 Bad Request
401 Unauthorized
403 Forbidden
404 Not Found
```

### `5xx` — Server problem

```text
500 Internal Server Error
502 Bad Gateway
503 Service Unavailable
```

The key idea:

```text
2xx → request succeeded

4xx → problem with the request/client/authentication

5xx → server-side problem
```

---

# 17. `200 OK`

One of the most common responses:

```text
200 OK
```

Usually means the request succeeded.

For example:

```text
GET /products
     ↓
200 OK
     ↓
Products returned
```

---

# 18. `201 Created`

Commonly returned after successfully creating something.

For example:

```text
POST /users
     ↓
201 Created
```

This tells the client that a new resource was successfully created.

---

# 19. `400 Bad Request`

This generally means the server couldn't process the request because the request was invalid.

For example:

```json
{
  "email": ""
}
```

when the server requires a valid email.

The server might respond:

```text
400 Bad Request
```

---

# 20. `401 Unauthorized`

Usually means authentication is required or the provided authentication credentials are invalid.

For example:

```text
Flutter
   │
   │ GET /profile
   │
   │ no valid authentication
   ▼
Server
   │
   ▼
401 Unauthorized
```

We'll study authentication more deeply later in Phase 4.

---

# 21. `404 Not Found`

Usually means the requested resource or endpoint wasn't found.

Example:

```text
GET /users/99999
```

If that user doesn't exist:

```text
404 Not Found
```

---

# 22. `500 Internal Server Error`

This generally means something went wrong on the server.

```text
Flutter
   │
   │ Request
   ▼
Server
   │
   │ Internal failure
   ▼
500
```

Important:

> Not every API error is caused by your Flutter code.

Your app must handle server failures gracefully.

---

# 23. Request Headers

Headers contain additional information about the request.

For example:

```http
Content-Type: application/json
```

means:

> The request body is JSON.

Another common header:

```http
Authorization: Bearer <token>
```

is used to authenticate requests.

You'll learn authentication later, but understand the basic idea now:

```text
Headers
   ↓
Additional metadata/instructions for HTTP communication
```

---

# 24. Request Body

When sending data with methods such as `POST`, the request often contains a body.

Example:

```json
{
  "title": "Learn Flutter",
  "completed": false
}
```

Conceptually:

```text
Flutter
   │
   │ POST /tasks
   │
   │ Body:
   │ {
   │   "title": "Learn Flutter"
   │ }
   ▼
Server
```

---

# 25. JSON

APIs commonly exchange data using:

```text
JSON
```

For example:

```json
{
  "id": 1,
  "name": "Flutter",
  "isActive": true
}
```

We'll study JSON and serialization properly in the **next topic**, so for now focus on understanding:

```text
HTTP
   ↓
Request
   ↓
Server
   ↓
JSON response
   ↓
Flutter
```

---

# 26. Making an HTTP Request in Flutter

Flutter doesn't require you to implement HTTP from scratch.

A commonly used package is:

```text
http
```

Add it to your project:

```bash
flutter pub add http
```

Then:

```dart
import 'package:http/http.dart' as http;
```

---

# 27. Simple GET Request

Example:

```dart
import 'package:http/http.dart' as http;

Future<void> fetchUsers() async {
  final url = Uri.parse(
    'https://api.example.com/users',
  );

  final response = await http.get(url);

  print(response.statusCode);
  print(response.body);
}
```

Let's understand it carefully.

---

# 28. Step-by-Step GET Request

### Step 1

Create the URL:

```dart
final url = Uri.parse(
  'https://api.example.com/users',
);
```

### Step 2

Send the request:

```dart
final response = await http.get(url);
```

### Step 3

Wait for the server:

```dart
await
```

### Step 4

Receive the response:

```dart
response
```

### Step 5

Inspect it:

```dart
response.statusCode
response.body
```

---

# 29. Why `await`?

Network communication takes time.

Your application sends:

```text
Request
   ↓
Internet
   ↓
Server
   ↓
Processing
   ↓
Response
```

This doesn't happen instantly.

Therefore:

```dart
await http.get(url);
```

means:

> Wait for the asynchronous HTTP operation to complete before continuing this function.

The UI thread isn't simply frozen waiting for the network.

This connects directly to the Dart `Future` and `async/await` concepts you learned in Phase 1.

---

# 30. Handling the Status Code

Don't assume every response succeeded.

Instead of:

```dart
final response = await http.get(url);

print(response.body);
```

you should inspect the result:

```dart
final response = await http.get(url);

if (response.statusCode == 200) {
  print(response.body);
} else {
  print('Request failed');
}
```

A more realistic approach:

```dart
if (response.statusCode >= 200 &&
    response.statusCode < 300) {
  // Success
} else {
  // Failure
}
```

---

# 31. Network Errors vs HTTP Errors

This distinction is very important.

### HTTP error

The server responded:

```text
404
500
```

You received a response, but it indicates failure.

### Network error

The request may fail because:

```text
No internet connection
DNS failure
Connection timeout
Server unreachable
```

There may be **no normal HTTP response**.

Therefore your code should also handle exceptions.

---

# 32. `try-catch`

Example:

```dart
Future<void> fetchUsers() async {
  try {
    final url = Uri.parse(
      'https://api.example.com/users',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('HTTP error: ${response.statusCode}');
    }
  } catch (e) {
    print('Network error: $e');
  }
}
```

Conceptually:

```text
Request
   │
   ├── Success → response
   │
   └── Network exception → catch
```

This distinction will become important when we build proper loading/error states.

---

# 33. POST Request

Example:

```dart
final url = Uri.parse(
  'https://api.example.com/users',
);

final response = await http.post(
  url,
  headers: {
    'Content-Type': 'application/json',
  },
  body: '''
    {
      "name": "Nayeem"
    }
  ''',
);
```

The request contains:

```text
POST
 ↓
URL
 ↓
Headers
 ↓
Body
```

We'll improve the body handling in the next lesson using JSON encoding.

---

# 34. A Better POST Structure

Instead of embedding everything directly inside the request:

```dart
final response = await http.post(
  url,
  headers: {
    'Content-Type': 'application/json',
  },
  body: jsonEncode({
    'name': 'Nayeem',
  }),
);
```

Here:

```dart
jsonEncode(...)
```

converts a Dart object into JSON.

We'll study this properly in the next topic.

---

# 35. A Simple API Service

Don't put all HTTP code directly inside your UI.

Avoid:

```dart
class HomePage extends StatefulWidget {
  // ...

  // HTTP request directly inside UI
}
```

Instead, start separating responsibilities:

```text
UI
 ↓
Service
 ↓
API
```

Example:

```dart
class UserService {
  Future<http.Response> getUsers() async {
    final url = Uri.parse(
      'https://api.example.com/users',
    );

    return http.get(url);
  }
}
```

Then your UI can call:

```dart
final service = UserService();

final response = await service.getUsers();
```

This is a simple first step toward the **repository and architecture concepts** we'll learn later.

---

# 36. API Communication Architecture

Keep this mental model:

```text
┌─────────────────────────┐
│       Flutter UI        │
│                         │
│  Screen / Widget        │
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────┐
│      Data Layer         │
│                         │
│  Service / API Client   │
└────────────┬────────────┘
             │
             ▼
        HTTP Request
             │
             ▼
┌─────────────────────────┐
│        Backend          │
│                         │
│       REST API          │
└─────────────────────────┘
```

Later, we'll introduce:

```text
Repository
Models
State management
Authentication
```

and build a more complete architecture.

---

# 37. Important: API Is Not Database

Don't confuse these:

```text
Flutter App
     ↓
API
     ↓
Backend
     ↓
Database
```

Your Flutter app normally communicates with the **API**, not directly with the database.

For example:

```text
❌ Flutter → PostgreSQL

✅ Flutter → REST API → Backend → PostgreSQL
```

This separation protects the database and keeps business logic on the server.

---

# 38. Practice: Build a Simple API App

For practice, use a public test API such as JSONPlaceholder.

Create a simple screen:

```text
Users
 ├── User 1
 ├── User 2
 ├── User 3
 └── ...
```

Your first version only needs to:

1. Send a `GET` request.
2. Check the status code.
3. Print/display the response body.
4. Handle an exception.
5. Show a loading indicator while waiting.

At this stage, **don't worry about beautiful architecture**.

The goal is to understand the complete flow:

```text
Button / Screen
      ↓
HTTP GET
      ↓
Server
      ↓
HTTP Response
      ↓
Status Code
      ↓
Response Body
      ↓
Flutter UI
```

---

# 🎯 What You Should Master From This Topic

Before moving forward, make sure you can explain these without looking at notes:

```text
API
HTTP
Client
Server
REST API
Endpoint
GET
POST
PUT
PATCH
DELETE
URL
Path parameter
Query parameter
Headers
Request body
Response body
HTTP status code
2xx
4xx
5xx
Network error
HTTP error
async/await
```

And you should understand this basic Flutter code:

```dart
final response = await http.get(
  Uri.parse('https://api.example.com/users'),
);

if (response.statusCode >= 200 &&
    response.statusCode < 300) {
  print(response.body);
}
```

More importantly, understand **what happens behind that code**:

```text
Flutter
   │
   │ HTTP Request
   │
   ▼
Server
   │
   │ HTTP Response
   │
   ▼
Flutter
   │
   ├── Status Code
   └── Body
```

---

## ⏭️ Next Topic

### **2. JSON & Serialization**

We'll learn how to take this:

```json
{
  "id": 1,
  "name": "Nayeem"
}
```

and turn it into useful Dart objects:

```dart
User(
  id: 1,
  name: 'Nayeem',
)
```

Then we'll go in the other direction:

```text
Dart Object
    ↓
JSON
    ↓
HTTP Request
```

This is the bridge between **API data and your Flutter application's Dart code**.
