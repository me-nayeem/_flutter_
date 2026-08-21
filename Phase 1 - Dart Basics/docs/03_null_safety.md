# Null Safety

Sound null safety prevents a variable from holding `null` unless its type explicitly allows it. It helps Dart find missing-value errors before the app runs.

## Non-nullable and nullable values

```dart
String name = 'Nayeem';
int age = 21;

String? nickname;
int? birthYear;
```

`name` and `age` must always contain values. The `?` in `String?` and `int?` means the value may also be `null`.

## Check before use

```dart
void printAge(int? age) {
  if (age == null) {
    print('Age is not provided.');
    return;
  }

  print('Age is $age.');
}
```

After the null check, Dart promotes `age` to `int` in the remaining code.

## Null-aware access: `?.`

Use `?.` to access a member only when the receiver is not null.

```dart
String? name;
print(name?.length); // null

name = 'Nayeem';
print(name?.length); // 6
```

## Fallback values: `??`

Use `??` to choose a value when the left side is `null`.

```dart
String? username;
final displayName = username ?? 'Guest';
print(displayName);
```

## Assign only when null: `??=`

```dart
String? country;
country ??= 'Bangladesh';
print(country); // Bangladesh
```

If `country` already has a value, `??=` leaves it unchanged.

## The non-null assertion: `!`

`!` tells Dart that a nullable expression is definitely not null.

```dart
String? name = 'Nayeem';
print(name!.length); // 6
```

It throws at runtime if that promise is wrong. Prefer a null check, `?.`, or `??` whenever possible.

## Flutter connection

Data from APIs, forms, and device services may be absent. A safe display fallback is common:

```dart
Text(username ?? 'Unknown user')
```

## Key takeaways

- `T` cannot be null; `T?` can be null.
- `?.` safely accesses a member.
- `??` supplies a fallback; `??=` supplies a fallback assignment.
- Use `!` only when the value is proven non-null.

## Practice

1. Print a nullable user's name with `Guest` as the fallback.
2. Write a function that safely prints the length of a nullable string.
3. Explain why `name!.length` is riskier than `name?.length`.
