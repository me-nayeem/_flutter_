# 🟢 Phase 3 — Building Complete Apps

# 2. Routes in Flutter

> **Goal:** Understand what routes are, how Flutter manages them, and how to organize navigation as your application grows.

In the previous lesson, we learned:

```text
Navigator
   │
   ├── push()            → add a screen
   ├── pop()             → remove current screen
   └── pushReplacement() → replace current screen
```

Now we go one level deeper:

> **How should we define and organize those screens/routes?**

---

# 🧠 1. What Is a Route?

A **route** represents a screen or destination in your application.

For example:

```text
Home
Profile
Settings
Product Details
Login
```

can all be destinations that users navigate to.

A simple navigation flow might look like:

```text
┌──────────┐
│   Home   │
└────┬─────┘
     │
     ▼
┌──────────┐
│ Profile  │
└────┬─────┘
     │
     ▼
┌──────────┐
│ Settings │
└──────────┘
```

Each destination is represented by a route.

---

# 2. Two Important Navigation Approaches

In Flutter, you'll encounter two broad approaches:

### Approach 1 — Direct route creation

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ProfilePage(),
  ),
);
```

### Approach 2 — Named routes

Instead of directly specifying the page:

```dart
ProfilePage()
```

you navigate using a route name:

```dart
'/profile'
```

For example:

```dart
Navigator.pushNamed(
  context,
  '/profile',
);
```

We'll learn both, but it's important to understand **when each approach makes sense**.

---

# 3. Direct Routes

This is what we used in the previous lesson:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ProfilePage(),
  ),
);
```

The navigation code directly knows about:

```dart
ProfilePage
```

So the relationship is:

```text
Button
  ↓
Navigator
  ↓
MaterialPageRoute
  ↓
ProfilePage
```

This is simple and very useful for learning Flutter.

---

# 4. Named Routes

Named routes give destinations a string identifier.

For example:

```text
/           → Home
/profile    → Profile
/settings   → Settings
/login      → Login
```

Then you can navigate using:

```dart
Navigator.pushNamed(
  context,
  '/profile',
);
```

Instead of:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ProfilePage(),
  ),
);
```

---

# 5. Defining Named Routes

Named routes are commonly configured inside `MaterialApp`.

Example:

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const HomePage(),
    '/profile': (context) => const ProfilePage(),
    '/settings': (context) => const SettingsPage(),
  },
);
```

Now Flutter knows:

```text
'/'          → HomePage
'/profile'   → ProfilePage
'/settings'  → SettingsPage
```

---

# 6. Complete Example

Let's create three pages.

## `main.dart`

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
```

---

# 7. Home Page

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
            Navigator.pushNamed(
              context,
              '/profile',
            );
          },
          child: const Text('Open Profile'),
        ),
      ),
    );
  }
}
```

Notice the difference.

We aren't writing:

```dart
MaterialPageRoute(...)
```

Instead:

```dart
Navigator.pushNamed(
  context,
  '/profile',
);
```

Flutter looks up the route named:

```text
/profile
```

and opens the page associated with it.

---

# 8. Profile Page

```dart
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/settings',
            );
          },
          child: const Text('Open Settings'),
        ),
      ),
    );
  }
}
```

---

# 9. Settings Page

```dart
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}
```

The navigation flow becomes:

```text
Home
 │
 │ pushNamed('/profile')
 ▼
Profile
 │
 │ pushNamed('/settings')
 ▼
Settings
```

---

# 10. `initialRoute`

You may have noticed:

```dart
initialRoute: '/',
```

This tells Flutter which named route should be displayed when the application starts.

For example:

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const HomePage(),
    '/profile': (context) => const ProfilePage(),
  },
);
```

The application starts at:

```text
/
↓
HomePage
```

---

# 11. Route Names

A common convention is:

```text
/
 /login
 /home
 /profile
 /settings
 /products
 /product-details
