# BuildContext

`BuildContext` is a handle to a widget's location in the widget tree. Flutter uses it to find data and services supplied by widgets above that location, such as a theme, navigator, or scaffold messenger.

## Learning Goals

- Explain what `BuildContext` represents.
- Use context to read inherited values such as a theme.
- Avoid common context-scope mistakes.

## Where You See It

Every widget's `build` method receives a context.

```dart
@override
Widget build(BuildContext context) {
  return const Text('Hello');
}
```

The widget describes **what** should be displayed. The context describes **where** that widget is located in the tree.

```text
MaterialApp
`- Scaffold
   `- ProfileScreen
      `- Text
         ^
         context identifies this location
```

## Read Values From Above

Many Flutter APIs use context to find the closest matching ancestor.

```dart
@override
Widget build(BuildContext context) {
  final colors = Theme.of(context).colorScheme;

  return Text(
    'Themed text',
    style: TextStyle(color: colors.primary),
  );
}
```

Common examples:

| API | Finds |
| --- | --- |
| `Theme.of(context)` | The nearest theme. |
| `Navigator.of(context)` | The navigator that manages pages. |
| `ScaffoldMessenger.of(context)` | The messenger used for snack bars. |
| `MediaQuery.of(context)` | Screen size and user preferences. |

## Context Scope Matters

Context can only find ancestors that are above it. A context from the widget that creates a `Scaffold` is not below that scaffold, so it cannot look up that scaffold.

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (innerContext) {
          return ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(innerContext).showSnackBar(
                const SnackBar(content: Text('Saved')),
              );
            },
            child: const Text('Show message'),
          );
        },
      ),
    );
  }
}
```

`Builder` creates a new context beneath `Scaffold`. In real applications, extracting a child widget is often clearer than adding a `Builder`.

## Context After an Async Gap

After `await`, a stateful widget might have been removed from the tree. Check `mounted` before using its context.

```dart
Future<void> save() async {
  await Future<void>.delayed(const Duration(seconds: 1));
  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Saved')),
  );
}
```

This check belongs in a `State` object, where `mounted` and `context` are available.

## Common Mistakes

- **Treating context as the widget:** a widget is the UI description; context is its tree location.
- **Using the wrong context:** ensure it is below the ancestor you want to access.
- **Storing a context long-term:** use it only while the relevant widget is mounted.
- **Using context after `await` without checking `mounted`:** the screen may have been disposed.

## Key Takeaways

- `BuildContext` identifies a location in the widget tree.
- It lets Flutter find inherited values and ancestor services.
- Context lookup depends on where that context sits in the tree.
- Check `mounted` when using a state object's context after asynchronous work.

## Practice

1. Read a color from `Theme.of(context)` and apply it to text.
2. Show a snack bar from a button under a `Scaffold`.
3. Explain why a context above `Scaffold` cannot find that scaffold.

## Further Reading

- [BuildContext API reference](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)
- [Scaffold context lookup](https://api.flutter.dev/flutter/material/Scaffold/of.html)
