# Flutter Project Structure

A Flutter project combines Dart application code, platform-specific projects, configuration, and tests. You will spend most of your time in `lib/`, but knowing where everything belongs prevents confusion as an app grows.

## Learning Goals

- Recognize the important files and folders in a Flutter project.
- Understand where application code, packages, assets, tests, and native settings belong.
- Start with a simple structure without over-organizing too early.

## Create and Run an App

```bash
flutter create my_app
cd my_app
flutter run
```

`flutter create` generates a complete project. `flutter run` builds the app and starts it on a connected device, emulator, or browser.

## Project Map

```text
my_app/
|- android/                 Android project and native configuration
|- ios/                     iOS project and native configuration
|- lib/                     Dart and Flutter application code
|  `- main.dart             Application entry point
|- test/                    Automated tests
|- web/                     Web runner and configuration
|- pubspec.yaml             Project metadata, packages, assets
|- pubspec.lock             Resolved package versions
`- analysis_options.yaml    Dart analyzer and lint rules
```

Desktop folders such as `windows/`, `macos/`, and `linux/` appear when those platforms are enabled.

## The Files You Need First

| Location | Purpose | Beginner focus |
| --- | --- | --- |
| `lib/` | Application source code | High |
| `lib/main.dart` | Starts the application | High |
| `pubspec.yaml` | Packages, assets, app metadata | High |
| `test/` | Automated tests | Later |
| `android/`, `ios/` | Native platform configuration | Later |

## `lib/main.dart`: The Entry Point

Every Flutter app begins by executing `main()`. `runApp` receives the root widget of the application.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Hello, Flutter!')),
      ),
    );
  }
}
```

The next lessons explain `MaterialApp`, `Scaffold`, and widgets in detail.

## `pubspec.yaml`: Project Configuration

`pubspec.yaml` defines the app's name, SDK constraints, dependencies, and assets.

```yaml
name: my_app

dependencies:
  flutter:
    sdk: flutter

flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

After changing dependencies, run `flutter pub get`. Assets must be declared here before `Image.asset` can load them.

## A Practical `lib/` Layout

Start small. Create folders only when the code needs them.

```text
lib/
|- main.dart
|- screens/
|- widgets/
|- models/
`- services/
```

- `screens/`: full pages, such as `home_screen.dart`.
- `widgets/`: reusable UI pieces, such as `profile_header.dart`.
- `models/`: typed data, such as `user.dart`.
- `services/`: external work, such as an API client.

> Do not copy a complex architecture into a small learning project. A clear `main.dart` is enough until the project gives you a reason to split it.

## Platform Folders

Flutter shares UI and business logic from `lib/`, while each platform folder contains the launcher, build configuration, and native integration needed for that target.

```text
lib/       Flutter and Dart code
android/   Android-specific project
ios/       iOS-specific project
web/       Web-specific runner
```

You normally edit these folders only for platform setup, permissions, signing, or native integrations.

## Key Takeaways

- `lib/` contains your Flutter application.
- `main.dart` is the usual entry point.
- `pubspec.yaml` manages packages and assets.
- Keep the initial folder structure simple and evolve it with the app.

## Practice

1. Create a new Flutter application and run it on a device or browser.
2. Locate `lib/main.dart`, `pubspec.yaml`, `test/`, `android/`, and `ios/`.
3. Add an `assets/images/` folder and declare it in `pubspec.yaml`.

## Further Reading

- [Flutter: Create an app](https://docs.flutter.dev/learn/pathway/tutorial/create-an-app)
- [Flutter architecture guide](https://docs.flutter.dev/app-architecture/guide)