```

For example:

```dart
routes: {
  '/': (context) => const HomePage(),
  '/login': (context) => const LoginPage(),
  '/profile': (context) => const ProfilePage(),
  '/settings': (context) => const SettingsPage(),
}
```

The route names should be:

* Consistent
* Easy to understand
* Predictable
* Meaningful

---

# 12. `home` vs `initialRoute`

You may wonder why we sometimes write:

```dart
MaterialApp(
  home: const HomePage(),
)
```

and other times:

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const HomePage(),
  },
)
```

Both can define the initial destination.

### Simple application

You can use:

```dart
MaterialApp(
  home: const HomePage(),
)
```

### Named-route setup

You can use:

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const HomePage(),
  },
)
```

For our learning, understand both.

---

# ⚠️ Important: Don't Mix `home` and `initialRoute` Unnecessarily

Avoid casually doing:

```dart
MaterialApp(
  home: const HomePage(),
  initialRoute: '/',
  routes: {
    '/': (context) => const HomePage(),
  },
);
```

You are defining multiple mechanisms for the initial route.

Prefer one clear approach.

---

# 13. `Navigator.pushNamed()`

The basic syntax is:

```dart
Navigator.pushNamed(
  context,
  '/profile',
);
```

Meaning:

```text
Find the route named "/profile"
        ↓
Create/navigate to that route
        ↓
Push it onto the navigation stack
```

So:

```dart
pushNamed()
```

is essentially the named-route counterpart to:

```dart
push()
```

---

# 14. `Navigator.pop()`

Named routes don't change how going back works.

You still use:

```dart
Navigator.pop(context);
```

For example:

```text
Home
 ↓
Profile
 ↓
Settings
```

After:

```dart
Navigator.pop(context);
```

you get:

```text
Home
 ↓
Profile
```

The route name doesn't change the fundamental stack behavior.

---

# 15. Passing Data with Named Routes

Sometimes you need to open a screen **and send data to it**.

For example:

```text
Product List
      ↓
Product Details
      ↓
Product ID = 42
```

With named routes, you can pass arguments.

Example:

```dart
Navigator.pushNamed(
  context,
  '/details',
  arguments: 42,
);
```

Here:

```text
42
```

is passed as route arguments.

---

# 16. Receiving Route Arguments

Inside the destination page, you can access:

```dart
final productId =
    ModalRoute.of(context)!.settings.arguments;
```

For example:

```dart
class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Center(
        child: Text(
          'Product ID: $productId',
        ),
      ),
    );
  }
}
```

If we navigate using:

```dart
Navigator.pushNamed(
  context,
  '/details',
  arguments: 42,
);
```

the page can receive:

```text
Product ID: 42
```

---

# 17. Passing an Object

You're not limited to primitive values.

You can pass a Dart object.

For example:

```dart
class Product {
  final int id;
  final String name;

  const Product({
    required this.id,
    required this.name,
  });
}
```

Create:

```dart
const product = Product(
  id: 42,
  name: 'Laptop',
);
```

Then:

```dart
Navigator.pushNamed(
  context,
  '/details',
  arguments: product,
);
```

The destination can retrieve the object.

```dart
final product =
    ModalRoute.of(context)!.settings.arguments as Product;
```

Now you have:

```dart
product.id
product.name
```

---

# 18. Why Passing Objects Is Useful

Imagine a shopping app:

```text
Product List
    │
    ├── Product A
    ├── Product B
    └── Product C
```

When the user taps Product B:

```text
Product B
    ↓
Details Page
```

You might pass:

```dart
Product(
  id: 2,
  name: 'Keyboard',
)
```

instead of passing every field separately.

This becomes especially useful as models become more complex.

---

# 19. Route Arguments: A Potential Problem

There is something important to notice.

This:

```dart
final product =
    ModalRoute.of(context)!.settings.arguments as Product;
