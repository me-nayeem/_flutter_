# 🔵 Phase 4 — Data and APIs

## 5. Model Classes

> **Goal:** Learn how to represent API data with clean, strongly typed Dart classes instead of working directly with raw `Map<String, dynamic>` everywhere.

When an API returns JSON like:

```json
{
  "id": 1,
  "name": "Nayeem",
  "email": "nayeem@example.com"
}
```

we don't want our UI to constantly do:

```dart
json['name']
json['email']
json['id']
```

Instead, create a model:

```dart
class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
```

Now your application works with:

```dart
User user;
```

instead of an unstructured map.

---

## 1. Why Models Matter

Without models:

```dart
final name = json['name'];
final email = json['email'];
final id = json['id'];
```

As the application grows, this becomes difficult to maintain.

With models:

```dart
user.name
user.email
user.id
```

You get:

- Better readability
- Type safety
- Easier refactoring
- Cleaner UI code
- A clear representation of your data

Think of a model as:

> **The Dart representation of a piece of data used by your application.**

---

## 2. `fromJson()`

The most important part when receiving API data is:

```dart
factory User.fromJson(Map<String, dynamic> json)
```

It converts:

```text
JSON data
   ↓
User object
```

Example:

```dart
final user = User.fromJson(jsonData);
```

After that:

```dart
print(user.name);
```

is much cleaner than:

```dart
print(jsonData['name']);
```

---

## 3. `toJson()`

When sending a model back to an API, you commonly need the reverse:

```text
User object
   ↓
JSON-compatible Map
```

Add:

```dart
Map<String, dynamic> toJson() {
  return {
    'id': id,
    'name': name,
    'email': email,
  };
}
```

Now:

```dart
final data = user.toJson();
```

can be passed through `jsonEncode()` when creating an HTTP request.

---

# 4. Nested Models

Real APIs rarely contain only flat data.

Example:

```json
{
  "id": 1,
  "name": "Nayeem",
  "address": {
    "city": "Sylhet",
    "country": "Bangladesh"
  }
}
```

Don't keep the entire nested structure inside `User`.

Create another model:

```dart
class Address {
  final String city;
  final String country;

  Address({
    required this.city,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      country: json['country'],
    );
  }
}
```

Then:

```dart
class User {
  final int id;
  final String name;
  final Address address;

  User({
    required this.id,
    required this.name,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      address: Address.fromJson(json['address']),
    );
  }
}
```

Now:

```dart
user.address.city
```

is clean and strongly structured.

---

# 5. Nullable API Fields

APIs may return:

```json
{
  "id": 1,
  "name": "Nayeem",
  "phone": null
}
```

Your model should reflect that:

```dart
class User {
  final int id;
  final String name;
  final String? phone;

  User({
    required this.id,
    required this.name,
    this.phone,
  });
}
```

Notice:

```dart
String? phone;
```

because the API can return `null`.

Don't blindly use:

```dart
json['phone']!
```

unless you genuinely know the API guarantees that value.

---

# 6. Nested Lists

Another common API structure:

```json
{
  "id": 1,
  "name": "Nayeem",
  "skills": [
    {
      "name": "Flutter"
    },
    {
      "name": "Dart"
    }
  ]
}
```

Create:

```dart
class Skill {
  final String name;

  Skill({required this.name});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'],
    );
  }
}
```

Then:

```dart
class User {
  final int id;
  final String name;
  final List<Skill> skills;

  User({
    required this.id,
    required this.name,
    required this.skills,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      skills: (json['skills'] as List)
          .map((item) => Skill.fromJson(item))
          .toList(),
    );
  }
}
```

Now you have:

```dart
List<Skill>
```

instead of:

```dart
List<dynamic>
```

---

# 7. Model Responsibility

A model should primarily represent **data**.

For example:

```text
User
├── id
├── name
├── email
└── address
```

Don't turn your model into a place for:

```text
HTTP requests
Navigation
UI code
setState()
Widgets
```

Keep responsibilities separated.

A useful mental model:

```text
API JSON
   ↓
Model
   ↓
Application
   ↓
UI
```

Later in the Architecture phase, we'll separate the API/service/repository responsibilities more formally.

---

# 8. Real-World Model Structure

For a larger Flutter project, you might organize models like:

```text
lib/
├── models/
│   ├── user.dart
│   ├── address.dart
│   └── product.dart
│
├── services/
│   └── user_service.dart
│
└── screens/
    └── user_screen.dart
```

The exact folder structure can vary, but the important principle is:

> **Keep data representation separate from UI code.**

---

# 🎯 What You Need to Master

For now, focus on these four things:

```text
JSON
 ↓
fromJson()
 ↓
Dart Model
 ↓
toJson()
 ↓
JSON
```

And be comfortable with:

- Basic models
- `factory` constructors for parsing
- Nullable fields
- Nested objects
- Lists of nested objects
- `Map<String, dynamic>`
- `List<Model>`
