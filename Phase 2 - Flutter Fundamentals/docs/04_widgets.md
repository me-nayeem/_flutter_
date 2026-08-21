# Widgets

Flutter builds user interfaces from widgets. A widget is an immutable description of part of the interface: visible content, layout, style, interaction, navigation, or application structure.

## Learning Goals

- Understand the widget tree.
- Recognize the difference between `child` and `children`.
- Compose small widgets into complete screens.

## Flutter Is a Widget Tree

Widgets nest inside other widgets to describe a hierarchy.

```dart
MaterialApp(
  home: Scaffold(
    appBar: AppBar(title: const Text('Home')),
    body: const Center(
      child: Text('Welcome!'),
    ),
  ),
)
```

```text
MaterialApp
`- Scaffold
   |- AppBar
   |  `- Text
   `- Center
      `- Text
```

Flutter uses this structure to decide how the interface should be laid out and painted.

## Widgets Have Different Jobs

| Category | Examples | Purpose |
| --- | --- | --- |
| App structure | `MaterialApp`, `Scaffold` | Set up the app or a screen. |
| Layout | `Center`, `Column`, `Row`, `Padding` | Position and size child widgets. |
| Display | `Text`, `Image`, `Icon` | Show information. |
| Interaction | `ElevatedButton`, `TextField` | Receive user input. |
| Style | `Theme`, `DecoratedBox` | Apply visual choices. |

Many widgets serve more than one of these roles.

## One Child or Many Children

Widgets that wrap exactly one widget use `child`.

```dart
Center(
  child: Text('Hello'),
)
```

Widgets that arrange several widgets use `children`.

```dart
Column(
  children: [
    Text('Name: Nayeem'),
    Text('Country: Bangladesh'),
  ],
)
```

The `children` list can contain any widgets that make sense for that parent.

## Composition Over Drawing

You do not draw a page pixel by pixel. Instead, combine focused widgets.

```dart
const ProfileSummary(
  name: 'Nayeem',
  role: 'Flutter learner',
)
```

That custom widget can be built from lower-level widgets such as `Column`, `Text`, `Icon`, and `Padding`. This compositional approach makes UI easier to read, reuse, and change.

## Widgets Are Immutable

Widget instances do not change after they are created. When the UI needs to show new data, Flutter builds new widget descriptions and efficiently updates the underlying UI where needed.

This is why `const` is useful for widgets whose constructor arguments are compile-time constants:

```dart
const Text('Static label')
```

Use `const` where it is valid; it communicates that the configuration is fixed.

## A Small Composed UI

```dart
class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.waving_hand, size: 48),
          SizedBox(height: 12),
          Text('Welcome to Flutter'),
        ],
      ),
    );
  }
}
```

The class is a custom widget, but it is still just a composition of built-in widgets.

## Common Mistakes

- **Thinking widgets are only visible controls:** themes, navigators, and layout widgets are widgets too.
- **Building one enormous `build` method:** extract repeated or meaningful sections into custom widgets.
- **Using `children` with a single-child widget:** check the widget constructor; Flutter tells you whether it expects `child` or `children`.

## Key Takeaways

- Flutter UI is a hierarchy of widgets.
- Widgets are composed, not manually drawn.
- `child` means one nested widget; `children` means a list.
- Widgets are immutable descriptions of UI.

## Practice

1. Draw the widget tree for a `Scaffold` containing an `AppBar` and a `Column`.
2. Build a `Column` with an icon and two text labels.
3. Extract that column into a custom `StatelessWidget`.

## Further Reading

- [Flutter architectural overview: Widgets](https://docs.flutter.dev/resources/architectural-overview)
- [Building user interfaces with Flutter](https://docs.flutter.dev/ui)
