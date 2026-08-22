<!-- # Flutter Learning Path

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

Avoid spreading your attention too early across multiple state-management libraries, advanced animations, native platform code, CI/CD, or complex architecture. Build strong Dart and Flutter fundamentals first. -->




# Flutter Learning Path

> A structured, project-driven roadmap for mastering **Dart, Flutter, application architecture, state management, testing, and professional mobile development**.

The goal of this roadmap is not simply to learn Flutter syntax.

The goal is to become capable of:

- Understanding how Flutter works
- Designing Flutter applications
- Building complete applications independently
- Managing application state
- Working with APIs and local data
- Structuring large applications
- Debugging and optimizing applications
- Testing applications
- Deploying production-ready applications
- Explaining the technical decisions behind your code

---

# 📚 How to Use This Roadmap

Follow the phases **in order**.

Each phase builds knowledge required by the next phase.

For every topic:

1. Understand the concept
2. Study practical examples
3. Write the examples yourself
4. Experiment with the code
5. Solve small exercises
6. Build a small feature
7. Apply the concept in a project
8. Review and explain the concept in your own words

> **Do not measure progress by how many topics you have finished. Measure progress by what you can build without following a tutorial.**

---

# 🗺️ Roadmap Overview

| Phase | Focus | Main Goal |
| --- | --- | --- |
| Phase 1 | Dart Fundamentals | Build a strong Dart foundation |
| Phase 2 | Flutter Fundamentals | Understand Flutter's UI and widget system |
| Phase 3 | Building Complete Apps | Build multi-screen Flutter applications |
| Phase 4 | Data & APIs | Work with real-world data and backend services |
| Phase 5 | State Management | Manage application state properly |
| Phase 6 | Architecture | Structure applications for scalability and maintainability |
| Phase 7 | Advanced Flutter | Master advanced Flutter capabilities |
| Phase 8 | Professional Development | Test, deploy, monitor, and maintain production apps |

---

# 🟢 Phase 1 — Dart Fundamentals

Before learning Flutter, build a strong understanding of Dart.

The goal is not to become a Dart expert first.

The goal is to understand the Dart features that Flutter relies on heavily.

---

## 1. Variables and Data Types

Learn:

- `var`
- Explicit types
- `dynamic`
- `String`
- `int`
- `double`
- `bool`
- Type inference

---

## 2. `final` and `const`

Understand:

- `final`
- `const`
- Compile-time constants
- Runtime values
- Immutability basics

---

## 3. Operators

Learn:

- Arithmetic operators
- Comparison operators
- Logical operators
- Assignment operators
- Null-aware operators
- Conditional expressions

---

## 4. Conditions

Learn:

- `if`
- `else`
- `else if`
- `switch`
- Switch expressions
- Pattern matching basics

---

## 5. Loops

Learn:

- `for`
- `for-in`
- `while`
- `do-while`
- `break`
- `continue`

---

## 6. Functions

Learn:

- Function declaration
- Parameters
- Return values
- Optional parameters
- Named parameters
- Default values
- Arrow functions
- Anonymous functions
- Higher-order functions

---

## 7. Collections

Learn:

- `List`
- `Set`
- `Map`
- Collection methods
- `map()`
- `where()`
- `reduce()`
- `forEach()`
- Spread operators
- Collection `if` / `for`

---

## 8. Null Safety

Learn:

- Nullable types
- Non-nullable types
- `?`
- `!`
- `late`
- Null-aware operators
- Null-aware method calls
- Null-aware assignment
- Null safety best practices

---

## 9. Classes and Objects

Learn:

- Classes
- Objects
- Fields
- Methods
- Instance members
- Static members
- Encapsulation

---

## 10. Constructors

Learn:

- Default constructors
- Named constructors
- Named parameters
- `required`
- Initializer lists
- `const` constructors
- Factory constructors

---

## 11. Inheritance, Interfaces, and Mixins

Learn:

- `extends`
- `implements`
- `with`
- Abstract classes
- Method overriding
- Mixins
- Polymorphism

---

## 12. Exceptions

Learn:

- `try`
- `catch`
- `on`
- `finally`
- `throw`
- Custom exceptions
- Error handling principles

---

## 13. Generics

Learn:

- Generic classes
- Generic functions
- Type parameters
- Why generics matter
- Generic collections

---

## 14. `Future`

Understand:

- Asynchronous operations
- `Future<T>`
- Future states
- Returning futures

---

## 15. `async` / `await`

Learn:

- `async`
- `await`
- Sequential asynchronous operations
- Error handling with async code
- Common async mistakes

---

### 🧪 Phase 1 Project

Build one of:

- Console Expense Tracker
- Console Quiz Application

### 🎯 Phase 1 Goal

Before moving forward, you should be comfortable reading and writing normal Dart code without constantly looking up basic syntax.

---

# 🟢 Phase 2 — Flutter Fundamentals

Now begin Flutter.

The goal of this phase is to understand:

- Flutter project structure
- Widgets
- Widget trees
- Layout
- Basic interaction
- Reusable UI components

---

## 1. Flutter Project Structure

Learn:

- Flutter project structure
- `lib/`
- `main.dart`
- `pubspec.yaml`
- `assets/`
- `android/`
- `ios/`
- `test/`
- Entry point
- `runApp()`

---

## 2. `MaterialApp`

Learn:

- `MaterialApp`
- App-level configuration
- `home`
- `theme`
- `routes`
- `debugShowCheckedModeBanner`

---

## 3. `Scaffold`

Learn:

- `Scaffold`
- `AppBar`
- `body`
- `floatingActionButton`
- `drawer`
- `bottomNavigationBar`
- `SnackBar`

---

## 4. Widgets and the Widget Tree

Understand:

- What a widget is
- Widget composition
- Parent-child relationships
- Widget tree
- Declarative UI
- Why Flutter is widget-based

---

## 5. Stateless vs Stateful Widgets

Learn:

- `StatelessWidget`
- `StatefulWidget`
- `State`
- `build()`
- `setState()`
- When state belongs inside a widget

---

## 6. `BuildContext`

Understand:

- What `BuildContext` represents
- Context and widget location
- Accessing inherited information
- `Theme.of(context)`
- `MediaQuery`
- Navigation using context
- Common `BuildContext` mistakes

---

## 7. Core UI Widgets

Learn:

- `Text`
- `Image`
- `Icon`
- `CircleAvatar`
- Basic styling
- `TextStyle`
- Image assets
- Network images

---

## 8. `Container`

Learn:

- Width
- Height
- Color
- Alignment
- Padding
- Margin
- Decoration
- Border
- Border radius
- Box shadow
- Constraints
- Container vs simpler alternatives

---

## 9. Padding and Margin

Learn:

- `Padding`
- `EdgeInsets`
- `margin`
- Padding vs margin
- `EdgeInsets.all()`
- `EdgeInsets.symmetric()`
- `EdgeInsets.only()`
- `EdgeInsets.fromLTRB()`

---

## 10. `Row` and `Column`

Learn:

- Main axis
- Cross axis
- `mainAxisAlignment`
- `crossAxisAlignment`
- `mainAxisSize`
- Spacing
- Nested layouts

---

## 11. `Expanded` and `Flexible`

Learn:

- Why overflow happens
- `Expanded`
- `Flexible`
- Flex factor
- `Flex`
- Row/Column constraints
- Common `RenderFlex` errors

---

## 12. `Stack`

Learn:

- Layered layouts
- `Stack`
- `Positioned`
- Alignment
- Overlay UI
- Badge patterns

---

## 13. `ListView`

Learn:

- Scrollable lists
- `ListView`
- `ListView.builder`
- `ListView.separated`
- Lazy item creation
- List item design

---

## 14. `GridView`

Learn:

- Grid layouts
- `GridView.count`
- `GridView.builder`
- `SliverGridDelegate`
- Responsive grid basics

---

## 15. Buttons

Learn:

- `ElevatedButton`
- `FilledButton`
- `OutlinedButton`
- `TextButton`
- `IconButton`
- Button styling
- Callbacks

