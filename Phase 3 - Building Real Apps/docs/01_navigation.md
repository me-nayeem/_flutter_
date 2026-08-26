# 🟢 Phase 3 — Building Complete Apps

> **Goal:** Move from building individual UI components to building complete, multi-screen Flutter applications.

Phase 2 taught us how to **build the UI**. According to our roadmap, Phase 3 now begins with **Navigation**. 

---

# 1. Navigation in Flutter

## 📚 What Is Navigation?

In a real application, you rarely have everything on one screen.

For example, a simple notes app might have:

```text
Home Screen
    │
    ├──> Note Details
    │
    ├──> Create Note
    │
    └──> Settings
```

The user needs to move from one screen to another.

This movement between screens is called **navigation**.

In Flutter, navigation is primarily handled through the **`Navigator`**.

---

# 🧠 The Mental Model

Think of navigation like a **stack of screens**.

```text
┌─────────────────────┐
│   Home Screen       │
└─────────────────────┘
```

The user opens the profile:

```text
┌─────────────────────┐
│   Profile Screen    │  ← Current screen
├─────────────────────┤
│   Home Screen       │
└─────────────────────┘
```

Then opens settings:

```text
┌─────────────────────┐
│   Settings Screen   │  ← Current screen
├─────────────────────┤
│   Profile Screen    │
├─────────────────────┤
│   Home Screen       │
└─────────────────────┘
```

When the user presses **Back**:

```text
┌─────────────────────┐
│   Profile Screen    │  ← Current screen
├─────────────────────┤
│   Home Screen       │
└─────────────────────┘
```

The settings screen was removed from the top.

This is the fundamental idea behind Flutter's navigation system.

> **Navigation is largely about managing a stack of routes.**

---

# 2. What Is a Route?

A **route** represents a screen/page in Flutter's navigation system.

For example:

```text
HomePage
ProfilePage
SettingsPage
DetailsPage
```

can each be represented by a route.

Conceptually:

```text
Navigator
    │
    ├── HomePage
    ├── ProfilePage
    └── SettingsPage
```

The `Navigator` manages these routes.

---

# 3. The `Navigator`

The most important object in basic Flutter navigation is:

```dart
Navigator
```

It provides methods for moving between routes.

The two most important methods to understand first are:

```dart
Navigator.push()
Navigator.pop()
```

---

# 4. `Navigator.push()`

Use `push()` when you want to open another screen.

Example:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ProfilePage(),
  ),
);
```

Let's break this down.

### `Navigator.push()`

```dart
Navigator.push(...)
```

means:

> Add a new route to the navigation stack.

### `context`

```dart
context
```

tells Flutter **where in the widget tree this navigation operation is being requested**.

### `MaterialPageRoute`

```dart
MaterialPageRoute(...)
```

creates a Material-style route for the new page.

### `builder`

```dart
builder: (context) => const ProfilePage(),
```

tells Flutter which widget should be displayed by that route.

---

# 5. Complete Example

Suppose we have two screens.

## Home Screen

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          },
          child: const Text('Open Profile'),
        ),
      ),
    );
  }
}
```

## Profile Screen

```dart
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}
```

When the user taps:

```text
Open Profile
```

Flutter pushes `ProfilePage` onto the navigation stack.

---

# 6. What Actually Happens?

Initially:

```text
Navigator Stack

┌─────────────────┐
│    HomePage     │
└─────────────────┘
```

After:

```dart
Navigator.push(...)
```

the stack becomes:

```text
Navigator Stack

┌─────────────────┐
│   ProfilePage   │ ← Current
├─────────────────┤
│    HomePage     │
└─────────────────┘
```

The important point:

> **`push()` does not replace the current page. It puts a new route on top of it.**

That is why the user can return to the previous page.

---

# 7. `Navigator.pop()`

To go back, use:

```dart
Navigator.pop(context);
```

This removes the current route from the navigation stack.

For example:

```dart
ElevatedButton(
  onPressed: () {
    Navigator.pop(context);
  },
  child: const Text('Go Back'),
)
```

Before:

```text
┌─────────────────┐
│   ProfilePage   │ ← Current
├─────────────────┤
│    HomePage     │
└─────────────────┘
```

After:

```dart
Navigator.pop(context);
```

the stack becomes:

```text
┌─────────────────┐
│    HomePage     │ ← Current
└─────────────────┘
```

---

# 8. `push()` vs `pop()`

A very useful way to remember them:

| Method   | What it does              |
| -------- | ------------------------- |
| `push()` | Adds a route              |
| `pop()`  | Removes the current route |

Think:

```text
push → go forward
pop  → go backward
```

---

# 9. A Complete Navigation Flow

Consider:

```text
Home
 │
 │ push
 ▼
Profile
 │
 │ push
 ▼
Settings
```

