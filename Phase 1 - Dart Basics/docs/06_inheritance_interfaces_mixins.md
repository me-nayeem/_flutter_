# Inheritance, Interfaces, and Mixins

Dart offers three related ways to share or require behavior: `extends`, `implements`, and `with`.

## Inheritance with `extends`

Inheritance creates a specialized class from a parent class. The child inherits the parent's implementation.

```dart
class Animal {
  final String name;

  Animal(this.name);

  void eat() {
    print('$name is eating.');
  }
}

class Dog extends Animal {
  Dog(String name) : super(name);

  void bark() {
    print('$name says woof.');
  }
}

final dog = Dog('Buddy');
dog.eat();
dog.bark();
```

`super(name)` passes the argument to the parent constructor.

## Override inherited behavior

Use `@override` when a child replaces an inherited member.

```dart
class Cat extends Animal {
  Cat(String name) : super(name);

  @override
  void eat() {
    print('$name eats quietly.');
  }
}
```

`super` can also call a parent's method from an override or another child method.

## Interfaces with `implements`

Every Dart class defines an implicit interface. `implements` requires a class to provide every member in that interface; it does not inherit the implementation.

```dart
abstract class Playable {
  void play();
}

class Song implements Playable {
  @override
  void play() {
    print('Playing song.');
  }
}
```

Use an `abstract class` when the type is intended as a contract or shared base, rather than something created directly.

## Mixins with `with`

A mixin shares a small piece of reusable behavior across otherwise unrelated classes.

```dart
mixin Loggable {
  void log(String message) {
    print(message);
  }
}

class Order with Loggable {
  void submit() {
    log('Order submitted.');
  }
}
```

A class can use multiple mixins: `class Duck with Swimming, Flying {}`.

## Choose the right tool

| Keyword | Meaning | Use it when |
| --- | --- | --- |
| `extends` | Inherits a base implementation | The child is a specialized form of the parent |
| `implements` | Fulfills a contract | Different types need the same API |
| `with` | Reuses focused behavior | The behavior should be composed into multiple types |

## Flutter connection

You will see `@override` often, including when overriding a widget's `build` method. Prefer composition and small focused classes over deep inheritance chains.

## Practice

1. Create `Vehicle` and `Car extends Vehicle`; override a method in `Car`.
2. Define an abstract `Payable` contract and implement it in two classes.
3. Write a `Timestamped` mixin and apply it to a model class.
