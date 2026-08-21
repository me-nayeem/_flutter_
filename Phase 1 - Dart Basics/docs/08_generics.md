# Generics

Generics let types describe the values they contain or produce. They provide type safety without creating a separate class or function for every data type.

## Generics you already use

```dart
final names = <String>['Nayeem', 'Rahim'];
final scores = <int>[10, 20, 30];
final user = <String, dynamic>{'name': 'Nayeem'};
```

`String`, `int`, and `dynamic` are type arguments. `List<String>` means the list may contain strings only, so `names.add(10)` is a compile-time error.

## Generic classes

Use a type parameter such as `T` when the class should work with multiple types.

```dart
class Box<T> {
  final T value;

  Box(this.value);
}

final nameBox = Box<String>('Nayeem');
final ageBox = Box<int>(21);
```

`T` is chosen when an object is created. The same `Box` definition remains type-safe for both cases.

## Generic functions

```dart
T getFirst<T>(List<T> items) {
  return items.first;
}

final name = getFirst(['Nayeem', 'Rahim']); // String
final number = getFirst([10, 20, 30]); // int
```

Dart infers `T` from the argument in most cases, so explicit type arguments are usually unnecessary.

## Multiple type parameters

```dart
class Pair<K, V> {
  final K key;
  final V value;

  Pair(this.key, this.value);
}

final userAge = Pair<String, int>('Nayeem', 21);
```

## Type bounds

Use `extends` on a type parameter to require a family of types.

```dart
T maximum<T extends num>(T first, T second) {
  return first > second ? first : second;
}
```

Here `T` must be numeric, so a `String` cannot be passed.

## Flutter connection

Generics are everywhere in Flutter and Dart APIs:

```dart
List<User>
Future<String>
Future<List<User>>
```

Read `Future<List<User>>` from the inside out: a list of users will be available later.

## Key takeaways

- Generics carry type information such as `List<String>`.
- `T` is a conventional name for a type parameter.
- Type inference keeps generic code concise.
- Bounds restrict which types are valid.

## Practice

1. Create `Box<T>` and instantiate it with a string and an integer.
2. Write a generic function that returns the last item in a list.
3. Explain why `getFirst([10, 20, 30])` returns an `int`.
