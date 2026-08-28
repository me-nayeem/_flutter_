# 2. REST APIs

## First: What is an API?

**API = Application Programming Interface**

An API allows two different software systems to communicate.

For example, imagine your Flutter app is a **Student Study Tracker**.

The app needs the user's study tasks:

```text
Flutter App
     │
     │  "Give me today's tasks"
     ▼
   REST API
     │
     ▼
   Backend
     │
     ▼
  Database
```

The backend gets the data from the database and sends it back:

```text
Database
   │
   ▼
Backend
   │
   ▼
REST API
   │
   ▼
Flutter App
```

The Flutter application doesn't normally talk directly to the database.

---

# 1. REST Concepts

## What is REST?

**REST = Representational State Transfer**

REST is an **architectural style** for designing web APIs.

A REST API generally uses HTTP and represents things in your application as **resources**.

For example, in a study-tracker application:

```text
Users
Tasks
Courses
Study Sessions
Notes
```

Each of these can be a resource.

For example:

```text
/users
/tasks
/courses
/study-sessions
```

---

## REST uses HTTP methods

The most important HTTP methods you'll encounter are:

| Method   | Purpose               | Example            |
| -------- | --------------------- | ------------------ |
| `GET`    | Read data             | Get all tasks      |
| `POST`   | Create data           | Create a task      |
| `PUT`    | Replace/update data   | Update a task      |
| `PATCH`  | Partially update data | Change task status |
| `DELETE` | Delete data           | Delete a task      |

Think of them as CRUD operations:

```text
Create  → POST
Read    → GET
Update  → PUT / PATCH
Delete  → DELETE
```

---

## Example

Suppose your backend has:

```text
https://api.example.com/tasks
```

### Get tasks

```http
GET /tasks
```

### Create a task

```http
POST /tasks
```

### Update task 10

```http
PATCH /tasks/10
```

### Delete task 10

```http
DELETE /tasks/10
```

The important idea is that **the URL identifies the resource, while the HTTP method describes what you want to do with it.**

---

# REST is usually stateless

This is an important REST concept.

**Stateless** means the server doesn't rely on remembering the previous request in order to understand the current request.

For example:

```http
GET /tasks/10
Authorization: Bearer abc123
```

The request contains the information necessary for the server to process it.

The next request:

```http
GET /tasks/20
Authorization: Bearer abc123
```

is independently understandable.

This becomes very important when you later learn:

* Authentication
* JWT
* Access tokens
* Refresh tokens
* HTTP headers

---

# 2. Endpoints

An **endpoint** is a specific URL through which your application can interact with a resource.

For example:

```text
https://api.example.com/tasks
```

could be an endpoint.

You might have:

```text
GET    /tasks
POST   /tasks
GET    /tasks/15
PATCH  /tasks/15
DELETE /tasks/15
```

These are different API operations.

---

## Endpoint vs API

People sometimes use these terms interchangeably, but conceptually:

### API

The complete interface:

```text
Study Tracker API
```

### Endpoint

One specific access point:

```text
GET /tasks
```

So:

```text
API
│
├── GET /tasks
├── POST /tasks
├── GET /tasks/:id
├── PATCH /tasks/:id
└── DELETE /tasks/:id
```

---

# 3. Path Parameters

A **path parameter** is dynamic data placed directly inside the URL path.

Suppose we have:

```text
/tasks/25
```

Here:

```text
25
```

is the task ID.

The endpoint might be defined as:

```text
/tasks/:id
```

where `:id` is a path parameter.

---

## Example

Suppose you want task 25:

```http
GET /tasks/25
```

The backend receives:

```text
id = 25
```

and can find:

```text
Task #25
```

---

## Why use path parameters?

Path parameters are useful when you're identifying a **specific resource**.

Examples:

```text
/users/10
/products/50
/orders/123
/tasks/25
```

Think:

> **"I want this specific thing."**

---

## Flutter example

Later, in Flutter, you might build:

```dart
final taskId = 25;

final url = Uri.parse(
  'https://api.example.com/tasks/$taskId',
);
```

The resulting URL is:

```text
https://api.example.com/tasks/25
```

