# Stateless and Stateful Widgets

Every custom Flutter widget is usually either stateless or stateful. Choose based on whether the widget itself needs to own data that changes during its lifetime.

## Learning Goals

- Choose between `StatelessWidget` and `StatefulWidget`.
- Understand a stateful widget's two-class structure.
- Use `setState` to update local UI state.

## StatelessWidget

Use `StatelessWidget` when the widget only displays its constructor inputs and does not manage mutable state of its own.

```dart
class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text('Welcome, $name!');
  }
}
```

The parent can provide a different `name` later, so a stateless widget can rebuild and display different output. It simply does not own mutable state itself.

## StatefulWidget

Use `StatefulWidget` when the widget owns local data that changes while it is on screen, such as a selected tab, a counter, or an animation value.

```dart
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Count: $_count'),
        ElevatedButton(
          onPressed: _increment,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
```

## Why Are There Two Classes?

```text
Counter (StatefulWidget)
`- immutable configuration

_CounterState (State<Counter>)
`- mutable state and build method
```

The widget object holds configuration supplied by the parent. The `State` object holds data that survives rebuilds while the widget remains at the same location in the tree.

## What `setState` Does

`setState` tells Flutter that the state changed and schedules a rebuild for that state object's subtree.

```dart
setState(() {
  _count++;
});
```

Do not change UI state outside `setState` if the change must appear on screen. Keep the callback short: update the value inside it, and do asynchronous or expensive work outside it.

## Choosing the Right Type

| Use `StatelessWidget` when... | Use `StatefulWidget` when... |
| --- | --- |
| The UI is derived from inputs only. | The widget owns changing local data. |
| You display labels, cards, icons, or fixed layouts. | You handle a counter, checkbox, tab, animation, or form interaction. |
| A parent or external state manager owns the state. | `setState` is sufficient for local screen state. |

> Start with `StatelessWidget`. Convert to `StatefulWidget` only when the widget needs to own mutable UI state. Later, app-wide state can be managed outside widgets.

## Common Mistakes

- **Calling `setState` inside `build`:** this creates a rebuild loop.
- **Making every widget stateful:** stateful is not more powerful; it is appropriate only when local mutable state is required.
- **Mutating state without `setState`:** the value changes, but Flutter is not told to redraw the UI.
- **Starting async work in `build`:** `build` can run many times; use lifecycle methods or an event callback instead.

## Key Takeaways

- A stateless widget does not own mutable state.
- A stateful widget pairs immutable configuration with a persistent `State` object.
- `setState` updates local state and triggers a rebuild.
- Rebuilding is normal; write `build` as a quick description of the UI.

## Practice

1. Create a stateless profile label that receives a name.
2. Build a stateful counter with increment and reset buttons.
3. Add a boolean to show or hide a text message using `setState`.

## Further Reading

- [Building user interfaces with Flutter](https://docs.flutter.dev/ui)
- [StatefulWidget API reference](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)
