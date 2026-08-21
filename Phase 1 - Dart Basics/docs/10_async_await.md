# Async and Await

`async` and `await` make code that works with `Future` values read in a top-to-bottom style.

## Mark an asynchronous function

Add `async` to a function that uses `await` or returns an asynchronous result.

```dart
Future<String> getName() async {
  return 'Nayeem';
}
```

Even though the function returns a string expression, an `async` function returns `Future<String>`.

## Wait for a future with `await`

`await` pauses the current async function until a future completes. It does not block the Dart event loop while waiting.

```dart
Future<String> getName() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Nayeem';
}

Future<void> main() async {
  print('Getting name...');
  final name = await getName();
  print(name);
}
```

`getName()` produces a `Future<String>`; `await getName()` produces the completed `String`.

## The enclosing function must be async

`await` can only be used inside an `async` function.

```dart
Future<void> main() async {
  final name = await getName();
  print(name);
}
```

## Sequential work

Each `await` waits for the previous operation to finish.

```dart
Future<void> loadProfile() async {
  final name = await getName();
  final age = await getAge();
  print('$name is $age years old.');
}
```

This is correct when the second operation depends on the first. If independent operations should run together, use `Future.wait`.

```dart
final results = await Future.wait([getName(), getCountry()]);
```

## Error handling

Use normal `try` and `catch` around awaited work.

```dart
Future<void> loadUser() async {
  try {
    final name = await getName();
    print(name);
  } catch (error) {
    print('Could not load user: $error');
  }
}
```

## Important distinction

`async` does not automatically create another thread or isolate. It lets a function coordinate asynchronous work without blocking while it waits. CPU-heavy work needs different tools, such as isolates.

## Key takeaways

- `Future<T>` is a value available later.
- `async` marks a function that performs asynchronous work.
- `await` obtains a future's completed value inside an async function.
- Await independent futures together when they can run in parallel.

## Practice

1. Predict the output order of `print('A')`, `await getNumber()`, `print('B')`.
2. Write `Future<void> saveData()` that waits one second and prints a message.
3. Add `try` and `catch` around an awaited operation that might fail.
