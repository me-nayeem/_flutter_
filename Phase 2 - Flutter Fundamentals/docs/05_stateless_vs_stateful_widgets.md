Phase 2 — Flutter Fundamentals

5. Stateless vs Stateful Widgets

This is a very important distinction in Flutter.

The basic idea is:

> Stateless widget → its configuration doesn't change during its lifetime.
Stateful widget → it has mutable state that can change and cause the UI to update.



Let's make that concrete.


---

1. Stateless widget

A StatelessWidget is appropriate when the widget doesn't need to manage changing state itself.

Example:

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Welcome, Nayeem!');
  }
}

The important part is:

extends StatelessWidget

And every widget must implement:

build()

The build() method describes what the widget should display.

So conceptually:

WelcomeText
     ↓
  build()
     ↓
 Text('Welcome, Nayeem!')


---

2. Why is it called "Stateless"?

Because the widget itself doesn't maintain mutable state.

For example, this is a simple piece of UI:

const Text('Hello')

There's no counter, selected item, text input, etc. that this widget needs to change internally.

So StatelessWidget is a natural fit.


---

3. Stateful widget

Now imagine a counter:

Count: 0

     [+]

When the user presses +:

Count: 0
   ↓
Count: 1

Then:

Count: 1
   ↓
Count: 2

Something is changing.

That's state.

For this, we use a StatefulWidget.

A basic example:

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Text('$count');
  }
}

Here:

int count = 0;

is state that can change.


---

4. The interesting part: two classes

A StatefulWidget normally involves two classes:

class Counter extends StatefulWidget {
  ...
}

class _CounterState extends State<Counter> {
  ...
}

At first this looks weird.

Why two classes?

Because Flutter separates:

Widget
   +
State

The Counter widget describes the widget's configuration.

The _CounterState object holds the mutable state.

For now, don't overthink the internals.

Just remember:

StatefulWidget
      ↓
   State<T>
      ↓
mutable state


---

5. setState()

Here's the most important part.

Suppose:

int count = 0;

We want to increase it:

count++;

Simply changing the variable isn't enough to tell Flutter:

> "Hey, the UI needs to update."



We use:

setState(() {
  count++;
});

For example:

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$count'),
        ElevatedButton(
          onPressed: increment,
          child: const Text('Add'),
        ),
      ],
    );
  }
}

The important sequence is:

User taps button
      ↓
increment()
      ↓
setState()
      ↓
count changes
      ↓
Flutter rebuilds the relevant UI
      ↓
new count appears

That's the basic idea behind reactive UI in Flutter.


---

6. Stateless doesn't mean "never changes"

This is a subtle but important point.

A StatelessWidget can rebuild.

For example, a parent can rebuild and provide different values to a StatelessWidget.

So don't interpret "stateless" as:

> "This widget can never display anything different."



Instead, think:

> The widget itself doesn't own mutable state.



That's a much better mental model.


---

7. When should you use each?

Use StatelessWidget when:

The widget doesn't need to maintain changing state.

Examples:

Welcome message
Profile label
Icon
Static section
Reusable display widget

Use StatefulWidget when:

The widget needs to manage changing state.

Examples:

Counter
Checkbox selection
Animation state
Text/input interaction
Expandable section
Selected tab

Later we'll learn that state can also be managed outside a widget using state-management approaches such as Riverpod or BLoC.

But don't worry about that yet. Our roadmap deliberately has you learn basic state first. 


---

🧠 The mental model

Think of it like this:

StatelessWidget
      ↓
"I display something based on my inputs."

StatefulWidget
      ↓
"I have state that can change."

setState()
      ↓
"Flutter, my state changed.
Please rebuild the relevant UI."

And the big distinction:

Stateless
   → no mutable state owned by the widget

Stateful
   → owns mutable state
   → state can change
   → setState() can trigger a rebuild

🎯 Quick check

Imagine a screen showing:

Username: Nayeem
Age: 21

Nothing on the screen changes while the app is running.

Would you normally use a StatelessWidget or StatefulWidget for that display?

And then imagine a counter where the user can press + and change 0 → 1 → 2 → 3.

Which one would you use there, and why?