The stack becomes:

```text
Settings
Profile
Home
```

Now:

```dart
Navigator.pop(context);
```

removes `Settings`.

```text
Profile
Home
```

Another `pop()`:

```text
Home
```

This is why navigation is commonly described using **stack terminology**.

---

# 10. Why Does Flutter Use a Stack?

The stack model naturally matches how users expect navigation to work.

Suppose you open:

```text
Home
 ↓
Products
 ↓
Product Details
```

The user expects the Back button to behave like:

```text
Product Details
      ↓ Back
Products
      ↓ Back
Home
```

A stack naturally gives us this behavior:

```text
┌────────────────────┐
│ Product Details    │
├────────────────────┤
│ Products           │
├────────────────────┤
│ Home               │
└────────────────────┘
```

---

# 11. `MaterialPageRoute`

One common way to create a route is:

```dart
MaterialPageRoute(
  builder: (context) => const ProfilePage(),
)
```

Example:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ProfilePage(),
  ),
);
```

The `builder` is important because Flutter creates the page through this callback.

You will commonly see:

```dart
builder: (context) => const ProfilePage()
```

rather than simply passing:

```dart
ProfilePage()
```

---

# 12. Why Use `const`?

If your page has a `const` constructor:

```dart
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // ...
}
```

you can create it with:

```dart
const ProfilePage()
```

So:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ProfilePage(),
  ),
);
```

Using `const` where appropriate helps Flutter identify objects that don't need to be recreated.

> Don't add `const` blindly. Understand what is actually compile-time constant.

---

# 13. Back Button in `AppBar`

When a page is pushed onto the navigation stack, Flutter's Material `AppBar` will commonly provide a back button automatically when appropriate.

For example:

```text
┌────────────────────────────────┐
│ ←   Profile                    │
├────────────────────────────────┤
│                                │
│       Profile Screen           │
│                                │
└────────────────────────────────┘
```

Pressing the back button generally results in the current route being popped.

You can also create your own back button:

```dart
IconButton(
  onPressed: () {
    Navigator.pop(context);
  },
  icon: const Icon(Icons.arrow_back),
)
```

---

# 14. `push()` Does Not Destroy the Previous Page

This is an important conceptual point.

When you do:

```dart
Navigator.push(...)
```

the previous route remains in the navigation stack.

For example:

```text
Home
 ↓
Profile
```

does **not** mean:

```text
Profile
```

replaced Home permanently.

Instead:

```text
Profile
Home
```

exists in the navigation stack.

That's why:

```dart
Navigator.pop(context);
```

can return to Home.

---

# 15. `pushReplacement()`

Sometimes you **don't want the user to return to the previous screen**.

For example:

```text
Login
  ↓
Home
```

After successfully logging in, you usually don't want pressing Back from Home to return to Login.

In such a case, you can use:

```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => const HomePage(),
  ),
);
```

Conceptually:

### Before

```text
Login
```

### After `pushReplacement()`

```text
Home
```

The Login route has been replaced.

---

# 16. `push()` vs `pushReplacement()`

| Method              | Behavior                   |
| ------------------- | -------------------------- |
| `push()`            | Adds a new route           |
| `pushReplacement()` | Replaces the current route |
| `pop()`             | Removes the current route  |

Think about it like this:

```text
push
────────────────
Home
 ↓
Profile

Stack:
Profile
Home
```

```text
pushReplacement
────────────────
Login
 ↓
Home

Stack:
Home
```

---

# 17. When Should You Use `pushReplacement()`?

A common use case:

### Authentication

```text
Login
   ↓ successful login
Home
```

You usually don't want:

```text
Home
 ↓ Back
Login
```

because the user has already authenticated.

Another example:

```text
Splash Screen
      ↓
    Home
```

Once initialization is complete, the splash screen generally shouldn't remain in the back stack.

---

# 18. A Professional Navigation Mental Model

When deciding which navigation method to use, ask:

> **Should the previous screen still exist in the back stack?**

### Yes

Use:

```dart
Navigator.push(...)
```

### No

Consider:

```dart
Navigator.pushReplacement(...)
```

### Want to go back?

Use:

```dart
Navigator.pop(...)
```

This simple question will help you choose the correct operation.

---

# 19. `canPop()`

Sometimes you want to know whether there is something available to pop.

You can check:

```dart
Navigator.canPop(context)
```

Example:

```dart
if (Navigator.canPop(context)) {
  Navigator.pop(context);
}
```

Conceptually:

```text
Home
```

There is nothing behind Home:

```text
canPop = false
```

But:

```text
Profile
Home
```

has something behind Profile:

```text
canPop = true
```

---

# 20. Returning Data from a Screen

Navigation isn't only about moving between screens.

A screen can also **return a result**.

For example:

