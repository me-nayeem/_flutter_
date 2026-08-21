# MaterialApp

`MaterialApp` is the usual root widget for an application that follows Material Design. It supplies application-wide capabilities such as theming, navigation, localization, and a default text direction.

## Learning Goals

- Place `MaterialApp` at the root of a basic Flutter app.
- Use `home`, `title`, and `theme`.
- Understand the difference between application configuration and a screen layout.

## The Basic Pattern

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: const HomeScreen(),
    );
  }
}
```

The widget tree begins like this:

```text
main()
`- runApp()
   `- MaterialApp
      `- HomeScreen
```

## Important Properties

| Property | Purpose |
| --- | --- |
| `home` | The first screen shown when the app starts. |
| `title` | A label used by the operating system, such as in task switching. |
| `theme` | Default Material colors, typography, and component styling. |
| `routes` | Named routes for navigation. |
| `debugShowCheckedModeBanner` | Controls the debug banner during development. |

## `home` Is a Widget

The `home` property receives a widget, usually a full screen that contains a `Scaffold`.

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Welcome!')),
    );
  }
}
```

`MaterialApp` configures the app. `HomeScreen` describes one screen. This separation stays useful as the app gains more pages.

## App-Wide Theme

Define shared visual decisions once instead of styling each widget separately.

```dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    useMaterial3: true,
  ),
  home: const HomeScreen(),
)
```

Widgets lower in the tree can read the theme with `Theme.of(context)`.

## MaterialApp and Other Root Widgets

`MaterialApp` is appropriate for a Material Design app. Flutter also provides `CupertinoApp` for iOS-style applications and lower-level options such as `WidgetsApp`.

For this learning path, use `MaterialApp` unless there is a specific design reason not to.

## Common Mistakes

- **Using `Text` directly as `home`:** it may render, but a screen normally needs `Scaffold` to provide Material layout and styling.
- **Creating multiple `MaterialApp` widgets:** use one at the app root; nested apps can create unexpected navigation and theme behavior.
- **Putting screen-specific state in `MaterialApp`:** keep app configuration at the root and page behavior in the relevant screen.

## Key Takeaways

- `runApp` mounts the root widget tree.
- `MaterialApp` configures a Material Design application.
- `home` identifies the first screen.
- `Scaffold` is normally placed below `MaterialApp` to structure a screen.

## Practice

1. Set the app title to your project name.
2. Disable the debug banner.
3. Choose a `colorSchemeSeed` and observe how the `AppBar` changes.

## Further Reading

- [MaterialApp API reference](https://api.flutter.dev/flutter/material/MaterialApp-class.html)
