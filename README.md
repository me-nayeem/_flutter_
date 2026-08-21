# Flutter Learning Path

A structured roadmap for learning Dart, Flutter, app architecture, and professional mobile development. Work through the phases in order, build the suggested projects, and use the official documentation alongside the notes in this repository.

## Official Resources

- [Flutter documentation](https://docs.flutter.dev/)
- [Flutter app architecture guide](https://docs.flutter.dev/app-architecture)
- [Android Developers](https://developer.android.com/)
- [Android architecture guide](https://developer.android.com/topic/architecture/intro)

## Roadmap

### Phase 1: Dart Basics

Build a solid Dart foundation before starting Flutter widgets. The lessons currently available in this repository are listed in the intended learning order.

| Lesson | Topic |
| --- | --- |
| 01 | [Functions](Phase%201%20-%20Dart%20Basics/docs/01_functions.md) |
| 02 | [Collections: Lists, Sets, and Maps](Phase%201%20-%20Dart%20Basics/docs/02_collections.md) |
| 03 | [Null Safety](Phase%201%20-%20Dart%20Basics/docs/03_null_safety.md) |
| 04 | [Classes and Objects](Phase%201%20-%20Dart%20Basics/docs/04_classes_and_objects.md) |
| 05 | [Constructors](Phase%201%20-%20Dart%20Basics/docs/05_constructors.md) |
| 06 | [Inheritance, Interfaces, and Mixins](Phase%201%20-%20Dart%20Basics/docs/06_inheritance_interfaces_mixins.md) |
| 07 | [Exceptions](Phase%201%20-%20Dart%20Basics/docs/07_exceptions.md) |
| 08 | [Generics](Phase%201%20-%20Dart%20Basics/docs/08_generics.md) |
| 09 | [Future](Phase%201%20-%20Dart%20Basics/docs/09_future.md) |
| 10 | [Async and Await](Phase%201%20-%20Dart%20Basics/docs/10_async_await.md) |

**Practice project:** Build a console-based expense tracker or quiz application.

### Phase 2: Flutter Fundamentals

Learn how Flutter applications are structured and how to compose responsive interfaces.

1. Flutter project structure
2. `MaterialApp` and `Scaffold`
3. Widgets and the widget tree
4. Stateless and stateful widgets
5. `BuildContext`
6. Core UI widgets: text, images, icons, containers, padding
7. Layout: rows, columns, stacks, expanded, and flexible
8. Scrollable UI: `ListView` and `GridView`
9. Buttons, gestures, text fields, and forms
10. Reusable custom widgets

**Practice projects:** Profile UI, login screen, calculator, and to-do application.

### Phase 3: Building Complete Apps

Learn the application features needed to move beyond individual screens.

1. Navigation and routes
2. Passing data between screens
3. State and `setState`
4. Form validation
5. Assets and themes
6. Responsive and adaptive UI
7. Debugging

**Practice project:** Notes application.

### Phase 4: Data and APIs

Learn how apps fetch, model, store, and display real data.

1. HTTP and REST APIs
2. JSON and serialization
3. Model classes
4. Loading, empty, and error states
5. Repository concepts
6. Local persistence
7. Authentication

**Practice project:** Weather, news, or movie application using a real API.

### Phase 5: State Management

Start with `setState` to understand local UI state. Then choose one state-management approach, such as Riverpod or BLoC, and learn it well before trying others.

### Phase 6: Architecture

Use the official Flutter and Android architecture guidance to understand why larger apps are structured in layers.

1. UI, data, and domain layers
2. View models and state holders
3. Repositories and services
4. Dependency injection
5. Unidirectional data flow
6. Separation of concerns and testability

**Practice project:** Rebuild a previous app using a clear architecture.

### Phase 7: Advanced Flutter

After you can build complete apps, explore animations, `CustomPainter`, streams, isolates, performance, accessibility, localization, deep links, platform integration, and notifications.

### Phase 8: Professional Development

Finish by learning unit, widget, and integration testing; Git and GitHub; environment configuration; build flavors; CI/CD; app signing; store deployment; and crash reporting.

**Final project:** Build, test, deploy, and maintain a production-style Flutter application.

## Study Approach

Read a lesson, write the examples yourself, complete the practice work, then apply the concept in a small project. Focus on understanding the reason behind each pattern instead of copying code without modification.

Avoid spreading your attention too early across multiple state-management libraries, advanced animations, native platform code, CI/CD, or complex architecture. Build strong Dart and Flutter fundamentals first.