```text
Home
  ↓
Select Color
  ↓
User selects Blue
  ↓
Back to Home
  ↓
Home receives Blue
```

We can later use:

```dart
Navigator.pop(context, selectedValue);
```

and receive that value from the previous screen.

For example:

```dart
final result = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const SelectionPage(),
  ),
);
```

We'll study **passing data and returning data between screens** in a dedicated upcoming topic.

For now, understand the concept:

> A route can return a value when it is popped.

---

# 21. Common Beginner Mistakes

## ❌ Mistake 1 — Forgetting `context`

Incorrect:

```dart
Navigator.push(
  MaterialPageRoute(
    builder: (context) => const ProfilePage(),
  ),
);
```

The basic `Navigator.push` call requires the appropriate `BuildContext`:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ProfilePage(),
  ),
);
```

---

## ❌ Mistake 2 — Using `pushReplacement()` everywhere

Don't replace routes simply because you can.

If the user should be able to return to the previous screen, use:

```dart
Navigator.push(...)
```

---

## ❌ Mistake 3 — Creating unnecessary navigation stacks

Imagine:

```text
Home
 ↓
Home
 ↓
Home
 ↓
Home
```

This can happen if you repeatedly push the same page instead of designing navigation properly.

Always think about what the navigation stack should represent.

---

## ❌ Mistake 4 — Putting navigation logic everywhere

Avoid scattering complicated navigation decisions throughout dozens of widgets.

As applications grow, navigation becomes part of your application's structure and should be organized intentionally.

We'll revisit this when we study **routes and application architecture**.

---

# 🔍 `Navigator` and `BuildContext`

You already learned `BuildContext` in Phase 2.

Now you're seeing one of its practical uses.

```dart
Navigator.push(
  context,
  ...
);
```

The context is associated with a location in the widget tree.

This allows Flutter to find the appropriate navigation infrastructure.

So the concepts you've already learned are beginning to connect:

```text
BuildContext
      │
      ├── Theme
      ├── MediaQuery
      └── Navigator
```

This is exactly why understanding `BuildContext` earlier was important.

---

# 🏗️ How a Professional Developer Thinks About Navigation

A beginner might think:

> "How do I open another screen?"

A professional developer asks:

> "What should the navigation stack look like after this user action?"

For example:

```text
User opens product
        ↓
Should Product Details
be added to the stack?
        ↓
Yes
        ↓
push()
```

But:

```text
User logs in
        ↓
Should Login remain
in the back stack?
        ↓
No
        ↓
pushReplacement()
```

This way of thinking becomes increasingly important as your application grows.

---

# 📊 Navigation Methods — Quick Reference

| Method              | Purpose                                   | Previous route remains? |
| ------------------- | ----------------------------------------- | ----------------------: |
| `push()`            | Open a new screen                         |                   ✅ Yes |
| `pop()`             | Go back                                   | ❌ Current route removed |
| `pushReplacement()` | Replace current screen                    |                    ❌ No |
| `canPop()`          | Check whether back navigation is possible |                       — |

---

# 🧠 Key Mental Model

Remember this:

```text
                 Navigator
                     │
              Navigation Stack
                     │
        ┌────────────┴────────────┐
        │                         │
      push                       pop
        │                         │
        ▼                         ▼
   Add a route              Remove a route
```

And:

```text
pushReplacement
       │
       ▼
Replace current route
```

---

# 🎯 What You Should Know After This Lesson

You should now understand:

* What navigation means
* What a route is
* What `Navigator` does
* The navigation stack
* `Navigator.push()`
* `Navigator.pop()`
* `Navigator.pushReplacement()`
* `Navigator.canPop()`
* `MaterialPageRoute`
* The role of `BuildContext`
* Why `push()` and `pushReplacement()` are different
* How the Back button relates to the navigation stack
* The basic idea of returning data from a route
* How a professional developer thinks about navigation

---

# 🧪 Practice

Build a small application with **three screens**:

```text
Home
  ↓
Profile
  ↓
Settings
```

Requirements:

### Home

Add a button:

```text
Open Profile
```

### Profile

Add:

```text
Open Settings
```

### Settings

Add:

```text
Go Back
```

The expected navigation behavior is:

```text
Home
  ↓ push
Profile
  ↓ push
Settings
  ↓ pop
Profile
  ↓ pop
Home
```

Then create another flow:

```text
Login
  ↓ pushReplacement
Home
```

Verify that pressing Back from Home **does not return to Login**.

---

# 🏁 Final Takeaway

> **Navigation is not simply "changing screens." It is managing the user's route history.**

The most important three operations for now are:

```dart
Navigator.push(...)
```

**Add a screen**

```dart
Navigator.pop(...)
```

**Go back**

```dart
Navigator.pushReplacement(...)
```

**Replace the current screen**

