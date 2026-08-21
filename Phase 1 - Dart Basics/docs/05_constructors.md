# Constructors

A constructor initializes an object when it is created. Dart supports concise constructors, named parameters, named constructors, constant constructors, and initializer lists.

## Basic constructor

```dart
class User {
  String name;
  int age;

  User(this.name, this.age);
}

final user = User('Nayeem', 21);
```

`this.name` means the `name` property of the object being created. The short form above is equivalent to assigning each argument in a constructor body.

## Named parameters

Named constructor parameters make object creation clear and are common in Flutter.

```dart
class User {
  final String name;
  final int age;

  User({
    required this.name,
    required this.age,
  });
}

final user = User(name: 'Nayeem', age: 21);
```

## Default values

An optional named parameter can have a default value.

```dart
class User {
  final String name;
  final String country;

  User({
    required this.name,
    this.country = 'Bangladesh',
  });
}

final user = User(name: 'Nayeem');
```

## Named constructors

Named constructors provide meaningful alternative ways to create the same type.

```dart
class User {
  final String name;
  final int age;

  User({required this.name, required this.age});

  User.guest()
      : name = 'Guest',
        age = 0;
}

final guest = User.guest();
```

## Initializer lists

An initializer list runs before the constructor body and is required to initialize `final` fields that are not initialized by a field formal.

```dart
class Rectangle {
  final double width;
  final double height;
  final double area;

  Rectangle(this.width, this.height) : area = width * height;
}
```

## Const constructors

When every instance field is `final`, a class can have a `const` constructor.

```dart
class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);
}

const origin = Point(0, 0);
```

This pattern appears frequently in Flutter, for example `const Text('Hello')`.

## Key takeaways

- Constructors create initialized objects.
- Prefer named parameters for readability.
- Use named constructors for distinct creation cases, such as a guest user.
- Use initializer lists for calculated or validated `final` values.

## Practice

1. Create a `Book` with final `title`, `author`, and `price` fields.
2. Use required named parameters for title and author; default price to `0`.
3. Add `Book.free` that always sets the price to `0`.
