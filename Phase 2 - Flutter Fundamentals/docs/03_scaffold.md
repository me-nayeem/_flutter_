# Scaffold

`Scaffold` provides the standard Material layout for one screen. It gives named locations for common UI elements, so you can build a page without manually positioning every part.

## Learning Goals

- Use `Scaffold` to create a screen structure.
- Place content in `appBar`, `body`, and `floatingActionButton`.
- Distinguish an app-level `MaterialApp` from a screen-level `Scaffold`.

## A Complete Screen

```dart
class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: const Center(child: Text('No notes yet.')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

```text
Scaffold
|- appBar: AppBar
|- body: Center
|  `- Text
`- floatingActionButton: FloatingActionButton
```

## Main Scaffold Areas

| Property | Use |
| --- | --- |
| `appBar` | Header area, usually an `AppBar`. |
| `body` | Main content of the screen. |
| `floatingActionButton` | Primary contextual action, such as adding an item. |
| `drawer` | Side navigation panel. |
| `bottomNavigationBar` | Navigation between top-level sections. |
| `bottomSheet` | Persistent content anchored at the bottom. |

You do not need every property on every screen. Start with `body`, then add structure only when the user flow needs it.

## `AppBar`

`AppBar` commonly holds a title, navigation control, and actions.

```dart
AppBar(
  title: const Text('Profile'),
  actions: [
    IconButton(
      tooltip: 'Settings',
      icon: const Icon(Icons.settings),
      onPressed: () {},
    ),
  ],
)
```

Use tooltips for icon-only controls so their purpose is clear to assistive technologies and mouse users.

## The `body`

`body` is a single widget. Use a layout widget when the screen needs multiple elements.

```dart
body: const Center(
  child: Text('Welcome back!'),
)
```

Later, `Column`, `ListView`, and `Stack` will help you arrange richer content in this area.

## One App, Many Scaffolds

An app commonly has one root `MaterialApp` and several screens. Each screen can use its own `Scaffold`.

```text
MaterialApp
|- HomeScreen -> Scaffold
|- ProfileScreen -> Scaffold
`- SettingsScreen -> Scaffold
```

## Common Mistakes

- **Treating `Scaffold` as the entire application:** it describes a screen, not the app-wide navigation and theme setup.
- **Using multiple floating action buttons:** use one primary action; move secondary actions to the app bar or content.
- **Putting unbounded scrollable content in a `Column`:** use `ListView` when content can exceed the screen height.

## Key Takeaways

- `Scaffold` supplies a familiar Material screen layout.
- `appBar` and `body` are the most common properties.
- A floating action button represents one high-priority screen action.

## Practice

1. Build a profile screen with an `AppBar` and centered text.
2. Add an icon button to the app bar with a tooltip.
3. Add a floating action button that prints a message in its callback.

## Further Reading

- [Flutter layout tutorial](https://docs.flutter.dev/learn/pathway/tutorial/layout)
- [Scaffold API reference](https://api.flutter.dev/flutter/material/Scaffold-class.html)