```

assumes that the argument is definitely a `Product`.

If somebody accidentally navigates like this:

```dart
Navigator.pushNamed(
  context,
  '/details',
  arguments: 100,
);
```

then the cast:

```dart
as Product
```

will fail.

This is one reason modern Flutter applications often use more structured routing approaches when applications become complex.

For now, understand the concept rather than trying to eliminate every limitation.

---

# 20. Named Routes vs Direct Routes

Let's compare them.

### Direct route

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ProfilePage(),
  ),
);
```

### Named route

```dart
Navigator.pushNamed(
  context,
  '/profile',
);
```

---

## Comparison

| Feature                     | Direct Route                  | Named Route                       |
| --------------------------- | ----------------------------- | --------------------------------- |
| Easy to learn               | ⭐⭐⭐⭐⭐                         | ⭐⭐⭐⭐                              |
| Explicit destination        | ✅                             | Less explicit                     |
| Simple apps                 | Excellent                     | Good                              |
| Central route configuration | ❌                             | ✅                                 |
| Passing arguments           | Directly possible             | Via route arguments               |
| Large-app routing           | May become harder to organize | Can become cumbersome too         |
| Modern Flutter apps         | Still useful                  | Not always the preferred approach |

---

# 21. Which One Should You Use?

For small applications, both can work.

### Use direct navigation when:

```text
A screen directly knows where it needs to go
```

Example:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const DetailsPage(),
  ),
);
```

### Named routes can be useful when:

```text
You want a centralized collection
of simple route destinations.
```

Example:

```dart
routes: {
  '/login': ...,
  '/home': ...,
  '/settings': ...,
}
```

---

# 🧠 Important Professional Perspective

Don't make this mistake:

> "Named routes are more professional, therefore every application must use them."

That's not how good engineering works.

The correct question is:

> **What routing approach best fits the application's requirements?**

Modern Flutter applications can also use more advanced routing solutions, especially when dealing with:

* Deep linking
* Authentication redirects
* Nested navigation
* Complex navigation flows
* Web URLs
* Shell routes
* Declarative navigation

We'll encounter these concepts later.

For now, master the fundamentals first.

---

# 22. A Useful Architecture

As applications grow, you don't want this:

```text
main.dart
 ├── HomePage
 ├── ProfilePage
 ├── SettingsPage
 ├── LoginPage
 ├── ProductPage
 ├── ...
```

Instead, you might organize your project like:

```text
lib/
│
├── main.dart
│
├── app/
│   └── app.dart
│
├── routes/
│   └── app_routes.dart
│
├── features/
│   ├── home/
│   ├── profile/
│   └── settings/
│
└── shared/
```

**Don't implement this structure just because you saw it here.**

We'll study application architecture properly in **Phase 6**.

For now, understand the principle:

> As an application grows, navigation configuration should remain organized and maintainable.

---

# 23. A Common Beginner Mistake

Don't create route names like:

```text
'/page1'
'/page2'
'/page3'
```

These names tell you nothing.

Prefer:

```text
'/login'
'/home'
'/profile'
'/settings'
'/products'
```

The route name should communicate its purpose.

---

# 24. Navigation Flow Example

Consider a simple shopping application:

```text
                    ┌─────────────┐
                    │    Home     │
                    └──────┬──────┘
                           │
                           ▼
                    ┌─────────────┐
                    │  Products   │
                    └──────┬──────┘
                           │
                           ▼
                    ┌─────────────┐
                    │   Details   │
                    └─────────────┘
```

Routes:

```dart
routes: {
  '/': (context) => const HomePage(),
  '/products': (context) => const ProductsPage(),
  '/details': (context) => const DetailsPage(),
}
```

Navigation:

```dart
Navigator.pushNamed(
  context,
  '/products',
);
```

Then:

```dart
Navigator.pushNamed(
  context,
  '/details',
);
```

The stack:

```text
Details
Products
Home
```

---

# 25. Returning Data — Preview

Earlier we mentioned that a screen can return a value.

With named navigation, the same general idea applies.

A screen can do:

```dart
Navigator.pop(
  context,
  selectedValue,
);
```

The previous screen can wait for the result.

Conceptually:

```text
Home
 │
 │ open selector
 ▼
