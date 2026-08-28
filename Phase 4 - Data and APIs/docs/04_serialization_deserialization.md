# 🔵 Phase 4 — Data and APIs

## 2. JSON & Serialization

Since you already understand REST APIs, we only need the part that matters for **Flutter development**.

The key problem is:

> **APIs give us JSON, but Flutter works with Dart objects.**

So we need to convert between them.

```text
API
 ↓
JSON
 ↓
Dart Object
 ↓
Flutter UI
```

And when sending data:

```text
Dart Object
 ↓
JSON
 ↓
API
```

---

## 1. What Is JSON?

A typical API response might look like:

```json
{
  "id": 1,
  "name": "Nayeem",
  "email": "nayeem@example.com"
}
```

In Dart, the equivalent structure is usually:

```dart
Map<String, dynamic>
```

For example:

```dart
final data = {
  'id': 1,
  'name': 'Nayeem',
  'email': 'nayeem@example.com',
};
```

But using raw maps everywhere becomes messy.

That's why we create **model classes**.

---

## 2. JSON → Dart Object

Suppose the API returns:

```json
{
  "id": 1,
  "name": "Nayeem"
}
```

Create a model:

```dart
class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
    );
  }
}
```

Now:

```dart
final user = User.fromJson(jsonData);
```

You can work with:

```dart
user.id
user.name
```

instead of:

```dart
jsonData['id']
jsonData['name']
```

This is much cleaner and safer.

---

# 3. Why `fromJson()` Matters

This:

```dart
factory User.fromJson(Map<String, dynamic> json)
```

defines how API data becomes your Dart object.

Think:

```text
JSON
 ↓
User.fromJson()
 ↓
User object
```

For example:

```dart
final user = User.fromJson({
  'id': 1,
  'name': 'Nayeem',
});
```

---

# 4. Dart Object → JSON

When sending data to an API, we often need the reverse conversion.

Add:

```dart
Map<String, dynamic> toJson() {
  return {
    'id': id,
    'name': name,
  };
}
```

Now:

```dart
final user = User(
  id: 1,
  name: 'Nayeem',
);

final json = user.toJson();
```

Result:

```dart
{
  'id': 1,
  'name': 'Nayeem',
}
```

The complete model:

```dart
class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
```

---

# 5. JSON Encoding & Decoding

Dart provides:

```dart
import 'dart:convert';
```

### JSON string → Dart object

```dart
final data = jsonDecode(jsonString);
```

### Dart object → JSON string

```dart
final jsonString = jsonEncode(data);
```

Think:

```text
jsonDecode()
JSON string → Dart data

jsonEncode()
Dart data → JSON string
```

---

# 6. Putting It Together With HTTP

Suppose:

```dart
final response = await http.get(url);
```

The response body is a **String**:

```dart
response.body
```

So:

```dart
final json = jsonDecode(response.body);
```

Then:

```dart
final user = User.fromJson(json);
```

Complete flow:

```text
HTTP Response
     ↓
response.body
     ↓
jsonDecode()
     ↓
Map<String, dynamic>
     ↓
User.fromJson()
     ↓
User
     ↓
Flutter UI
```

---

# 7. What About a List?

APIs often return:

```json
[
  {
    "id": 1,
    "name": "Nayeem"
  },
  {
    "id": 2,
    "name": "Rahim"
  }
]
```

After:

```dart
final data = jsonDecode(response.body);
```

you get a list.

Convert it to Dart objects:

```dart
final users = (data as List)
    .map((json) => User.fromJson(json))
    .toList();
```

Now:

```dart
List<User>
```

instead of:

```dart
List<dynamic>
```

This is an important pattern you'll use frequently.

---

# 8. Serialization vs Deserialization

These terms are worth knowing.

### Deserialization

```text
JSON → Dart object
```

Example:

```dart
User.fromJson(...)
```

### Serialization

```text
Dart object → JSON
```

Example:

```dart
user.toJson()
```

So:

```text
              Serialization
Dart Object ───────────────→ JSON


              Deserialization
JSON ──────────────────────→ Dart Object
```

---

# 🎯 What You Actually Need to Remember

For Flutter API development, master this flow:

```text
GET API
   ↓
response.body
   ↓
jsonDecode()
   ↓
Map/List
   ↓
Model.fromJson()
   ↓
Dart Model
   ↓
UI
```

And for sending data:

```text
Dart Model
   ↓
toJson()
   ↓
jsonEncode()
   ↓
HTTP request
```

These two flows are the foundation for the next topics.

### Next: **3. Model Classes**

We'll focus on how to design proper Flutter/Dart models for real API responses, including nested objects and nullable fields.
