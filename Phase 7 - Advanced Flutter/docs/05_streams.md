# Phase 7 — Advanced Flutter

## Topic 5: Streams

> **Core idea:** A `Stream` represents a sequence of asynchronous values that arrive **over time**.

Unlike a `Future`, which normally gives you **one result**, a `Stream` can give you **many results**.

```text
Future:
Request ─────────► Result

Stream:
Event ──► Event ──► Event ──► Event ──► ...
```

---

## 1. `Stream`

Example:

```dart
Stream<int> numbers() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}
```

Listening:

```dart
numbers().listen((number) {
  print(number);
});
```

Output arrives over time:

```text
1
2
3
4
5
```

### `Future` vs `Stream`

| Future             | Stream                      |
| ------------------ | --------------------------- |
| One result         | Multiple results            |
| One-time operation | Continuous/recurring events |
| `await`            | `listen` / `await for`      |

---

## 2. Stream Subscription

When you call:

```dart
final subscription = stream.listen((value) {
  print(value);
});
```

you get a `StreamSubscription`.

It allows you to control the listener:

```dart
subscription.pause();
subscription.resume();
subscription.cancel();
```

**Important:** Cancel subscriptions when they're no longer needed, especially when a widget is disposed.

```dart
@override
void dispose() {
  subscription.cancel();
  super.dispose();
}
```

---

## 3. Stream Transformations

You can transform values as they flow through a stream.

```dart
stream
    .where((value) => value > 10)
    .map((value) => value * 2)
    .listen(print);
```

Think:

```text
Original values
      ↓
   where()
      ↓
    map()
      ↓
 Transformed values
```

Common transformations:

* `map()`
* `where()`
* `take()`
* `skip()`
* `distinct()`
* `asyncMap()`

---

## 4. Broadcast Streams

A normal stream is generally designed for **one listener**.

A broadcast stream can have **multiple listeners**:

```text
                 Stream
              ↙    ↓    ↘
          Listener Listener Listener
```

Create one with:

```dart
final broadcast = stream.asBroadcastStream();
```

Useful when multiple parts of an application need to observe the same events.

---

## 5. Stream Lifecycle

A stream can have three important states:

```text
Data events
    ↓
more data
    ↓
more data
    ↓
Done
```

It can also produce an error:

```text
Stream
 ├── data
 ├── data
 ├── error
 └── done
```

You can handle errors and completion:

```dart
stream.listen(
  (data) => print(data),
  onError: (error) => print(error),
  onDone: () => print('Finished'),
);
```

---

## 6. Real-Time Data

Streams are especially useful when data changes continuously.

Examples:

* Chat messages
* Firebase updates
* Location updates
* Sensor data
* WebSocket messages
* Live notifications

Mental model:

```text
Server / Device
      │
      │ events over time
      ▼
    Stream
      │
      ▼
     UI
      │
      ▼
updates automatically
```

---

## 🧠 Key Mental Model

Remember:

> **Future = "Give me the result when it's ready."**
>
> **Stream = "Keep giving me results whenever they arrive."**

And for a Stream:

```text
Stream
  ↓
listen()
  ↓
StreamSubscription
  ↓
data / error / done
```

For Flutter, **`StreamBuilder`** is especially important because it lets a widget rebuild itself as stream data changes. We'll use this concept when working with real-time UI.