Selector
 │
 │ selected "Dark"
 ▼
Home
 │
 └── receives "Dark"
```

We'll study this properly in the **Passing Data Between Screens** topic.

---

# ⚠️ Common Mistakes

### ❌ Mistake 1: Wrong route name

Defined:

```dart
'/profile'
```

but navigating to:

```dart
'/profiles'
```

These are different strings.

---

### ❌ Mistake 2: Forgetting to register the route

You call:

```dart
Navigator.pushNamed(
  context,
  '/settings',
);
```

but never define:

```dart
'/settings'
```

inside your route configuration.

Flutter won't know how to resolve that route.

---

### ❌ Mistake 3: Using route names as magic strings everywhere

For a larger application, repeatedly writing:

```dart
'/profile'
```

throughout your code can become error-prone.

Later, you can centralize route names.

For example:

```dart
class AppRoutes {
  static const home = '/';
  static const profile = '/profile';
  static const settings = '/settings';
}
```

Then:

```dart
Navigator.pushNamed(
  context,
  AppRoutes.profile,
);
```

This is a useful organizational technique, but don't over-engineer a small application.

---

# 🧩 The Bigger Picture

So far:

```text
Phase 2
   │
   └── Built UI
          ↓
Phase 3
   │
   ├── Navigation
   │
   ├── Routes
   │
   ├── Passing Data
   │
   └── State
```

We're gradually moving from:

> **"How do I build this widget?"**

to:

> **"How do I build an application?"**

That's the major purpose of Phase 3.

---

# 📊 Quick Reference

### Define routes

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const HomePage(),
    '/profile': (context) => const ProfilePage(),
    '/settings': (context) => const SettingsPage(),
  },
);
```

### Navigate

```dart
Navigator.pushNamed(
  context,
  '/profile',
);
```

### Go back

```dart
Navigator.pop(context);
```

### Pass arguments

```dart
Navigator.pushNamed(
  context,
  '/details',
  arguments: product,
);
```

### Read arguments

```dart
final product =
    ModalRoute.of(context)!.settings.arguments;
```

---

# 🧪 Practice Task

Create a small app with these routes:

```text
/
├── /profile
├── /settings
└── /about
```

Configure them inside `MaterialApp`.

### Home

Create buttons:

```text
[ Profile ]
[ Settings ]
[ About ]
```

Each button should navigate using:

```dart
Navigator.pushNamed(...)
```

### Profile

Show:

```text
Profile Screen
```

and navigate back using:

```dart
Navigator.pop(context);
```

### Settings

Show:

```text
Settings Screen
```

### About

Show:

```text
About Screen
```

---

# 🎯 What You Should Understand

After this lesson, you should be able to explain:

* What a route is
* What named routes are
* How `MaterialApp.routes` works
* `initialRoute`
* `Navigator.pushNamed()`
* `Navigator.pop()`
* Route names
* Passing arguments through named routes
* Reading route arguments
* Direct routes vs named routes
* Why route organization matters
* Why named routes aren't automatically the best solution for every application

---

# 🔑 Final Mental Model

Remember:

```text
                MaterialApp
                    │
              Route Configuration
                    │
        ┌───────────┼───────────┐
        ▼           ▼           ▼
       '/'       '/profile'  '/settings'
        │           │           │
        ▼           ▼           ▼
      Home       Profile      Settings
                    │
                    ▼
               Navigator
                    │
          ┌─────────┴─────────┐
          ▼                   ▼
       pushNamed             pop
          │                   │
       go forward          go backward
```

> **Routes define where the user can go. The Navigator controls how the user moves between those destinations.**

---

## ⏭️ Next Topic

### **3. Passing Data Between Screens**

We'll learn how to send:

```text
Screen A
   │
   │ String / int / object
   ▼
Screen B
```

and also how to return data:

```text
Screen B
   │
   │ result
   ▼
Screen A
```

This is a **very important Flutter skill**, because real applications constantly pass data between screens.
