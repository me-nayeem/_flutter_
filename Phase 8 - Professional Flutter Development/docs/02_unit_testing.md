# Phase 8 — Professional Flutter Development

## Topic 2: Unit Testing

A **unit test** tests one small piece of logic independently from the rest of the application.

The goal is to verify **behavior**, not implementation details.

---

## 1. Testing Functions

For a simple function:

```dart
int add(int a, int b) => a + b;
```

Test its expected behavior:

```dart
test('adds two numbers', () {
  final result = add(2, 3);

  expect(result, 5);
});
```

Think:

```text
Input → Function → Expected Output
```

Test important cases such as:

* Normal input
* Boundary values
* Invalid input
* Expected errors

---

## 2. Testing Classes

A class can be tested by creating an instance and checking its public behavior.

```dart
class Counter {
  int value = 0;

  void increment() {
    value++;
  }
}
```

```dart
test('increments counter', () {
  final counter = Counter();

  counter.increment();

  expect(counter.value, 1);
});
```

Focus on **what the class does**, not how it internally does it.

---

## 3. Testing Business Logic

Business logic is especially important to unit test because it should ideally be independent of the UI.

Example:

```text
User Input
    ↓
Business Logic
    ↓
Result
```

You should be able to test:

```text
"10% discount"
    ↓
calculateDiscount()
    ↓
Expected price
```

without launching a Flutter screen.

This is one reason good architecture separates UI from application logic.

---

## 4. Testing Repositories

Repositories contain data-access logic and act as an abstraction over data sources.

Instead of testing against a real API/database every time, use a **fake or mock dependency**.

```text
ViewModel
   ↓
Repository
   ↓
Fake Data Source
```

For example, you can test:

```text
getNotes()
   ↓
Repository
   ↓
Expected notes returned
```

without depending on a real server.

This makes tests:

* Faster
* Predictable
* Independent of network availability

---

## 5. Testing State-Management Logic

State-management logic should also be testable independently of widgets.

For example:

```text
User taps "Add"
        ↓
State Logic
        ↓
State changes
```

A unit test can verify:

```text
Initial state
    ↓
Action
    ↓
Expected state
```

Example:

```dart
test('increments counter state', () {
  final counter = CounterNotifier();

  counter.increment();

  expect(counter.state, 1);
});
```

The exact code depends on your state-management solution, but the principle remains the same.

---

## 🧠 The Core Pattern

Most unit tests follow:

```text
Arrange
   ↓
Act
   ↓
Assert
```

And the architecture should allow:

```text
┌───────────────┐
│ Business Logic│ ← Unit test
└───────┬───────┘
        ↓
┌───────────────┐
│ Repository    │ ← Unit test
└───────┬───────┘
        ↓
┌───────────────┐
│ Fake / Mock   │
└───────────────┘
```

### Professional rule

**If important logic can only be tested by launching the entire application, the code is probably too tightly coupled.**

Unit testing is therefore closely connected to the architecture principles you learned earlier: **separation of concerns + dependency injection → easier testing**.
