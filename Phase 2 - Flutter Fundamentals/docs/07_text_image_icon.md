7. Text, Image, and Icon

These are three of the simplest and most common Flutter widgets. They’re also good practice for getting comfortable with the widget-tree idea.

1. Text

Text displays text on the screen:

Text('Hello Flutter')

You can also configure it:

Text(
  'Hello Flutter',
  style: TextStyle(
    fontSize: 24,
  ),
)

So:

Text
 └── 'Hello Flutter'

For now, remember: Text is a widget used to display text.


---

2. Icon

Icon displays an icon from Flutter's built-in Material icons:

Icon(Icons.home)

For example:

Icon(Icons.person)
Icon(Icons.favorite)
Icon(Icons.settings)
Icon(Icons.add)

The important part is:

Icons.home

Icons gives you the available Material icon definitions, and Icon displays one.

You can also configure it:

Icon(
  Icons.home,
  size: 32,
)


---

3. Image

Image displays an image.

There are different sources an image can come from. Two important ones are:

From the network:

Image.network(
  'https://example.com/photo.jpg',
)

From your application's assets:

Image.asset(
  'assets/images/photo.png',
)

We'll learn assets properly later, so don't worry about pubspec.yaml configuration yet.


---

4. Putting them together

Here's a simple screen:

Scaffold(
  appBar: AppBar(
    title: const Text('Profile'),
  ),
  body: Column(
    children: [
      Image.asset('assets/images/profile.png'),
      const Icon(Icons.person),
      const Text('Nayeem'),
    ],
  ),
)

The widget tree is:

Scaffold
├── AppBar
│   └── Text
│
└── Column
    ├── Image
    ├── Icon
    └── Text

And notice something important: Image, Icon, and Text are all just widgets.

That's the pattern you're learning.


---

🧠 Mental model

Keep these three simple definitions:

Text
→ displays text

Image
→ displays an image

Icon
→ displays an icon

And because they're widgets, you can combine them with other widgets:

Scaffold
   ↓
Column
   ├── Image
   ├── Icon
   └── Text

That's enough for this topic.

Next: 8. Container — this is where we start learning how to control a widget's size, spacing, decoration, and position._