---

## 16. Text Fields

Learn:

- `TextField`
- `TextEditingController`
- `FocusNode`
- Input types
- Keyboard configuration
- Reading input
- Managing controllers

---

## 17. Forms

Learn:

- `Form`
- `GlobalKey<FormState>`
- `TextFormField`
- Validation
- `validator`
- `save()`
- `reset()`

---

## 18. Gestures

Learn:

- `GestureDetector`
- `onTap`
- `onDoubleTap`
- `onLongPress`
- Drag gestures
- Pan gestures
- `InkWell`
- Gesture detection basics
- Hit testing basics

---

## 19. Custom Widgets

Learn:

- Creating reusable widgets
- Widget composition
- Passing data through constructors
- Callbacks
- Parent → child communication
- Child → parent communication
- Stateless custom widgets
- Stateful custom widgets
- Widget responsibility

---

### 🧪 Phase 2 Projects

Build:

1. Profile UI
2. Login Screen
3. Calculator
4. To-Do Application

### 🎯 Phase 2 Goal

You should be able to create a multi-section UI from scratch without following a tutorial line by line.

You should also understand **why each widget is being used**, not just know its syntax.

---

# 🟢 Phase 3 — Building Complete Apps

Now move from individual widgets to complete applications.

The goal is to learn how multiple screens and features work together.

---

## 1. Navigation Fundamentals

Learn:

- Navigation concept
- `Navigator`
- `push`
- `pop`
- `pushReplacement`
- Navigation stack
- Back navigation

---

## 2. Routes

Learn:

- Named routes
- Route configuration
- Route arguments
- Route management
- Modern navigation concepts

---

## 3. Passing Data Between Screens

Learn:

- Passing primitive values
- Passing objects
- Returning values from screens
- Receiving results from routes

---

## 4. State with `setState`

Deepen your understanding of:

- Local state
- State ownership
- Rebuilding widgets
- Lifting state
- Immutable configuration vs mutable state

---

## 5. Forms and Validation

Go beyond basic forms:

- Multiple fields
- Validation strategy
- Submission state
- Loading state
- Error state
- Form UX

---

## 6. Assets

Learn:

- Asset configuration
- Images
- Fonts
- Asset organization
- `pubspec.yaml`

---

## 7. Themes

Learn:

- `ThemeData`
- Color schemes
- Typography
- Light theme
- Dark theme
- Theme consistency
- Custom reusable styles

---

## 8. Responsive and Adaptive UI

Learn:

- Logical pixels
- Screen sizes
- `MediaQuery`
- `LayoutBuilder`
- Breakpoints
- Orientation
- Responsive layouts
- Adaptive UI
- Phone vs tablet considerations

---

## 9. Debugging

Learn:

- Reading Flutter error messages
- Debug console
- Flutter Inspector
- Breakpoints
- Debugger
- Layout debugging
- Common Flutter exceptions

---

### 🧪 Phase 3 Project

Build a complete:

> **Notes Application**

It should include:

- Multiple screens
- Navigation
- Forms
- Validation
- Local state
- Themes
- Responsive UI
- Proper error handling

### 🎯 Phase 3 Milestone

> **You should now be able to build a small Flutter application without following a step-by-step tutorial.**

---

# 🟢 Phase 4 — Data, APIs, and Persistence

Now connect your application to the outside world.

The goal is to understand how real applications:

- communicate with servers
- receive data
- convert data into Dart objects
- handle failures
- store data locally
- authenticate users

---

## 1. HTTP Fundamentals

Learn:

- HTTP
- Request
- Response
- Headers
- Status codes
- GET
- POST
- PUT/PATCH
- DELETE

---

## 2. REST APIs

Learn:

- REST concepts
- Endpoints
- Query parameters
- Path parameters
- Request bodies
- API responses

---

## 3. JSON

Learn:

- JSON structure
- Objects
- Arrays
- Nested JSON
- Parsing JSON
- Encoding JSON

---

## 4. Serialization and Deserialization

Learn:

```text
JSON → Dart Object
Dart Object → JSON