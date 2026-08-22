# 🟢 Phase 2 — Topic 16: Text Fields

> **Text fields are interactive input widgets that allow users to enter, edit, and submit text.**

According to the roadmap, after **Buttons**, the next topic is **Text fields**, followed by Forms, Gestures, and Custom Widgets. 

Text fields are fundamental to almost every real-world Flutter application:

* Login
* Sign up
* Search
* Chat
* Profile editing
* Product search
* Notes
* Feedback
* Forms
* API requests

The key widget we'll study is:

```dart
TextField
```

---

# 📚 Table of Contents

1. [What is a TextField?](#-1-what-is-a-textfield)
2. [Basic TextField](#-2-basic-textfield)
3. [How TextField Works](#-3-how-textfield-works)
4. [TextEditingController](#-4-texteditingcontroller)
5. [Reading User Input](#-5-reading-user-input)
6. [Why Controllers Matter](#-6-why-controllers-matter)
7. [Initial Text](#-7-initial-text)
8. [Hint Text](#-8-hint-text)
9. [Label Text](#-9-label-text)
10. [TextField Decoration](#-10-textfield-decoration)
11. [OutlineInputBorder](#-11-outlineinputborder)
12. [Prefix and Suffix Icons](#-12-prefix-and-suffix-icons)
13. [Keyboard Types](#-13-keyboard-types)
14. [Password Fields](#-14-password-fields)
15. [maxLength and maxLines](#-15-maxlength-and-maxlines)
16. [onChanged](#-16-onchanged)
17. [onSubmitted](#-17-onsubmitted)
18. [FocusNode](#-18-focusnode)
19. [Moving Between Fields](#-19-moving-between-fields)
20. [TextField vs TextFormField](#-20-textfield-vs-textformfield)
21. [Common Mistakes](#-21-common-mistakes)
22. [Professional Best Practices](#-22-professional-best-practices)
23. [Real-World Login Example](#-23-real-world-login-example)
24. [Practice](#-24-practice)
25. [Knowledge Check](#-25-knowledge-check)
26. [Quick Reference](#-26-quick-reference)
27. [Key Takeaways](#-27-key-takeaways)

---

# 📚 1. What is a `TextField`?

`TextField` is a Flutter widget that allows the user to enter text.

The simplest example:

```dart
TextField()
```

Conceptually:

```text
┌──────────────────────────────┐
│                              │
│  Type something...           │
│                              │
└──────────────────────────────┘
```

The user can:

* Tap the field
* Type text
* Delete text
* Select text
* Copy/paste text
* Move the cursor
* Submit input

---

# 💻 2. Basic `TextField`

A simple example:

```dart
TextField(
  decoration: const InputDecoration(
    hintText: 'Enter your name',
  ),
)
```

Result:

```text
┌──────────────────────────────┐
│ Enter your name              │
└──────────────────────────────┘
```

As soon as the user starts typing:

```text
┌──────────────────────────────┐
│ Nayeem                       │
└──────────────────────────────┘
```

---

# 🧠 3. How `TextField` Works

Think about the flow:

```text
                 User
                  │
                  │ types
                  ▼
              TextField
                  │
                  ▼
          Text editing state
                  │
       ┌──────────┴──────────┐
       │                     │
       ▼                     ▼
   Controller            onChanged
       │                     │
       ▼                     ▼
 current text          react to changes
```

This distinction is important.

A `TextField` is the **UI**.

A `TextEditingController` is one way to **access and control its text**.

---

# 💻 4. `TextEditingController`

For serious usage, you'll often use:

```dart
TextEditingController
```

Example:

```dart
final nameController = TextEditingController();
```

Then:

```dart
TextField(
  controller: nameController,
)
```

Now the controller is connected to the text field.

Conceptually:

```text
TextField
    │
    │ connected to
    ▼
TextEditingController
    │
    ▼
Current text
```

---

# 🧠 Why do we need a controller?

Suppose the user enters:

```text
Nayeem
```

You may want your Dart code to access that value.

The controller gives you:

```dart
nameController.text
```

So:

```dart
print(nameController.text);
```

could output:

```text
Nayeem
```

---

# 💻 5. Reading User Input

Here's a complete small example:

```dart
class MyScreen extends StatelessWidget {
  MyScreen({super.key});

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: 'Enter your name',
          ),
        ),

        ElevatedButton(
          onPressed: () {
            print(nameController.text);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
```

The flow is:

```text
User types
    ↓
TextField
    ↓
Controller
    ↓
nameController.text
    ↓
Submit button
    ↓
Use the value
```

---

# ⚠️ Important: `TextEditingController` and Lifecycle

The previous example uses a controller inside a `StatelessWidget`, which is **not the recommended pattern for a real screen** because controllers are resources that should be disposed when no longer needed.

For a stateful screen:

```dart
class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: nameController,
    );
  }
}
```

This is the professional pattern.

---

# 🧠 6. Why Controllers Matter

A controller lets your code:

### Read the text

```dart
nameController.text
```

### Change the text

```dart
nameController.text = 'Nayeem';
```

### Clear the text

```dart
nameController.clear();
```

### Select text

The controller also exposes selection-related functionality.

### Listen for changes

A controller can have listeners:

```dart
nameController.addListener(() {
  print(nameController.text);
});
```

This is useful, although for simple reactive UI, `onChanged` is often easier.

---

# 💻 7. Initial Text

You can initialize a text field with a controller:

```dart
final controller = TextEditingController(
  text: 'Nayeem',
);
```

Then:

```dart
TextField(
  controller: controller,
)
```

The field initially contains:

```text
┌──────────────────────────────┐
│ Nayeem                       │
└──────────────────────────────┘
```

This is useful when editing existing data.

For example:

```text
Edit Profile
     ↓
Name field
     ↓
Existing name already displayed
```

---

# 💡 8. `hintText`

A hint tells the user what they should enter.

```dart
TextField(
  decoration: const InputDecoration(
    hintText: 'Enter your email',
  ),
)
```

Important:

> **Hint text disappears as the user enters text.**

Example:

Before typing:

```text
┌──────────────────────────────┐
│ Enter your email             │
└──────────────────────────────┘
```

After typing:

```text
┌──────────────────────────────┐
│ nayeem@example.com            │
└──────────────────────────────┘
```

---

# 💡 9. `labelText`

A label identifies the field.

```dart
TextField(
  decoration: const InputDecoration(
    labelText: 'Email',
  ),
)
```

Depending on the input decoration style, the label can move as the field receives focus or contains text.

Conceptually:

```text
Before focus:

┌──────────────────────────────┐
│ Email                        │
└──────────────────────────────┘


After focus:

┌─ Email ──────────────────────┐
│ nayeem@example.com           │
└──────────────────────────────┘
```

---

# 🧠 Hint vs Label

This distinction is important.

| Property    | Purpose                              |
| ----------- | ------------------------------------ |
| `hintText`  | Gives an example/instruction         |
| `labelText` | Identifies what the field represents |

For example:

```dart
InputDecoration(
  labelText: 'Email',
  hintText: 'you@example.com',
)
```

Here:

```text
Email
    ↓
What is this field?


you@example.com
    ↓
What kind of value should I enter?
```

---

# 🎨 10. TextField Decoration

`InputDecoration` controls much of the visual presentation of a text field.

Example:

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    hintText: 'Enter your email',
    border: OutlineInputBorder(),
  ),
)
```

Conceptually:

```text
┌─ Email ──────────────────────┐
│ Enter your email             │
└──────────────────────────────┘
```

Important properties include:

```dart
labelText
hintText
helperText
errorText
prefixIcon
suffixIcon
border
enabledBorder
focusedBorder
```

You'll use these constantly in real applications.

---

# 💻 11. `OutlineInputBorder`

A very common design:

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    border: OutlineInputBorder(),
  ),
)
```

Result:

```text
┌──────────────────────────────┐
│ Email                        │
│                              │
└──────────────────────────────┘
```

You can customize the radius:

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
)
```

Now:

```text
╭──────────────────────────────╮
│ Email                        │
╰──────────────────────────────╯
```

---

# 🔍 Focused Border

You can specify a different border when the field has focus:

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    border: const OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 2,
      ),
    ),
  ),
)
```

This gives you separate control over:

```text
Normal state
     ↓
border

Focused state
     ↓
focusedBorder
```

---

# 🧠 12. Prefix and Suffix Icons

You can add an icon before the text:

```dart
TextField(
  decoration: const InputDecoration(
    labelText: 'Email',
    prefixIcon: Icon(Icons.email),
    border: OutlineInputBorder(),
  ),
)
```

Conceptually:

```text
┌──────────────────────────────┐
│ ✉  Email                    │
│    Enter email               │
└──────────────────────────────┘
```

A suffix icon appears on the right:

```dart
TextField(
  decoration: const InputDecoration(
    labelText: 'Search',
    suffixIcon: Icon(Icons.search),
    border: OutlineInputBorder(),
  ),
)
```

---

# 💡 Real-World Example

Search field:

```dart
TextField(
  decoration: InputDecoration(
    hintText: 'Search products',
    prefixIcon: const Icon(Icons.search),
    suffixIcon: IconButton(
      onPressed: () {},
      icon: const Icon(Icons.clear),
    ),
    border: const OutlineInputBorder(),
  ),
)
```

Now the field contains:

```text
┌─────────────────────────────────┐
│ 🔍 Search products           ✕ │
└─────────────────────────────────┘
```

Notice:

```text
prefixIcon → decoration
suffixIcon → decoration
```

And the suffix icon can itself be interactive.

---

# ⌨️ 13. Keyboard Types

Different input requires different keyboards.

Flutter provides:

```dart
keyboardType
```

For example:

### Email

```dart
TextField(
  keyboardType: TextInputType.emailAddress,
)
```

### Number

```dart
TextField(
  keyboardType: TextInputType.number,
)
```

### Phone

```dart
TextField(
  keyboardType: TextInputType.phone,
)
```

### URL

```dart
TextField(
  keyboardType: TextInputType.url,
)
```

### Multiline text

```dart
TextField(
  keyboardType: TextInputType.multiline,
)
```

The exact keyboard presentation is platform-dependent.

The important idea is:

> **Tell the platform what kind of input you expect.**

This improves the user experience.

---

# 🔐 14. Password Fields

For passwords, you usually don't want the entered characters displayed directly.

Use:

```dart
obscureText: true
```

Example:

```dart
TextField(
  obscureText: true,
  decoration: const InputDecoration(
    labelText: 'Password',
    border: OutlineInputBorder(),
  ),
)
```

The input is visually obscured:

```text
┌──────────────────────────────┐
│ Password                     │
│ •••••••••                    │
└──────────────────────────────┘
```

---

# 💡 Password Visibility Toggle

A common UI pattern is:

```text
┌──────────────────────────────┐
│ Password                 👁  │
└──────────────────────────────┘
```

You can implement this using state.

For example:

```dart
bool obscurePassword = true;
```

Then:

```dart
TextField(
  obscureText: obscurePassword,
  decoration: InputDecoration(
    labelText: 'Password',
    border: const OutlineInputBorder(),
    suffixIcon: IconButton(
      onPressed: () {
        setState(() {
          obscurePassword = !obscurePassword;
        });
      },
      icon: Icon(
        obscurePassword
            ? Icons.visibility
            : Icons.visibility_off,
      ),
    ),
  ),
)
```

This is an excellent example of how:

```text
TextField
   +
Button
   +
State
```

work together.

You'll understand this much more deeply when we study `setState`.

---

# 📏 15. `maxLength` and `maxLines`

You can limit how many characters a user enters:

```dart
TextField(
  maxLength: 50,
)
```

For example:

```text
Maximum: 50 characters
```

---

## Single-line field

By default:

```dart
TextField()
```

is generally single-line.

---

## Multiline field

For a description:

```dart
TextField(
  maxLines: 5,
  decoration: const InputDecoration(
    labelText: 'Description',
    border: OutlineInputBorder(),
  ),
)
```

Conceptually:

```text
╭──────────────────────────────╮
│ Description                  │
│                              │
│                              │
│                              │
│                              │
╰──────────────────────────────╯
```

This is useful for:

* Notes
* Comments
* Feedback
* Descriptions
* Messages

---

# 🧠 `maxLines` vs `minLines`

You can control the minimum and maximum number of lines.

For example:

```dart
TextField(
  minLines: 3,
  maxLines: 5,
)
```

The field can grow within that range as appropriate.

---

# 🔄 16. `onChanged`

`onChanged` runs whenever the text changes.

Example:

```dart
TextField(
  onChanged: (value) {
    print(value);
  },
)
```

If the user types:

```text
H
He
Hel
Hell
Hello
```

the callback receives the updated value each time.

Conceptually:

```text
User types
    ↓
TextField changes
    ↓
onChanged(value)
    ↓
Your code reacts
```

---

# 💡 Example: Live Character Count

```dart
TextField(
  maxLength: 100,
  onChanged: (value) {
    print('Characters: ${value.length}');
  },
)
```

This pattern is useful for:

* Search
* Character counters
* Live filtering
* Enabling/disabling actions
* Instant UI updates

---

# 🧠 `onChanged` vs Controller

Both can give you access to text, but they serve different purposes.

### `onChanged`

Use when you want to **react immediately** to changes.

```dart
onChanged: (value) {
  searchProducts(value);
}
```

### Controller

Use when you need to **read, modify, clear, initialize, or otherwise control** the text.

```dart
controller.clear();
```

A real application may use both.

---

# ⌨️ 17. `onSubmitted`

`onSubmitted` runs when the user submits the field, typically through the keyboard's action button.

Example:

```dart
TextField(
  onSubmitted: (value) {
    print('Submitted: $value');
  },
)
```

This is particularly useful for search:

```dart
TextField(
  onSubmitted: (query) {
    searchProducts(query);
  },
)
```

The flow:

```text
User enters search
       ↓
Presses keyboard search/submit
       ↓
onSubmitted(query)
       ↓
Perform search
```

---

# 🧠 `onChanged` vs `onSubmitted`

| Callback      | When it runs                    |
| ------------- | ------------------------------- |
| `onChanged`   | Every time text changes         |
| `onSubmitted` | When the user submits the field |

Example:

```dart
onChanged: (value) {
  // React to every change
}
```

versus:

```dart
onSubmitted: (value) {
  // React when submitted
}
```

---

# 🎯 18. `FocusNode`

Now we move into a slightly deeper but very important concept.

A `FocusNode` represents the focus state of an input or another focusable widget.

Example:

```dart
final emailFocusNode = FocusNode();
```

Then:

```dart
TextField(
  focusNode: emailFocusNode,
)
```

You can programmatically request focus:

```dart
emailFocusNode.requestFocus();
```

And remove focus:

```dart
emailFocusNode.unfocus();
```

---

# 🧠 What is focus?

Focus determines:

> **Which input currently receives keyboard input.**

For example:

```text
Email field
     ↓
focused
     ↓
Keyboard input goes here
```

Then:

```text
Password field
     ↓
focused
     ↓
Keyboard input goes here
```

---

# ⚠️ FocusNode Lifecycle

Just like `TextEditingController`, a `FocusNode` should be disposed when you're finished with it.

In a `StatefulWidget`:

```dart
final emailFocusNode = FocusNode();

@override
void dispose() {
  emailFocusNode.dispose();
  super.dispose();
}
```

This is an important professional habit.

---

# ➡️ 19. Moving Between Fields

Imagine:

```text
Email
  ↓
Password
  ↓
Login
```

You can control focus.

For example:

```dart
final emailFocusNode = FocusNode();
final passwordFocusNode = FocusNode();
```

Then:

```dart
TextField(
  focusNode: emailFocusNode,
  onSubmitted: (_) {
    passwordFocusNode.requestFocus();
  },
)
```

And:

```dart
TextField(
  focusNode: passwordFocusNode,
)
```

Now pressing submit from the email field moves focus to the password field.

This creates a much better form experience.

---

# 💻 A Better Approach: `textInputAction`

You can also tell the keyboard what action to display:

```dart
TextField(
  textInputAction: TextInputAction.next,
)
```

For the final field:

```dart
TextField(
  textInputAction: TextInputAction.done,
)
```

Common actions include:

```text
next
done
search
send
go
```

Example:

```dart
TextField(
  keyboardType: TextInputType.emailAddress,
  textInputAction: TextInputAction.next,
)
```

This communicates your intended input flow to the platform.

---

# 🧠 20. `TextField` vs `TextFormField`

This distinction is extremely important.

### `TextField`

Use for a standalone text input.

```dart
TextField()
```

### `TextFormField`

Use when the field is part of a Flutter `Form` and you need form-oriented behavior such as validation.

```dart
TextFormField()
```

Example:

```text
Simple input
     ↓
TextField


Form + validation
     ↓
TextFormField
```

Since **Forms** are the next topic after text fields in your roadmap, we'll go much deeper into `TextFormField` and validation in the next lesson. 

For now:

> Don't confuse a `TextField` with a complete form system.

---

# ⚠️ 21. Common Mistakes

## ❌ Mistake 1 — Creating controllers and never disposing them

If you create:

```dart
final controller = TextEditingController();
```

in a stateful screen, dispose it:

```dart
@override
void dispose() {
  controller.dispose();
  super.dispose();
}
```

---

## ❌ Mistake 2 — Using `hintText` as the only field identification

For important forms, a clear label is often preferable:

```dart
InputDecoration(
  labelText: 'Email',
  hintText: 'you@example.com',
)
```

This keeps the field's meaning clear even after text is entered.

---

## ❌ Mistake 3 — Using the wrong keyboard type

For email:

```dart
keyboardType: TextInputType.emailAddress,
```

For phone:

```dart
keyboardType: TextInputType.phone,
```

For numbers:

```dart
keyboardType: TextInputType.number,
```

Give users a keyboard appropriate for the input.

---

## ❌ Mistake 4 — Storing sensitive input carelessly

Passwords and other sensitive data should be handled carefully.

For password input:

```dart
obscureText: true
```

Also avoid casually logging passwords:

```dart
print(passwordController.text); // ❌ avoid
```

---

## ❌ Mistake 5 — Putting huge logic inside `onChanged`

Avoid:

```dart
onChanged: (value) {
  // 100 lines of business logic
}
```

Instead:

```dart
onChanged: searchProducts,
```

and keep the logic in an appropriate method/service/state layer.

---

## ❌ Mistake 6 — Creating a controller inside `build()`

Don't do:

```dart
@override
Widget build(BuildContext context) {
  final controller = TextEditingController(); // ❌
  
  return TextField(
    controller: controller,
  );
}
```

Why?

`build()` can run many times.

You would repeatedly create controllers and lose proper lifecycle management.

Create the controller as a state field instead.

---

# 🚀 22. Professional Best Practices

### 1. Use controllers when you need programmatic access

```dart
final emailController = TextEditingController();
```

---

### 2. Dispose controllers

```dart
@override
void dispose() {
  emailController.dispose();
  super.dispose();
}
```

---

### 3. Use meaningful labels

Prefer:

```dart
labelText: 'Email'
```

over vague text such as:

```dart
labelText: 'Input'
```

---

### 4. Match the keyboard to the data

```text
Email → emailAddress
Phone → phone
Number → number
URL → url
```

---

### 5. Use `TextFormField` for forms

When you need:

* validation
* form state
* saving
* resetting

you'll generally move toward:

```dart
Form
+
TextFormField
```

---

### 6. Keep input handling separate from business logic

Instead of:

```dart
onChanged: (value) {
  // API call
  // database logic
  // business rules
  // UI updates
}
```

prefer a cleaner structure:

```dart
onChanged: searchProducts,
```

and handle the actual work elsewhere.

---

### 7. Think about focus

A polished form should have a logical keyboard flow:

```text
First field
    ↓
Next
    ↓
Next
    ↓
Done
```

---

# 🏗️ 23. Real-World Login Example

Let's combine what you've learned.

```dart
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    final email = emailController.text;
    final password = passwordController.text;

    print('Login requested');
    print('Email: $email');

    // Don't print passwords in real applications.
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'you@example.com',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: passwordController,
            obscureText: true,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: login,
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
```

The architecture of this small UI is:

```text
LoginScreen
│
├── Email TextField
│     ├── Controller
│     ├── Keyboard configuration
│     └── Decoration
│
├── Password TextField
│     ├── Controller
│     ├── obscureText
│     └── Decoration
│
└── Login Button
      │
      └── login()
```

This is already much closer to a real application than a collection of isolated examples.

---

# 🧠 A Professional Mental Model

When designing a text field, don't simply ask:

> "What properties does TextField have?"

Ask:

```text
What data am I collecting?
          ↓
What keyboard should appear?
          ↓
What should the user see?
          ↓
How should the input look?
          ↓
Do I need to access the value?
          ↓
Do I need to react to changes?
          ↓
Does the field need validation?
          ↓
How should focus move?
          ↓
What happens when the user submits?
```

This mindset will make your forms much better.

---

# 🧪 24. Practice

## 🟢 Beginner — Name Field

Create a text field that:

* accepts a name
* has a label
* has a hint
* has a person icon
* prints the entered name when a button is pressed

---

## 🟢 Beginner — Search Field

Build:

```text
┌─────────────────────────────────┐
│ 🔍 Search products              │
└─────────────────────────────────┘
```

Requirements:

* `TextField`
* `prefixIcon`
* `hintText`
* `onChanged`
* `onSubmitted`

Print the search query.

---

## 🟡 Intermediate — Registration Fields

Create:

```text
Name
Email
Phone
Password
Confirm Password
```

Each should have an appropriate:

* keyboard type
* icon
* label
* hint

Password fields should obscure the text.

---

## 🟡 Intermediate — Password Visibility

Create a password field with:

```text
┌──────────────────────────────┐
│ Password                 👁  │
└──────────────────────────────┘
```

When the icon is tapped:

```text
obscured
   ↕
visible
```

Use:

```dart
bool obscurePassword = true;
```

and update it with `setState`.

---

# 🔴 Challenge — Login UI

Build a complete login UI:

```text
        Welcome Back

┌──────────────────────────────┐
│ ✉  Email                     │
└──────────────────────────────┘

┌──────────────────────────────┐
│ 🔒 Password              👁  │
└──────────────────────────────┘

┌──────────────────────────────┐
│            Login             │
└──────────────────────────────┘

       Forgot Password?

          Sign Up
```

Requirements:

* `TextField`
* `TextEditingController`
* `InputDecoration`
* `prefixIcon`
* `suffixIcon`
* `obscureText`
* `ElevatedButton`
* `TextButton`
* proper spacing
* proper controller disposal

Don't worry about authentication yet.

Focus on building clean UI and handling input correctly.

---

# 🧠 25. Knowledge Check

Before moving to Forms, make sure you can explain:

1. What is `TextField`?
2. What does `TextEditingController` do?
3. How do you read the current text?
4. How do you clear a text field?
5. Why should controllers be disposed?
6. What's the difference between `hintText` and `labelText`?
7. What is `InputDecoration`?
8. What does `OutlineInputBorder` do?
9. What is `prefixIcon`?
10. What is `suffixIcon`?
11. How do you create a password field?
12. What does `obscureText` do?
13. What does `keyboardType` do?
14. What's the difference between `onChanged` and `onSubmitted`?
15. What is `FocusNode`?
16. Why should `FocusNode` be disposed?
17. How can you move focus from one field to another?
18. What's the difference between `TextField` and `TextFormField`?
19. Why shouldn't you create a `TextEditingController` inside `build()`?
20. When should you use a controller instead of only `onChanged`?

---

# 📌 26. Quick Reference

## Basic TextField

```dart
TextField(
  decoration: const InputDecoration(
    hintText: 'Enter your name',
  ),
)
```

---

## Controller

```dart
final controller = TextEditingController();

TextField(
  controller: controller,
)
```

Read:

```dart
controller.text
```

Clear:

```dart
controller.clear();
```

---

## Label + Hint

```dart
TextField(
  decoration: const InputDecoration(
    labelText: 'Email',
    hintText: 'you@example.com',
  ),
)
```

---

## Outlined Field

```dart
TextField(
  decoration: const InputDecoration(
    labelText: 'Email',
    border: OutlineInputBorder(),
  ),
)
```

---

## Prefix Icon

```dart
TextField(
  decoration: const InputDecoration(
    prefixIcon: Icon(Icons.email),
  ),
)
```

---

## Password

```dart
TextField(
  obscureText: true,
)
```

---

## Email Keyboard

```dart
TextField(
  keyboardType: TextInputType.emailAddress,
)
```

---

## Number Keyboard

```dart
TextField(
  keyboardType: TextInputType.number,
)
```

---

## Multiline

```dart
TextField(
  maxLines: 5,
)
```

---

## React to changes

```dart
TextField(
  onChanged: (value) {
    print(value);
  },
)
```

---

## React to submission

```dart
TextField(
  onSubmitted: (value) {
    print(value);
  },
)
```

---

## Focus

```dart
final focusNode = FocusNode();

TextField(
  focusNode: focusNode,
)
```

Request focus:

```dart
focusNode.requestFocus();
```

Remove focus:

```dart
focusNode.unfocus();
```

Dispose:

```dart
focusNode.dispose();
```

---

# 🎯 27. Key Takeaways

### `TextField`

> The basic Flutter widget for user text input.

### `TextEditingController`

> Gives your Dart code programmatic access to the field's text and editing state.

### `InputDecoration`

> Controls the visual presentation and supporting information around the input.

### `labelText`

> Identifies the field.

### `hintText`

> Gives the user an example or instruction.

### `prefixIcon`

> Displays an icon before the input.

### `suffixIcon`

> Displays an icon/action after the input.

### `obscureText`

> Visually hides sensitive text such as passwords.

### `keyboardType`

> Helps provide an appropriate input keyboard.

### `onChanged`

> Runs whenever the input changes.

### `onSubmitted`

> Runs when the user submits the input.

### `FocusNode`

> Controls and observes keyboard focus.

### `TextField` vs `TextFormField`

```text
TextField
   ↓
Standalone text input

TextFormField
   ↓
Text input integrated with Form/validation
```

---

# 🧠 Final Mental Model

The most important thing to understand is that a text field is not simply:

```text
"Box where user types."
```

Think of it as:

```text
                       USER
                         │
                         │ types
                         ▼
                    TextField
                         │
          ┌──────────────┼──────────────┐
          │              │              │
          ▼              ▼              ▼
     Controller      onChanged      onSubmitted
          │              │              │
          ▼              ▼              ▼
     Read/control     React live     Submit action
          │
          ▼
     Application state
```

And around the input:

```text
TextField
   │
   └── InputDecoration
        ├── label
        ├── hint
        ├── prefix icon
        ├── suffix icon
        ├── border
        └── focused state
```

> **Professional principle:** A good text field doesn't just collect text. It guides the user, communicates what input is expected, provides appropriate keyboard/focus behavior, and cleanly transfers that input into the application's state or business logic.

The next topic in the roadmap is **Forms**, where `TextField` evolves into a proper form system with **`Form`, `TextFormField`, validation, saving, resetting, and error handling**. 
