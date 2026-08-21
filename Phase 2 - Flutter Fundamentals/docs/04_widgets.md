Phase 2 — Flutter Fundamentals

4. Widgets

This is probably the single most important concept to understand in Flutter.

If you understand widgets properly, a lot of Flutter starts making sense.


---

1. What is a widget?

The simplest definition is:

> A widget is a description of part of your app's user interface.



Almost everything you put into a Flutter UI is a widget.

For example:

Text('Hello')

is a widget.

So is:

Icon(Icons.home)

And:

Scaffold(...)

And:

MaterialApp(...)

Even things that don't directly look like UI can be widgets because they can control how other widgets behave or are organized.


---

2. Flutter UI is a widget tree

Remember the structure from MaterialApp and Scaffold?

MaterialApp
    ↓
Scaffold
    ↓
AppBar
    ↓
Text

That's called a widget tree.

A more realistic example:

MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: Text('Home'),
    ),
    body: Column(
      children: [
        Text('Welcome'),
        Text('Nayeem'),
      ],
    ),
  ),
)

The tree looks roughly like:

MaterialApp
└── Scaffold
    ├── AppBar
    │   └── Text
    │
    └── Column
        ├── Text
        └── Text

Flutter builds your interface by composing these widgets together.


---

3. Widgets can contain other widgets

This is the key idea.

For example:

Scaffold(
  body: Text('Hello'),
)

The Scaffold contains a Text.

Or:

Column(
  children: [
    Text('Hello'),
    Text('World'),
  ],
)

The Column contains two Text widgets.

So you build complicated interfaces by combining simpler widgets.

Think of it like LEGO:

Small widgets
     ↓
Combine them
     ↓
Bigger widgets
     ↓
Complete screen
     ↓
Complete app


---

4. Text is a widget

You've already seen:

Text('Hello')

This displays text.

For example:

Scaffold(
  body: Text('Welcome to my app'),
)

Here:

Scaffold
   ↓
body
   ↓
Text


---

5. Column is also a widget

Suppose you want multiple things vertically:

Column(
  children: [
    Text('Name'),
    Text('Age'),
    Text('Country'),
  ],
)

The Column arranges its children vertically.

Name

Age

Country

Notice the terminology:

children: [...]

A widget can have children.


---

6. Some widgets have one child

For example:

Center(
  child: Text('Hello'),
)

Center has one:

child

So:

Center
  ↓
Text


---

7. Some widgets have multiple children

Column has:

children: [...]

For example:

Column(
  children: [
    Text('One'),
    Text('Two'),
    Text('Three'),
  ],
)

So:

Column
├── Text
├── Text
└── Text

This distinction is worth remembering:

child    → one widget
children → multiple widgets


---

8. Widgets are composed

Suppose we want:

Welcome
          Nayeem
           (+)

We might build it using:

Scaffold
├── AppBar
│   └── Text
│
└── Column
    ├── Text
    └── Text

FloatingActionButton
└── Icon

We're not drawing the entire screen manually.

We're describing the UI using widgets.

That's the Flutter philosophy.


---

9. A very important distinction

Don't think of a widget as simply:

> "A button."



or:

> "A piece of visible UI."



That's sometimes true, but the deeper idea is:

> A widget describes how part of the UI should be structured or behave.



That's why widgets can handle things like:

layout

styling

interaction

positioning

screen structure


We'll see this become clearer as we learn more widgets.


---

10. Widget tree vs actual pixels

One useful mental model:

You write:

Column(
  children: [
    Text('Hello'),
    Text('World'),
  ],
)

Flutter doesn't just see random Dart objects.

It uses this widget structure to determine what the UI should look like.

Conceptually:

Your Dart code
      ↓
Widget tree
      ↓
Flutter framework
      ↓
Rendered UI

So when you're building Flutter apps, you're constantly thinking:

> "What widgets should make up this part of the screen?"



That question becomes extremely useful.


---

🧠 Your mental model

Remember:

Widget = building block of Flutter UI.

Widget tree = widgets nested inside other widgets.

For example:

MaterialApp
   ↓
Scaffold
   ↓
Column
   ├── Text
   ├── Icon
   └── Button

And:

child    → one widget
children → multiple widgets

That's the foundation.


---

🎯 Quick check

Look at this:

Column(
  children: [
    Text('Nayeem'),
    Icon(Icons.person),
  ],
)

Tell me:

1. What is the parent widget?


2. What are its two child widgets?


3. Why is children plural here instead of child?



Once you've got that, we'll move to 5. Stateless vs Stateful widgets — where you'll learn one of the most important distinctions in Flutter.
