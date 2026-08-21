# Exceptions

Exceptions represent failures that occur while a program runs. Handle expected failures deliberately so the app can recover or show a useful message.

## `try`, `catch`, and `finally`

Put code that can fail in `try`. Use `catch` to handle the error and `finally` for cleanup that must run either way.

```dart
try {
  final result = 10 ~/ 0;
  print(result);
} catch (error) {
  print('Something went wrong: $error');
} finally {
  print('Finished.');
}
```

`~/` is integer division. Dividing by zero throws an exception, so `Finished.` still prints after the error is handled.

## Catch a specific exception

Use `on` when the recovery action depends on the exception type.

```dart
try {
  final result = 10 ~/ 0;
  print(result);
} on IntegerDivisionByZeroException {
  print('You cannot divide by zero.');
}
```

You can combine `on` with `catch` if you also need the error object.

```dart
try {
  // Code that may fail.
} on FormatException catch (error) {
  print('Invalid input: $error');
}
```

## Throw an exception

Use `throw` to reject invalid state or input that the current code cannot handle.

```dart
void checkAge(int age) {
  if (age < 18) {
    throw ArgumentError.value(age, 'age', 'Must be 18 or older.');
  }
}
```

Callers can catch that error where they can make a decision about it.

## Custom exceptions

For a domain-specific failure, create a small exception class.

```dart
class InvalidAgeException implements Exception {
  final String message;

  InvalidAgeException(this.message);

  @override
  String toString() => 'InvalidAgeException: $message';
}
```

Custom exceptions are useful when callers need to distinguish a business-rule failure from a technical failure.

## Flutter connection

Network requests, local storage, parsing, and authentication can fail. Catch an error at the appropriate UI or state-management boundary, then show a meaningful error state instead of allowing an unhandled exception.

## Key takeaways

- `try` contains code that may fail.
- `catch` handles an error; `on` narrows handling to a specific type.
- `finally` always runs.
- Throw only when the current code cannot validly continue.

## Practice

1. Predict the output of a failing division inside `try`, `catch`, and `finally`.
2. Write `parseAge(String value)` that handles invalid numeric input.
3. Create and throw a custom exception for an empty product name.