Then:

```dart
final response = await http.get(url);
```

---

# 4. Query Parameters

Query parameters are additional parameters placed after `?` in a URL.

Example:

```text
/tasks?completed=true
```

Here:

```text
completed=true
```

is a query parameter.

---

## Multiple query parameters

You can have:

```text
/tasks?completed=true&limit=10
```

There are two parameters:

```text
completed = true
limit = 10
```

---

## Common uses

Query parameters are especially useful for:

### Filtering

```text
/tasks?completed=true
```

Meaning:

> Give me completed tasks.

### Searching

```text
/tasks?search=flutter
```

Meaning:

> Find tasks related to Flutter.

### Pagination

```text
/tasks?page=2&limit=20
```

Meaning:

> Give me page 2 with 20 items.

### Sorting

```text
/tasks?sort=createdAt
```

---

# Path vs Query Parameters

This is **very important**.

### Path parameter

```text
/tasks/25
```

Means:

> Give me task **25**.

### Query parameter

```text
/tasks?completed=true
```

Means:

> Give me tasks **filtered by completed status**.

A good mental model:

```text
Path parameter
      ↓
Identifies a resource

Query parameter
      ↓
Filters/customizes the result
```

---

## Example

Imagine an e-commerce API.

Specific product:

```text
/products/500
```

Products filtered by category:

```text
/products?category=shoes
```

Products with pagination:

```text
/products?page=2&limit=20
```

Specific product in a specific category doesn't necessarily mean you'd combine them, but you can:

```text
/products/500?include=reviews
```

---

# 5. Request Bodies

A **request body** contains data that you're sending to the server.

You'll commonly use request bodies with:

```text
POST
PUT
PATCH
```

For example, you want to create a new task.

You send:

```http
POST /tasks
```

with a JSON body:

```json
{
  "title": "Learn REST API",
  "completed": false,
  "priority": "high"
}
```

The server receives that information and creates the task.

---

# Why use a request body?

Imagine creating a user.

You could potentially have:

```text
/users?name=Nayeem&email=nayeem@example.com&age=22
```

But this becomes ugly when you have lots of data.

Instead:

```http
POST /users
```

Body:

```json
{
  "name": "Nayeem",
  "email": "nayeem@example.com",
  "age": 22
}
```

Much cleaner.

---

# Request body in Flutter

With the `http` package, you might eventually write:

```dart
final response = await http.post(
  Uri.parse('https://api.example.com/tasks'),
  headers: {
    'Content-Type': 'application/json',
  },
  body: jsonEncode({
    'title': 'Learn REST API',
    'completed': false,
  }),
);
```

Let's break it down:

```dart
Uri.parse(...)
```

→ API URL

```dart
headers
```

→ tells the server what kind of data you're sending

```dart
jsonEncode(...)
```

→ converts Dart data into JSON text

```dart
body
```

→ actual data being sent to the server

---

# 6. API Responses

After your Flutter app sends a request, the server sends back a **response**.

A response generally contains:

```text
Status code
Headers
Body
```

For example:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

Body:

```json
{
  "id": 25,
  "title": "Learn REST API",
  "completed": false
}
```

---

# HTTP Status Codes

As a Flutter developer, you need to become very comfortable with status codes.

## 2xx — Success

### `200 OK`

Request succeeded.

Example:

```http
GET /tasks/25
```

Response:

```text
200 OK
```

---

### `201 Created`

A new resource was successfully created.

Example:

```http
POST /tasks
```

Response:

```text
201 Created
```

---

### `204 No Content`

Request succeeded but there is no response body.

Commonly used for:

```http
DELETE /tasks/25
```

---

# 4xx — Client Errors

These usually indicate something wrong with the request or authorization.

### `400 Bad Request`

The request is invalid.

Example:

```json
{
  "error": "Title is required"
}
```

---

### `401 Unauthorized`

Authentication is missing or invalid.

For example:

```text
Access token expired
```

---

### `403 Forbidden`

You are authenticated, but you don't have permission.

For example:

```text
Normal user → tries to access admin endpoint
```

---

### `404 Not Found`

