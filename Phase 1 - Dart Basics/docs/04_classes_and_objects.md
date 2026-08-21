# Classes and Objects

A class defines a type. An object is one instance of that type, with its own data and behavior.

## Learning goals

- Define a class and create objects from it.
- Read and update properties.
- Add methods that use an object's data.

## Define a class

```dart
class User {
  String name;
  int age;

  User(this.name, this.age);
}
```

`name` and `age` are properties. `User(this.name, this.age)` is a constructor; constructors are covered in detail in the next lesson.

## Create objects

```dart
final firstUser = User('Nayeem', 21);
final secondUser = User('Rahim', 25);

print(firstUser.name); // Nayeem
print(secondUser.age); // 25
```

Both objects have the same structure, but their property values are separate.

## Add behavior with methods

A function declared inside a class is a method.

```dart
class User {
  String name;
  int age;

  User(this.name, this.age);

  void introduce() {
    print('Hi, I am $name and I am $age years old.');
  }
}

final user = User('Nayeem', 21);
user.introduce();
```

Methods can access the properties of the current object directly.

## Mutable and immutable properties

Properties that are not `final` can be reassigned:

```dart
final user = User('Nayeem', 21);
user.age = 22;
```

Use `final` for data that should be fixed after an object is created.

```dart
class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}
```

## Model data and behavior

Classes keep related data and behavior together.

```dart
class BankAccount {
  double balance;

  BankAccount(this.balance);

  void deposit(double amount) {
    balance += amount;
  }

  bool withdraw(double amount) {
    if (amount > balance) return false;
    balance -= amount;
    return true;
  }
}
```

## Flutter connection

Apps commonly use classes for domain models such as `User`, `Product`, `Order`, and `Article`. Typed objects are clearer and safer than passing unstructured maps throughout an app.

## Key takeaways

- A class is a blueprint; an object is an instance.
- Each object owns its own property values.
- Methods express behavior related to that data.
- Use `final` unless the property genuinely needs to change.

## Practice

1. Create a `Product` class with `name` and `price`.
2. Add `displayInfo()` to print its data.
3. Create two products and call the method on each.
