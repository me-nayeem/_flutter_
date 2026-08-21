Phase 2 — Flutter Fundamentals

3. Scaffold

Now we get to a very important Flutter widget.

If MaterialApp is like the overall setup of your app, then Scaffold is like the basic structure of an individual screen.

Think:

MaterialApp
    ↓
Scaffold
    ↓
Your screen


---

1. What is Scaffold?

Scaffold provides a standard visual structure for a Material Design screen.

For example, a screen can have:

an app bar at the top

the main body

a floating action button

a navigation drawer

a bottom navigation bar


Scaffold gives you places to put these things.

A simple example:

Scaffold(
  appBar: AppBar(
    title: Text('Home'),
  ),
  body: Text('Hello Flutter'),
)

So you can think of Scaffold as:

> The skeleton of a screen.




---

2. appBar

The appBar is the bar at the top of the screen.

Scaffold(
  appBar: AppBar(
    title: Text('Home'),
  ),
)

Conceptually:

┌─────────────────────────┐
│ Home                    │ ← AppBar
├─────────────────────────┤
│                         │
│                         │
│       Screen body       │ ← body
│                         │
│                         │
└─────────────────────────┘

We'll learn AppBar in more detail later. For now, just understand where it belongs.


---

3. body

The body is the main content area of your screen.

Scaffold(
  body: Text('Hello Flutter'),
)

You can put almost any widget there.

For example:

Scaffold(
  body: Column(
    children: [
      Text('Welcome'),
      Text('Nayeem'),
    ],
  ),
)

Later, your body might contain an entire page layout.


---

4. Putting MaterialApp and Scaffold together

Now let's connect the last two lessons.

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: Text('Hello Flutter'),
      ),
    ),
  );
}

The widget tree is:

runApp()
   ↓
MaterialApp
   ↓
Scaffold
   ├── appBar
   │     ↓
   │   AppBar
   │
   └── body
         ↓
       Text

This is a very important Flutter pattern.


---

5. floatingActionButton

Scaffold can also provide a floating action button.

For example:

Scaffold(
  appBar: AppBar(
    title: Text('Notes'),
  ),
  body: Text('My notes'),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
)

Visually, think:

┌─────────────────────────┐
│ Notes                   │
├─────────────────────────┤
│                         │
│       My notes          │
│                         │
│                    (+)  │
└─────────────────────────┘

The + button is the FloatingActionButton.


---

6. Scaffold doesn't mean "the whole application"

This distinction is important.

You generally don't think:

Scaffold = entire app

Instead:

MaterialApp = application-level setup
Scaffold    = structure for a screen

For example, an app might eventually have:

MaterialApp
   │
   ├── Home screen
   │      └── Scaffold
   │
   ├── Login screen
   │      └── Scaffold
   │
   └── Settings screen
          └── Scaffold

Each screen can have its own Scaffold.


---

🧠 Your mental model

Remember these three:

runApp()
   ↓
Starts the Flutter widget tree

MaterialApp
   ↓
Application-level Material configuration

Scaffold
   ↓
Basic visual structure of a screen

And inside Scaffold:

Scaffold
├── appBar
├── body
├── floatingActionButton
├── drawer
└── bottomNavigationBar

You don't need to memorize every property yet.

The big one for now is:

Scaffold gives a screen its basic structure.


---

🎯 Quick check

If I give you:

MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: Text('Profile'),
    ),
    body: Text('Nayeem'),
  ),
)

Tell me what each of these represents:

1. MaterialApp


2. Scaffold


3. AppBar


4. body



Once you've got those, we'll move to 4. Widgets — which is arguably the most important concept in Flutter.
