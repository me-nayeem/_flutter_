# 🟢 Phase 2 — Topic 15: Buttons

> **Buttons are interactive widgets that allow users to perform actions.**

According to the roadmap, after `GridView`, the next Phase 2 topic is **Buttons**. 

Buttons are one of the most important Flutter concepts because they connect the **UI** to **behavior**.

For example:

```text
User
  │
  │ taps button
  ▼
Button
  │
  │ onPressed()
  ▼
Dart code
  │
  ▼
Action
```

Examples of actions:

* Navigate to another screen
* Submit a form
* Save data
* Delete an item
* Open a dialog
* Call an API
* Update state
* Start an animation

---

# 📚 Table of Contents

1. [What is a Button?](#-1-what-is-a-button)
2. [The Most Important Concept: onPressed](#-2-the-most-important-concept-onpressed)
3. [ElevatedButton](#-3-elevatedbutton)
4. [TextButton](#-4-textbutton)
5. [OutlinedButton](#-5-outlinedbutton)
6. [Button Comparison](#-6-button-comparison)
7. [IconButton](#-7-iconbutton)
8. [FloatingActionButton](#-8-floatingactionbutton)
9. [Button Child](#-9-button-child)
10. [Button Styling](#-10-button-styling)
11. [Button Size](#-11-button-size)
12. [Padding and Alignment](#-12-padding-and-alignment)
13. [Button with Icon](#-13-button-with-icon)
14. [Disabled Buttons](#-14-disabled-buttons)
15. [Understanding `onPressed: null`](#-15-understanding-onpressed-null)
16. [Callback and Functions](#-16-callback-and-functions)
17. [Passing Arguments to onPressed](#-17-passing-arguments-to-onpressed)
18. [Common Mistakes](#-18-common-mistakes)
19. [Buttons inside Row and Column](#-19-buttons-inside-row-and-column)
20. [Real-World Example](#-20-real-world-example)
21. [Professional Best Practices](#-21-professional-best-practices)
22. [Practice](#-22-practice)
23. [Knowledge Check](#-23-knowledge-check)
24. [Quick Reference](#-24-quick-reference)
25. [Key Takeaways](#-25-key-takeaways)

---

# 📚 1. What is a Button?

A button is an interactive widget.

The simplest example:

```dart
ElevatedButton(
  onPressed: () {
    print('Button pressed');
  },
  child: const Text('Click Me'),
)
```

Visually:

```text
┌──────────────────┐
│    Click Me      │
└──────────────────┘
```

When the user taps it:

```text
Tap
 ↓
onPressed
 ↓
print(...)
```

The important part is:

```dart
onPressed: () {
  print('Button pressed');
},
```

This tells Flutter:

> **"When the user activates this button, execute this function."**

---

# 🧠 2. The Most Important Concept: `onPressed`

If you're learning buttons, understand this concept extremely well.

Consider:

```dart
ElevatedButton(
  onPressed: () {
    print('Hello');
  },
  child: const Text('Press'),
)
```

The `onPressed` property expects a **callback function**.

A callback is essentially:

> A function that you give to another piece of code so that it can call your function later.

The flow is:

```text
You create function
      │
      ▼
Give function to Button
      │
      ▼
User taps button
      │
      ▼
Flutter calls your function
```

This is a fundamental concept that you'll use throughout Flutter.

---

# 💻 3. `ElevatedButton`

`ElevatedButton` is commonly used for **primary actions**.

Example:

```dart
ElevatedButton(
  onPressed: () {
    print('Login');
  },
  child: const Text('Login'),
)
```

Typical usage:

```text
Login
Sign Up
Submit
Save
Continue
Buy Now
```

Example:

```dart
Column(
  children: [
    const Text('Welcome back!'),

    ElevatedButton(
      onPressed: () {
        print('Login pressed');
      },
      child: const Text('Login'),
    ),
  ],
)
```

---

# 💡 When should you use `ElevatedButton`?

Use it when the action is relatively important.

For example:

```text
┌──────────────────────┐
│       Continue       │
└──────────────────────┘
```

It's usually appropriate for a primary action.

Don't make every button on your screen an `ElevatedButton`.

A good UI establishes a visual hierarchy.

---

# 💻 4. `TextButton`

`TextButton` is a simpler, less visually prominent button.

Example:

```dart
TextButton(
  onPressed: () {
    print('Forgot password');
  },
  child: const Text('Forgot Password?'),
)
```

Visually, it may look approximately like:

```text
Forgot Password?
```

rather than a filled button.

Common uses:

* Cancel
* Learn more
* Forgot password
* See all
* Secondary actions

---

# 💡 Example

```dart
Row(
  children: [
    TextButton(
      onPressed: () {
        print('Cancel');
      },
      child: const Text('Cancel'),
    ),

    ElevatedButton(
      onPressed: () {
        print('Save');
      },
      child: const Text('Save'),
    ),
  ],
)
```

This establishes hierarchy:

```text
Cancel       [ Save ]
```

The user can immediately understand which action is more important.

---

# 💻 5. `OutlinedButton`

`OutlinedButton` provides a bordered button without the strong filled appearance of an `ElevatedButton`.

Example:

```dart
OutlinedButton(
  onPressed: () {
    print('Edit');
  },
  child: const Text('Edit'),
)
```

Conceptually:

```text
┌──────────────────┐
│       Edit       │
└──────────────────┘
```

It is useful for secondary or alternative actions.

For example:

```text
[ Continue ]

┌──────────────┐
│    Cancel    │
└──────────────┘
```

---

# 📊 6. Button Comparison

| Button                 | Visual emphasis | Typical use           |
| ---------------------- | --------------- | --------------------- |
| `ElevatedButton`       | High            | Primary action        |
| `OutlinedButton`       | Medium          | Secondary action      |
| `TextButton`           | Low             | Less prominent action |
| `IconButton`           | Icon-focused    | Toolbar/action icons  |
| `FloatingActionButton` | High/prominent  | Main screen action    |

A useful mental model:

```text
              Importance
                  ↑
                  │
        ElevatedButton
                  │
        OutlinedButton
                  │
          TextButton
                  │
                  └──────────────→
```

This isn't a strict Flutter rule. It's a **UI design mental model**.

---

# 💻 7. `IconButton`

When the action can be communicated effectively through an icon, use `IconButton`.

Example:

```dart
IconButton(
  onPressed: () {
    print('Favorite');
  },
  icon: const Icon(Icons.favorite),
)
```

Common examples:

```text
♡ Favorite
🔍 Search
⋮ More
⚙ Settings
← Back
🗑 Delete
```

Example AppBar:

```dart
AppBar(
  title: const Text('Products'),
  actions: [
    IconButton(
      onPressed: () {
        print('Search');
      },
      icon: const Icon(Icons.search),
    ),

    IconButton(
      onPressed: () {
        print('More');
      },
      icon: const Icon(Icons.more_vert),
    ),
  ],
)
```

---

# 🧠 Important: Accessibility

An icon alone may not always communicate its purpose clearly to every user.

For important icon-only actions, provide a meaningful tooltip:

```dart
IconButton(
  tooltip: 'Delete',
  onPressed: () {
    print('Delete');
  },
  icon: const Icon(Icons.delete),
)
```

This improves usability and accessibility.

---

# 💻 8. `FloatingActionButton`

`FloatingActionButton`, commonly called `FAB`, is designed for a prominent action associated with the current screen.

Example:

```dart
FloatingActionButton(
  onPressed: () {
    print('Add');
  },
  child: const Icon(Icons.add),
)
```

Usually used with `Scaffold`:

```dart
Scaffold(
  appBar: AppBar(
    title: const Text('Notes'),
  ),

  body: const Center(
    child: Text('My Notes'),
  ),

  floatingActionButton: FloatingActionButton(
    onPressed: () {
      print('Create note');
    },
    child: const Icon(Icons.add),
  ),
)
```

Conceptually:

```text
┌─────────────────────────────┐
│           Notes             │
├─────────────────────────────┤
│                             │
│        My Notes             │
│                             │
│                        ┌───┐│
│                        │ + ││
│                        └───┘│
└─────────────────────────────┘
```

A common use case:

```text
Notes app
    ↓
FAB (+)
    ↓
Create new note
```

---

# 💻 9. Button `child`

Most Material buttons have a `child`.

Example:

```dart
ElevatedButton(
  onPressed: () {},
  child: const Text('Save'),
)
```

The child doesn't have to be only `Text`.

You can create richer button content:

```dart
ElevatedButton(
  onPressed: () {},
  child: const Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.download),
      SizedBox(width: 8),
      Text('Download'),
    ],
  ),
)
```

Result:

```text
┌──────────────────────────┐
│  ↓  Download             │
└──────────────────────────┘
```

This connects your previous knowledge:

```text
Button
  │
  └── Row
       ├── Icon
       └── Text
```

---

# 🧠 Why `mainAxisSize: MainAxisSize.min`?

Consider:

```dart
Row(
  children: [
    Icon(Icons.download),
    Text('Download'),
  ],
)
```

Inside a button, you usually want the `Row` to take only the space it needs.

So:

```dart
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.download),
    SizedBox(width: 8),
    Text('Download'),
  ],
)
```

means:

> **Make the Row only as wide as its children require.**

This is a small but important layout detail.

---

# 🎨 10. Button Styling

Flutter's Material buttons can be customized using `style`.

Example:

```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  child: const Text('Login'),
)
```

Here:

```dart
backgroundColor
```

controls the button's background.

And:

```dart
foregroundColor
```

controls foreground content such as text and icons.

---

# 🔍 `backgroundColor` vs `foregroundColor`

Think:

```text
backgroundColor
       ↓
      [ BUTTON ]
       
foregroundColor
       ↓
 Text / Icon
```

Example:

```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  child: const Text('Continue'),
)
```

---

# 🟦 Border Radius

You can customize the shape:

```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  child: const Text('Continue'),
)
```

Conceptually:

```text
╭──────────────────────╮
│       Continue       │
╰──────────────────────╯
```

---

# 📏 11. Button Size

You can control the minimum size:

```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    minimumSize: const Size(200, 50),
  ),
  child: const Text('Login'),
)
```

This creates a button approximately:

```text
width  ≥ 200
height ≥ 50
```

The exact final size can still depend on the button's layout and other constraints.

---

# 💡 Full-width Button

A common login screen pattern is:

```dart
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {},
    child: const Text('Login'),
  ),
)
```

Conceptually:

```text
┌────────────────────────────────┐
│              Login             │
└────────────────────────────────┘
```

Here:

```dart
width: double.infinity
```

means:

> Take as much width as the parent allows.

This connects directly to your understanding of Flutter constraints.

---

# 📦 12. Padding and Alignment

You can place a button inside padding:

```dart
Padding(
  padding: const EdgeInsets.all(16),
  child: ElevatedButton(
    onPressed: () {},
    child: const Text('Login'),
  ),
)
```

Or:

```dart
Center(
  child: ElevatedButton(
    onPressed: () {},
    child: const Text('Login'),
  ),
)
```

Notice something important:

> **The button itself doesn't need to solve every layout problem.**

Flutter's compositional design allows you to combine small widgets:

```text
Padding
   │
   └── Center
         │
         └── Button
```

Use the widget responsible for the job.

---

# 💻 13. Button with Icon

Flutter provides convenient button constructors for icon + label combinations.

For example:

```dart
ElevatedButton.icon(
  onPressed: () {},
  icon: const Icon(Icons.download),
  label: const Text('Download'),
)
```

This is cleaner than manually creating:

```dart
ElevatedButton(
  onPressed: () {},
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.download),
      SizedBox(width: 8),
      Text('Download'),
    ],
  ),
)
```

When Flutter provides a semantic constructor that directly expresses your intention, prefer it.

---

# 💡 Other Useful Constructors

Similarly:

```dart
OutlinedButton.icon(
  onPressed: () {},
  icon: const Icon(Icons.edit),
  label: const Text('Edit'),
)
```

and:

```dart
TextButton.icon(
  onPressed: () {},
  icon: const Icon(Icons.info),
  label: const Text('Learn More'),
)
```

---

# 🚫 14. Disabled Buttons

A button can be disabled.

For example:

```dart
ElevatedButton(
  onPressed: null,
  child: const Text('Submit'),
)
```

Notice:

```dart
onPressed: null
```

This is special.

It means:

> **The button is disabled.**

Flutter automatically applies its disabled visual state according to the button's theme/style.

---

# 🧠 15. Understanding `onPressed: null`

Compare:

### Enabled

```dart
ElevatedButton(
  onPressed: () {},
  child: const Text('Submit'),
)
```

### Disabled

```dart
ElevatedButton(
  onPressed: null,
  child: const Text('Submit'),
)
```

The difference:

```text
() {}
  ↓
callback exists
  ↓
button enabled


null
  ↓
no callback
  ↓
button disabled
```

This is extremely useful for forms.

Example:

```dart
ElevatedButton(
  onPressed: isFormValid
      ? () {
          submitForm();
        }
      : null,
  child: const Text('Submit'),
)
```

Now:

```text
Form invalid
    ↓
onPressed = null
    ↓
Button disabled


Form valid
    ↓
onPressed = callback
    ↓
Button enabled
```

This pattern appears constantly in real applications.

---

# 🧠 16. Callback and Functions

Let's understand this deeply.

You can create a function:

```dart
void login() {
  print('Logging in...');
}
```

Then:

```dart
ElevatedButton(
  onPressed: login,
  child: const Text('Login'),
)
```

Notice:

```dart
onPressed: login
```

**not:**

```dart
onPressed: login()
```

This distinction is extremely important.

---

## ❌ Wrong

```dart
onPressed: login(),
```

Why?

Because:

```dart
login()
```

means:

> **Call `login` right now.**

But the button needs:

> **Give me the function so I can call it later when the user presses the button.**

---

## ✅ Correct

```dart
onPressed: login,
```

Think:

```text
login
  ↓
"Here is the function."

login()
  ↓
"Execute the function now."
```

This distinction is fundamental to Dart and Flutter callbacks.

---

# 💻 17. Passing Arguments to `onPressed`

Suppose:

```dart
void deleteItem(int id) {
  print('Deleting $id');
}
```

You cannot directly write:

```dart
onPressed: deleteItem(10), // ❌
```

because that executes immediately.

Instead:

```dart
onPressed: () {
  deleteItem(10);
},
```

Now:

```text
Button
   │
   │ user taps
   ▼
() {
  deleteItem(10);
}
   │
   ▼
deleteItem(10)
```

This is one of the most common callback patterns in Flutter.

---

# 🧠 Function Reference vs Function Call

Memorize this distinction:

```dart
onPressed: login
```

means:

> Pass the function.

Whereas:

```dart
onPressed: login()
```

means:

> Call the function now.

For arguments:

```dart
onPressed: () => login(userId)
```

or:

```dart
onPressed: () {
  login(userId);
}
```

---

# 🧱 18. Common Mistakes

## ❌ Mistake 1 — Calling the callback immediately

Wrong:

```dart
onPressed: login(),
```

Correct:

```dart
onPressed: login,
```

or:

```dart
onPressed: () {
  login();
},
```

---

## ❌ Mistake 2 — Forgetting `onPressed`

For example:

```dart
ElevatedButton(
  child: const Text('Login'),
)
```

This isn't a complete button configuration.

Provide the callback:

```dart
ElevatedButton(
  onPressed: login,
  child: const Text('Login'),
)
```

---

## ❌ Mistake 3 — Using `Container` to make a button

Beginners sometimes create:

```dart
Container(
  color: Colors.blue,
  padding: const EdgeInsets.all(20),
  child: const Text('Login'),
)
```

and then add a `GestureDetector`.

Sometimes that's useful for custom interactions, but if you simply need a button:

> **Use a button widget.**

You get built-in semantics, interaction behavior, focus handling, Material styling, disabled states, and accessibility support.

---

## ❌ Mistake 4 — Making every action an `ElevatedButton`

Don't create:

```text
[ Save ]
[ Cancel ]
[ Delete ]
[ Edit ]
[ More ]
[ Settings ]
```

all with identical visual prominence.

Good UI uses visual hierarchy.

---

## ❌ Mistake 5 — Using text where an icon is clearer

For actions like:

```text
Delete
Search
Settings
Back
More
```

an appropriate icon can communicate the action efficiently.

But don't sacrifice clarity for minimalism.

---

# 🧩 19. Buttons inside `Row` and `Column`

Because you've already learned `Row` and `Column`, buttons can now be combined with them.

## Column

```dart
Column(
  children: [
    ElevatedButton(
      onPressed: () {},
      child: const Text('Login'),
    ),

    const SizedBox(height: 12),

    OutlinedButton(
      onPressed: () {},
      child: const Text('Sign Up'),
    ),

    const SizedBox(height: 12),

    TextButton(
      onPressed: () {},
      child: const Text('Forgot Password?'),
    ),
  ],
)
```

Conceptually:

```text
      [ Login ]

    [ Sign Up ]

  Forgot Password?
```

---

## Row

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    TextButton(
      onPressed: () {},
      child: const Text('Cancel'),
    ),

    const SizedBox(width: 12),

    ElevatedButton(
      onPressed: () {},
      child: const Text('Save'),
    ),
  ],
)
```

Result:

```text
[ Cancel ]   [ Save ]
```

---

# 🛒 20. Real-World Example

Let's combine several concepts.

Imagine a product page:

```text
┌──────────────────────────────┐
│          Product             │
│                              │
│        [ IMAGE ]             │
│                              │
│        Laptop                │
│        $1200                 │
│                              │
│   [ Add to Cart ]            │
│                              │
│      Buy Now                 │
└──────────────────────────────┘
```

Code:

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    const Icon(
      Icons.laptop,
      size: 120,
    ),

    const SizedBox(height: 16),

    const Text(
      'Laptop',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),

    const SizedBox(height: 8),

    const Text(
      '\$1200',
      style: TextStyle(
        fontSize: 18,
      ),
    ),

    const SizedBox(height: 20),

    ElevatedButton.icon(
      onPressed: () {
        print('Added to cart');
      },
      icon: const Icon(Icons.shopping_cart),
      label: const Text('Add to Cart'),
    ),

    TextButton(
      onPressed: () {
        print('Buy now');
      },
      child: const Text('Buy Now'),
    ),
  ],
)
```

Notice how your previous topics are now working together:

```text
Column
├── Icon
├── SizedBox
├── Text
├── SizedBox
├── Text
├── SizedBox
├── ElevatedButton
└── TextButton
```

This is how Flutter development works in practice:

> **You don't learn widgets independently forever. You learn how to compose them.**

---

# 🧠 A Professional Button Mental Model

When creating a button, think through these questions:

```text
1. What action does this perform?
          ↓
2. How important is the action?
          ↓
3. Which button type communicates that importance?
          ↓
4. What happens when the user taps it?
          ↓
5. Can the action currently be performed?
          ↓
6. How should the button look?
          ↓
7. Is the action accessible and understandable?
```

For example:

### Delete account

```text
Action
 ↓
Destructive
 ↓
Needs clear visual treatment
 ↓
Confirmation may be appropriate
 ↓
Execute deletion only after confirmation
```

This is how a professional developer thinks beyond simply:

```dart
ElevatedButton(...)
```

---

# 🚀 21. Professional Best Practices

## 1. Choose buttons based on hierarchy

Use:

```text
ElevatedButton → primary action
OutlinedButton → secondary action
TextButton     → low-emphasis action
IconButton     → icon-based action
FAB            → prominent screen-level action
```

These are guidelines, not absolute rules.

---

## 2. Keep button callbacks focused

Avoid putting huge amounts of business logic directly inside:

```dart
onPressed: () {
  // 100 lines...
}
```

Instead:

```dart
onPressed: () {
  submitOrder();
},
```

Then keep the actual logic in an appropriate method/service/state layer as your application grows.

---

## 3. Give buttons meaningful labels

Prefer:

```dart
Text('Save Changes')
```

over:

```dart
Text('Click')
```

A good label communicates the action.

---

## 4. Handle disabled states intentionally

For example:

```dart
onPressed: isLoading ? null : submit,
```

This can prevent duplicate submissions while an operation is in progress.

---

## 5. Don't manually recreate standard buttons

If a standard Flutter button already expresses your interaction:

```dart
ElevatedButton
OutlinedButton
TextButton
IconButton
```

prefer it over manually building a clickable `Container`.

---

## 6. Extract reusable buttons when appropriate

If your app repeatedly uses:

```text
Primary button
Secondary button
Danger button
```

consider creating reusable widgets.

For example:

```dart
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
```

Then:

```dart
PrimaryButton(
  label: 'Login',
  onPressed: login,
)
```

This becomes especially valuable as applications grow.

---

# 🔍 Important Flutter Concept: `VoidCallback`

You'll often see:

```dart
VoidCallback?
```

For example:

```dart
final VoidCallback? onPressed;
```

`VoidCallback` is essentially a function type representing:

```dart
void Function()
```

So:

```dart
VoidCallback?
```

means:

> A callback that takes no arguments and returns nothing, or `null`.

That's exactly the kind of callback used for many button actions.

---

# 🧠 Button Architecture

A useful conceptual model:

```text
                    Button
                      │
       ┌──────────────┼──────────────┐
       │              │              │
       ▼              ▼              ▼
    Visual         Interaction     Semantics
       │              │              │
       ▼              ▼              ▼
   Style/theme     onPressed       label/icon
                      │
                      ▼
                   Action
```

A button isn't just a colored rectangle.

It is an **interactive semantic UI component**.

That's why using a proper button widget is preferable to manually creating a clickable `Container` for standard button behavior.

---

# 🧪 22. Practice

## 🟢 Beginner — Three Buttons

Create:

```text
[ Login ]

[ Sign Up ]

Forgot Password?
```

Use:

* `ElevatedButton`
* `OutlinedButton`
* `TextButton`

Each button should print a different message.

---

## 🟢 Beginner — Icon Buttons

Create four `IconButton`s:

```text
Search
Favorite
Delete
Settings
```

Each should print its action.

Add meaningful `tooltip`s.

---

## 🟡 Intermediate — Login Screen

Create:

```text
       Welcome Back

      [ Email ]

      [ Password ]

      [   Login   ]

    Forgot Password?

       [ Sign Up ]
```

You don't need to build the text fields yet.

Use placeholder `Container`s or `Text`s for now.

Focus on:

* Button hierarchy
* Spacing
* Full-width primary button
* Secondary action

---

## 🟡 Intermediate — Product Actions

Create:

```text
Product: Laptop
Price: $1200

[ 🛒 Add to Cart ]

      Buy Now
```

Requirements:

* `ElevatedButton.icon`
* `TextButton`
* Proper spacing
* Meaningful callbacks

---

# 🔴 Challenge — Button State

Create a button:

```text
[ Submit ]
```

with a boolean:

```dart
bool isLoading = false;
```

When the user presses it:

```text
Submit
  ↓
isLoading = true
  ↓
button disabled
```

After a simulated delay:

```text
isLoading = false
  ↓
button enabled again
```

This challenge introduces an important concept you'll use later with:

* API calls
* Forms
* State management
* Loading states

---

# 🧠 23. Knowledge Check

Before moving forward, make sure you can explain:

1. What is a button?
2. What does `onPressed` do?
3. What is a callback?
4. What's the difference between `onPressed: login` and `onPressed: login()`?
5. When would you use `ElevatedButton`?
6. When would you use `TextButton`?
7. When would you use `OutlinedButton`?
8. When would you use `IconButton`?
9. What is a `FloatingActionButton`?
10. How do you disable a button?
11. Why does `onPressed: null` disable a button?
12. How do you pass arguments to a callback?
13. What is `VoidCallback`?
14. How do you create an icon + text button?
15. How do you make a button take the available width?
16. How do you style a button?
17. Why shouldn't you use `Container` as a replacement for every button?
18. Why is visual hierarchy important when choosing button types?

If you can answer these without memorizing the lesson, you understand the fundamentals.

---

# 📌 24. Quick Reference

## ElevatedButton

```dart
ElevatedButton(
  onPressed: () {},
  child: const Text('Save'),
)
```

---

## TextButton

```dart
TextButton(
  onPressed: () {},
  child: const Text('Cancel'),
)
```

---

## OutlinedButton

```dart
OutlinedButton(
  onPressed: () {},
  child: const Text('Edit'),
)
```

---

## IconButton

```dart
IconButton(
  tooltip: 'Delete',
  onPressed: () {},
  icon: const Icon(Icons.delete),
)
```

---

## FloatingActionButton

```dart
FloatingActionButton(
  onPressed: () {},
  child: const Icon(Icons.add),
)
```

---

## Button with icon

```dart
ElevatedButton.icon(
  onPressed: () {},
  icon: const Icon(Icons.download),
  label: const Text('Download'),
)
```

---

## Full-width button

```dart
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {},
    child: const Text('Login'),
  ),
)
```

---

## Disabled button

```dart
ElevatedButton(
  onPressed: null,
  child: const Text('Submit'),
)
```

---

## Callback with arguments

```dart
ElevatedButton(
  onPressed: () {
    deleteItem(10);
  },
  child: const Text('Delete'),
)
```

---

## Styled button

```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    minimumSize: const Size(200, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  child: const Text('Continue'),
)
```

---

# 🎯 25. Key Takeaways

### `ElevatedButton`

> Use for important/primary actions.

### `OutlinedButton`

> Use for secondary actions that need a visible boundary.

### `TextButton`

> Use for low-emphasis actions.

### `IconButton`

> Use for compact icon-based actions.

### `FloatingActionButton`

> Use for a prominent action associated with a screen.

### `onPressed`

> Defines what happens when the button is activated.

### `onPressed: null`

> Disables the button.

### Callback

> A function passed to another component to be executed later.

### Most important callback rule

```dart
onPressed: login     // ✅ pass the function
```

```dart
onPressed: login()   // ❌ execute it immediately
```

For arguments:

```dart
onPressed: () => login(id)
```

or:

```dart
onPressed: () {
  login(id);
}
```

---

# 🧠 Final Mental Model

Don't think:

> **"Flutter has different button widgets that I need to memorize."**

Think:

```text
                    USER ACTION
                         │
                         ▼
                      BUTTON
                         │
              ┌──────────┴──────────┐
              │                     │
          Visual role           Callback
              │                     │
              ▼                     ▼
       Primary/Secondary       onPressed
       Icon/Screen action          │
                                   ▼
                                Your code
                                   │
                                   ▼
                                 Result
```

And the professional principle to remember is:

> **A button is not just a styled box. It is a semantic interactive component that connects user intent to application behavior.**

Once you understand that, buttons become much more than syntax—they become one of the fundamental building blocks for turning a static Flutter UI into a real application.
