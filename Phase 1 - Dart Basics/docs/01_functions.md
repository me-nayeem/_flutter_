# Functions

Functions group reusable behavior behind a name. They can accept input through parameters and optionally return a value.

## Learning goals

- Declare and call functions.
- Use positional, optional, and named parameters.
- Return values and write concise arrow functions.

## Basic function

```dart
void greet() {
  print('Hello!');
}

void main() {
  greet();
}
```

`void` means the function does not return a value.

## Parameters and return values

Parameters are inputs declared by a function. Arguments are the actual values passed when calling it.

```dart
int add(int first, int second) {
  return first + second;
}

void main() {
  final result = add(10, 20);
  print(result); // 30
}
```

The `int` before `add` is the return type. Dart checks that the function returns an integer on every path.

## Arrow functions

For a single expression, use `=>` instead of braces and `return`.

```dart
double calculateArea(double width, double height) => width * height;
```

Use arrow syntax only when it keeps the function easier to read.

## Optional positional parameters

Wrap an optional positional parameter in square brackets. Its type must be nullable or it must have a default value.

```dart
void greetUser(String name, [String message = 'Hello']) {
  print('$message, $name!');
}

greetUser('Nayeem');
greetUser('Nayeem', 'Good morning');
```

## Named parameters

Named parameters make a call self-documenting. This is the most common parameter style in Flutter.

```dart
void createUser({
  required String name,
  required int age,
  String country = 'Bangladesh',
}) {
  print('$name is $age years old and lives in $country.');
}

createUser(name: 'Nayeem', age: 21);
```

- `required` means the caller must provide the named argument.
- A named parameter without `required` needs a nullable type or a default value.

## Flutter connection

Flutter constructors use named parameters for clarity:

```dart
Container(
  width: 200,
  height: 100,
)
```

## Key takeaways

- Use explicit return types for clear APIs.
- Prefer named parameters when a function has several inputs.
- Use `final` for a local value that will not be reassigned.

## Practice

1. Write `calculateArea` that returns the area from width and height.
2. Write `greetUser` with a required `name` and an optional `age`.
3. Write an arrow function that returns whether a number is even.
