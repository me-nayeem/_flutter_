# Collections: Lists, Sets, and Maps

Collections store groups of values. Dart's three core collection types are `List`, `Set`, and `Map`.

## Learning goals

- Choose the right collection for ordered items, unique items, or key-value data.
- Add, remove, access, and transform collection values.

## List

A `List` is an ordered collection. Duplicates are allowed and indexing starts at zero.

```dart
final fruits = <String>['Apple', 'Banana', 'Mango'];

print(fruits[0]); // Apple
fruits.add('Orange');
fruits.addAll(['Grapes', 'Watermelon']);
fruits.remove('Banana');
fruits.removeAt(0);
print(fruits.length);
```

Use `List<T>` when order matters, such as messages, products, or UI items.

## Iterating over a list

```dart
for (final fruit in fruits) {
  print(fruit);
}

fruits.forEach((fruit) => print(fruit));
```

The `for-in` form is usually the clearest choice when there is more than one statement in the loop body.

## Set

A `Set` stores unique values. Adding a value already present has no effect.

```dart
final numbers = <int>{1, 2, 2, 3, 3, 3};
numbers.add(4);

print(numbers); // {1, 2, 3, 4}
```

Use a set for selected IDs, tags, or any data where duplicates are invalid. Do not rely on a set for a particular display order unless you deliberately choose an ordered implementation.

## Map

A `Map` stores values by key.

```dart
final user = <String, dynamic>{
  'name': 'Nayeem',
  'age': 21,
  'country': 'Bangladesh',
};

print(user['name']);
user['email'] = 'nayeem@example.com';
user.remove('age');
```

`user['name']` has a nullable result because the key may not exist. Maps commonly represent decoded JSON before it is converted into typed model classes.

## Transforming collections

`where` filters values. `map` transforms each value. Both return an `Iterable`, which can be converted to a list with `.toList()`.

```dart
final numbers = [1, 2, 3, 4, 5, 6];

final evenNumbers = numbers.where((number) => number.isEven).toList();
final doubled = numbers.map((number) => number * 2).toList();

print(evenNumbers); // [2, 4, 6]
print(doubled); // [2, 4, 6, 8, 10, 12]
```

Other useful members are `first`, `last`, `length`, `contains`, and `isEmpty`.

## Key takeaways

| Type | Best for | Duplicates |
| --- | --- | --- |
| `List<T>` | Ordered items | Allowed |
| `Set<T>` | Unique items | Removed |
| `Map<K, V>` | Values looked up by key | Keys are unique |

## Practice

1. Create a list of five programming languages and add, remove, and print its items.
2. Create a set from `10, 20, 20, 30, 30, 30, 40` and explain the result.
3. Create a user map, update its age, add a country, and remove its email.
4. Filter numbers greater than 10, then double them.