The requested resource doesn't exist.

```http
GET /tasks/999999
```

Response:

```text
404 Not Found
```

---

# 5xx — Server Errors

These generally mean something went wrong on the server.

### `500 Internal Server Error`

Something unexpected happened on the backend.

From Flutter's perspective, you generally shouldn't assume the problem is your UI code.

---

# Complete REST API Example

Let's put everything together.

Imagine your Study Tracker backend provides:

```text
https://api.studytracker.com
```

## Get all tasks

```http
GET /tasks
```

Response:

```json
[
  {
    "id": 1,
    "title": "Learn Dart"
  },
  {
    "id": 2,
    "title": "Learn Flutter"
  }
]
```

---

## Get one task

```http
GET /tasks/2
```

Here:

```text
/tasks
   ↑
resource

/2
 ↑
path parameter
```

Response:

```json
{
  "id": 2,
  "title": "Learn Flutter"
}
```

---

## Search/filter tasks

```http
GET /tasks?completed=false
```

Here:

```text
completed=false
```

is a query parameter.

Response:

```json
[
  {
    "id": 2,
    "title": "Learn Flutter",
    "completed": false
  }
]
```

---

## Create a task

```http
POST /tasks
```

Request body:

```json
{
  "title": "Learn REST APIs",
  "completed": false
}
```

Response:

```http
201 Created
```

```json
{
  "id": 3,
  "title": "Learn REST APIs",
  "completed": false
}
```

---

## Update a task

```http
PATCH /tasks/3
```

Request body:

```json
{
  "completed": true
}
```

Response:

```http
200 OK
```

```json
{
  "id": 3,
  "title": "Learn REST APIs",
  "completed": true
}
```

---

## Delete a task

```http
DELETE /tasks/3
```

Response:

```http
204 No Content
```

---

# How Flutter fits into all of this

Eventually your architecture will look something like:

```text
                 Flutter App
                     │
                     ▼
              Repository/Service
                     │
                     ▼
                  HTTP
                     │
                     ▼
                REST API
                     │
                     ▼
                  Backend
                     │
                     ▼
                 Database
```

For example:

```dart
Future<void> createTask() async {
  final response = await http.post(
    Uri.parse('https://api.example.com/tasks'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'title': 'Learn REST APIs',
      'completed': false,
    }),
  );

  if (response.statusCode == 201) {
    print('Task created!');
  } else {
    print('Failed to create task');
  }
}
```

You don't need to memorize this code yet. **First understand the HTTP/API concepts.** Later, we'll properly learn API calls, JSON parsing, models, error handling, authentication, and repository/service architecture.

---

# The whole concept in one picture

```text
                         REST API
                            │
             ┌──────────────┼──────────────┐
             │              │              │
          Endpoint       HTTP Method      Data
             │              │              │
          /tasks           GET          Query Params
          /tasks/10        POST         Path Params
                          PATCH         Request Body
                         DELETE
                                          │
                                          ▼
                                     JSON Response
                                          │
                                          ▼
                                    Status Code
                                      200
                                      201
                                      400
                                      401
                                      404
                                      500
```

## The 6 things you should remember

| Concept             | Meaning                        | Example                     |
| ------------------- | ------------------------------ | --------------------------- |
| **REST**            | Architecture/style for APIs    | REST API                    |
| **Endpoint**        | Specific API access point      | `/tasks`                    |
| **Path parameter**  | Identifies a specific resource | `/tasks/10`                 |
| **Query parameter** | Filters/customizes a request   | `/tasks?page=2`             |
| **Request body**    | Data sent to server            | `{"title":"Learn Flutter"}` |
| **API response**    | Data/result returned by server | `200 + JSON`                |

### Professional mental model

When you see an API request, train yourself to ask:

> **1. What resource am I accessing?**
> `/tasks`
>
> **2. What operation am I performing?**
> `GET`
>
> **3. Am I identifying a specific resource?**
> `/tasks/10`
>
> **4. Do I need filtering/pagination/search?**
> `?page=2&limit=20`
>
> **5. Am I sending data?**
> Request body
>
> **6. What did the server return?**
> Status code + response body

