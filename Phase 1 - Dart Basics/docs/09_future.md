# Future

A `Future<T>` represents an asynchronous operation that will complete later with a value of type `T`, or with an error.

## Why Futures exist

Some work takes time: requesting a server, reading a file, or querying a database. The result is not available immediately, so the function returns a `Future` that represents the pending work.

```dart
Future<String> getName() {
  return Future.value('Nayeem');
}

final result = getName();
// result has type Future<String>, not String.
```

## Delayed completion

`Future.delayed` is useful for demonstration and timed work.

```dart
Future<String> getName() {
  return Future.delayed(
    const Duration(seconds: 2),
    () => 'Nayeem',
  );
}
```

Calling `getName()` starts work and immediately returns a future. It does not synchronously wait for two seconds.

## Futures with and without values

```dart
Future<int> getAge() => Future.value(21);

Future<void> saveData() {
  return Future.delayed(
    const Duration(seconds: 1),
    () => print('Data saved.'),
  );
}
```

`Future<void>` completes later but does not provide a useful result value.

## Futures and generics

`Future<T>` is a generic type. The type argument describes the eventual result.

```dart
Future<String>
Future<int>
Future<bool>
Future<List<String>>
Future<List<User>>
```

For example, `Future<List<User>>` means a list of `User` objects will be available later.

## Getting the result

The next lesson covers `async` and `await`, the clearest way to obtain a future's completed value:

```dart
final name = await getName();
```

After `await`, `name` is a `String`.

## Key takeaways

- A future is a pending result, not the final value itself.
- `Future<T>` completes with a `T`; `Future<void>` has no result value.
- Futures can complete with errors as well as values.
- Use `async` and `await` to consume futures clearly.

## Practice

1. What is the type of `result` in `final result = getAge();`?
2. Create a `Future<String>` that completes after one second.
3. Explain `Future<List<Product>>` in plain English.
