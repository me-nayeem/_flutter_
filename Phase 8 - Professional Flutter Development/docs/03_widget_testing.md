# Phase 8 — Professional Flutter Development

## Topic 3: Widget Testing

A **widget test** tests a Flutter widget in a controlled environment.

Unlike a unit test, it can verify both **UI and interaction**.

```text
Unit Test
Logic → Result

Widget Test
Widget → User Action → UI/State Change
```

---

## 1. Widget Rendering

You can verify that a widget appears correctly.

```dart
testWidgets('shows welcome message', (tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: Text('Welcome'),
    ),
  );

  expect(find.text('Welcome'), findsOneWidget);
});
```

Important tools:

* `pumpWidget()` → builds the widget under test
* `find` → locates widgets
* `expect()` → verifies the result

---

## 2. User Interaction

Widget tests can simulate user actions.

For example:

```dart
await tester.tap(find.text('Add'));
await tester.pump();
```

Common interactions:

```text
tap()
enterText()
drag()
scroll()
longPress()
```

Then verify the expected result:

```dart
expect(find.text('Added'), findsOneWidget);
```

---

## 3. UI State

You can test how the UI changes when its state changes.

Example:

```text
Initial State
     ↓
User taps button
     ↓
State changes
     ↓
Widget rebuilds
     ↓
New UI appears
```

A good widget test verifies the **observable result**, rather than checking internal implementation details.

---

## 4. Validation

Forms are a common use case.

For example:

```text
Empty email
   ↓
Tap Submit
   ↓
Validation runs
   ↓
"Email is required"
```

A widget test can simulate this:

```dart
await tester.tap(find.text('Submit'));
await tester.pump();

expect(find.text('Email is required'), findsOneWidget);
```

You can also test valid input and confirm that the validation message disappears or submission proceeds.

---

## 5. Widget Behavior

Test important behaviors of your widgets:

```text
Button → performs action
Form → validates input
Checkbox → changes state
List → displays items
Loading → shows progress indicator
Error → shows error state
```

The important question is:

> **"When the user does X, does the UI behave as expected?"**

---

## 🧠 Mental Model

```text
Build Widget
     ↓
Find Widget
     ↓
Perform Action
     ↓
pump()
     ↓
Verify UI
```

Example:

```dart
testWidgets('counter increments', (tester) async {
  await tester.pumpWidget(const MyApp());

  expect(find.text('0'), findsOneWidget);

  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();

  expect(find.text('1'), findsOneWidget);
});
```

### Key distinction

| Test                 | Main purpose                                    |
| -------------------- | ----------------------------------------------- |
| **Unit test**        | Logic in isolation                              |
| **Widget test**      | Widget + UI behavior                            |
| **Integration test** | Multiple parts of the real app working together |

**Professional rule:** Test what the user can observe and interact with, not the private implementation of the widget.
