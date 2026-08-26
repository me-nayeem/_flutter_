# 🟢 Phase 3 — Building Complete Apps

# 3. Passing Data Between Screens

> **Goal:** Learn how to send data from one screen to another, and how to return data back to the previous screen.

So far, we know how to navigate:

```text
Home
  ↓
Profile
  ↓
Settings
```

But real applications need more than just navigation.

For example:

```text
Product List
      ↓
Product Details
```

The details screen needs to know:

> **Which product did the user select?**

Or:

```text
Settings
      ↓
Choose Theme
      ↓
Dark Mode selected
      ↓
Settings
```

The Settings screen needs to receive the selected value.

This is what **passing data between screens** solves.

---

# 🧠 1. The Basic Idea

Think of navigation as a function call.

You can conceptually think:

```text
Screen A
   │
   │ data
   ▼
Screen B
```

For example:

```text
Home
 │
 │ userId = 42
 ▼
Profile
```

The Profile screen can then use:

```dart
userId
```

to display the correct user's information.

---

# 2. Two Directions of Data Flow

There are actually **two different problems**.

### A. Send data forward

```text
Screen A
   │
   │ Product
   ▼
Screen B
```

### B. Return data backward

```text
Screen A
   │
   ▼
Screen B
   │
   │ selected value
   ▼
Screen A
```

We'll learn both.

---

# 🟢 Part 1 — Passing Data Forward

There are several ways to pass data between screens.

For basic Flutter navigation, one of the clearest approaches is to pass data through the destination screen's constructor.

---

# 3. Passing Data Through a Constructor

Suppose we have:

```dart
class Product {
  final int id;
  final String name;
  final double price;

  const Product({
    required this.id,
    required this.name,
    required this.price,
  });
}
```

Now imagine we have a product:

```dart
const product = Product(
  id: 101,
  name: 'Mechanical Keyboard',
  price: 80,
);
```

We want to open:

```text
Product Details
```

and send this product to it.

---

# 4. Create a Details Screen

```dart
class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('ID: ${product.id}'),
            Text('Price: \$${product.price}'),
          ],
        ),
      ),
    );
  }
}
```

Notice this:

```dart
final Product product;
```

The page requires a `Product`.

And the constructor:

```dart
const ProductDetailsPage({
  super.key,
  required this.product,
});
```

makes the dependency explicit.

---

# 5. Navigate and Pass the Object

From the previous screen:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ProductDetailsPage(
      product: product,
    ),
  ),
);
```

The complete flow is:

```text
Product List
      │
      │ Product object
      ▼
Product Details
```

The destination receives:

```dart
product
```

and can access:

```dart
product.id
product.name
product.price
```

---

# ⭐ Why Constructor Passing Is Excellent

This is one of the most important ideas in Flutter.

The destination clearly tells you:

```dart
final Product product;
```

and:

```dart
required this.product
```

So if you try to create:

```dart
ProductDetailsPage()
```

without providing a product, Dart immediately tells you that something is missing.

This makes dependencies:

* Explicit
* Type-safe
* Easy to understand
* Easy to test
* Easy to refactor

---

# 6. Passing a Simple Value

You don't have to pass an entire object.

You can pass:

```dart
String
int
double
bool
```

For example:

```dart
class ProfilePage extends StatelessWidget {
  final int userId;

  const ProfilePage({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('User ID: $userId'),
      ),
    );
  }
}
```

Navigate:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ProfilePage(
      userId: 42,
    ),
  ),
);
```

Now:

```text
Home
 │
 │ userId = 42
 ▼
Profile
```

---

# 7. Passing Multiple Values

You can also pass multiple pieces of data.

```dart
class ProfilePage extends StatelessWidget {
  final int userId;
  final String username;

  const ProfilePage({
    super.key,
    required this.userId,
    required this.username,
  });

  // ...
}
```

Navigate:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ProfilePage(
      userId: 42,
      username: 'Nayeem',
    ),
  ),
);
```

The destination now receives:

```text
userId   → 42
username → Nayeem
```

---

# ⚠️ But Don't Overdo This

Imagine a screen requires:

```dart
id
name
email
phone
address
image
role
createdAt
...
```

Passing everything individually becomes messy.

Instead, create a model:

```dart
class User {
  final int id;
  final String name;
  final String email;
  final String phone;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });
}
```

Then:

```dart
class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({
    super.key,
    required this.user,
  });

  // ...
}
```

This is cleaner.

---

# 🧠 Professional Rule

> **If multiple values describe one meaningful entity, consider passing the model rather than passing many unrelated parameters.**

For example:

```text
❌ userId
❌ userName
❌ userEmail
❌ userPhone
```

instead:

```text
✅ User user
```

---

# 8. Passing Data Using Named Routes

Earlier we learned:

```dart
Navigator.pushNamed(
  context,
  '/details',
);
```

Named routes can also receive arguments.

Example:

```dart
Navigator.pushNamed(
  context,
  '/details',
  arguments: product,
);
```

The important part is:

```dart
arguments: product
```

---

# 9. Receiving Named Route Arguments

Inside the destination:

```dart
final product =
    ModalRoute.of(context)!.settings.arguments as Product;
```

Now you can use:

```dart
product.name
product.price
```

---

# 10. Complete Named Route Example

Define the route:

```dart
MaterialApp(
  routes: {
    '/': (context) => const HomePage(),
    '/details': (context) => const ProductDetailsPage(),
  },
);
```

Navigate:

```dart
Navigator.pushNamed(
  context,
  '/details',
  arguments: product,
);
```

Receive:

```dart
final product =
    ModalRoute.of(context)!.settings.arguments as Product;
```

---

# ⚠️ Constructor vs Named Route Arguments

Compare these two approaches.

### Constructor

```dart
ProductDetailsPage(
  product: product,
)
```

The type is obvious.

### Named route

```dart
arguments: product
```

Then later:

```dart
as Product
```

The type is not immediately visible at the navigation call site.

That's one reason constructor-based navigation is often easier to reason about for straightforward screen-to-screen navigation.

---

# 11. Returning Data From a Screen

Now let's solve the second problem.

Suppose we have:

```text
Settings
    ↓
Select Theme
    ↓
User chooses Dark
    ↓
Settings
```

The selection screen needs to return:

```dart
'Dark'
```

to Settings.

---

# 12. `Navigator.pop()` Can Return Data

Previously we learned:

```dart
Navigator.pop(context);
```

But `pop()` can also receive a value:

```dart
Navigator.pop(
  context,
  'Dark',
);
```

So:

```text
Select Theme
      │
      │ "Dark"
      ▼
Settings
```

---

# 13. Waiting for the Result

Here's the important part.

When we navigate:

```dart
final result = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ThemeSelectionPage(),
  ),
);
```

Notice:

```dart
await
```

Why?

Because the previous screen needs to wait for the destination to finish.

Conceptually:

```text
Settings
   │
   │ open selector
   ▼
Theme Selection
   │
   │ user chooses
   ▼
Settings
   │
   └── result received
```

---

# 14. Complete Example

## Settings Page

```dart
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedTheme = 'Light';

  Future<void> selectTheme() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ThemeSelectionPage(),
      ),
    );

    if (result != null) {
      setState(() {
        selectedTheme = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current theme: $selectedTheme',
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: selectTheme,
              child: const Text('Choose Theme'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

# 15. Theme Selection Page

```dart
class ThemeSelectionPage extends StatelessWidget {
  const ThemeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Theme'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Light'),
            onTap: () {
              Navigator.pop(context, 'Light');
            },
          ),
          ListTile(
            title: const Text('Dark'),
            onTap: () {
              Navigator.pop(context, 'Dark');
            },
          ),
        ],
      ),
    );
  }
}
```

When the user taps:

```text
Dark
```

this runs:

```dart
Navigator.pop(context, 'Dark');
```

The `Navigator.push()` future completes with:

```dart
'Dark'
```

So:

```dart
final result = await Navigator.push(...);
```

gets:

```text
result = "Dark"
```

---

# 🧠 16. What Is Actually Happening?

This is extremely important to understand.

When you write:

```dart
final result = await Navigator.push(...);
```

you're essentially saying:

> "Open another screen and give me the value that it returns when it closes."

Then the second screen does:

```dart
Navigator.pop(context, 'Dark');
```

which means:

> "Close me and return `'Dark'` to the previous screen."

So:

```text
                    Navigator.push()
                          │
                          ▼
                    ┌───────────┐
                    │  Screen B │
                    └─────┬─────┘
                          │
                  Navigator.pop()
                          │
                    returns data
                          │
                          ▼
                    ┌───────────┐
                    │  Screen A │
                    └───────────┘
```

---

# 17. The Type of the Result

Here's an important Dart concept.

`Navigator.push()` returns a `Future`.

You can specify the result type.

For example:

```dart
final String? result = await Navigator.push<String>(
  context,
  MaterialPageRoute(
    builder: (context) => const ThemeSelectionPage(),
  ),
);
```

And then:

```dart
Navigator.pop<String>(
  context,
  'Dark',
);
```

Now the relationship is explicit:

```text
push<String>
     ↓
Future<String?>
     ↓
pop<String>
```

---

# ⭐ Why Is This Better?

Instead of:

```dart
final result = await Navigator.push(...);
```

you can write:

```dart
final String? result = await Navigator.push<String>(...);
```

Now Dart and your code clearly communicate:

> "This screen returns a String, or possibly null."

This becomes particularly valuable in larger applications.

---

# 18. Why Is the Result Nullable?

Because the user might simply press Back.

Suppose:

```text
Settings
   ↓
Theme Selection
```

The user doesn't choose anything.

They press:

```text
← Back
```

Then:

```dart
Navigator.pop(context);
```

returns no value.

Therefore:

```dart
String?
```

makes sense.

The result can be:

```text
"Dark"
```

or:

```text
null
```

---

# 19. Handling `null`

You should account for that.

```dart
final String? result = await Navigator.push<String>(
  context,
  MaterialPageRoute(
    builder: (context) => const ThemeSelectionPage(),
  ),
);

if (result != null) {
  setState(() {
    selectedTheme = result;
  });
}
```

This is much safer than assuming a result always exists.

---

# 20. Returning Other Types

The returned value doesn't have to be a String.

You can return:

### `int`

```dart
Navigator.pop<int>(context, 42);
```

### `bool`

```dart
Navigator.pop<bool>(context, true);
```

### An object

```dart
Navigator.pop<Product>(
  context,
  product,
);
```

For example:

```dart
final Product? selectedProduct =
    await Navigator.push<Product>(
  context,
  MaterialPageRoute(
    builder: (context) => const ProductSelectionPage(),
  ),
);
```

This can be very useful.

---

# 21. Passing Data Forward + Returning Data Back

Now combine both concepts.

Suppose:

```text
Home
 │
 │ User
 ▼
Edit Profile
 │
 │ Updated User
 ▼
Home
```

We can pass a user forward:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => EditProfilePage(
      user: user,
    ),
  ),
);
```

Then the edit screen can return the updated user:

```dart
Navigator.pop(
  context,
  updatedUser,
);
```

The previous screen:

```dart
final User? updatedUser =
    await Navigator.push<User>(
  context,
  MaterialPageRoute(
    builder: (context) => EditProfilePage(
      user: user,
    ),
  ),
);
```

Now we have:

```text
              User
Home ──────────────────► Edit Profile
                           │
                           │ Updated User
                           ▼
Home ◄─────────────────────
```

This pattern is extremely common.

---

# 22. A Real-World Example

Imagine a task application.

```text
Task List
   │
   │ Task
   ▼
Edit Task
   │
   │ Updated Task
   ▼
Task List
```

The list sends:

```dart
Task task
```

to the edit screen.

The edit screen returns:

```dart
Task updatedTask
```

Then the list updates its state.

This is a very natural Flutter pattern.

---

# 23. Important Distinction: Navigation vs State Management

You might wonder:

> "If I can pass data between screens like this, why do I need state management?"

Excellent question.

Passing data through navigation is appropriate when the data is directly related to the navigation event.

For example:

```text
Product List
     ↓
Product Details
```

Passing:

```dart
Product product
```

makes sense.

But imagine:

```text
User logged in
        ↓
Profile
        ↓
Cart
        ↓
Checkout
        ↓
Orders
```

Many unrelated parts of the application need access to:

```text
Current User
Cart
Authentication State
App Settings
```

Passing all of that manually through every screen becomes problematic.

That's where **state management** becomes important.

We'll study that later in Phase 5.

---

# 🧠 Professional Rule

Use navigation data for:

> **Data directly associated with entering or leaving a screen.**

Use application state management for:

> **State that needs to be shared or maintained across multiple parts of the application.**

---

# 24. Common Beginner Mistakes

## ❌ Mistake 1 — Passing everything through navigation

Don't use navigation as a replacement for state management.

Bad architecture:

```text
Home
 ↓ user
Profile
 ↓ user + cart + settings + auth
Checkout
 ↓ user + cart + settings + ...
```

This becomes difficult to maintain.

---

## ❌ Mistake 2 — Ignoring null results

Don't assume:

```dart
final String result = await Navigator.push(...);
```

will always return a value.

The user can press Back.

Prefer:

```dart
final String? result = await Navigator.push<String>(...);
```

when no result is guaranteed.

---

## ❌ Mistake 3 — Passing too many primitive parameters

Instead of:

```dart
ProductDetailsPage(
  id: product.id,
  name: product.name,
  price: product.price,
  image: product.image,
)
```

consider:

```dart
ProductDetailsPage(
  product: product,
)
```

when those values naturally belong to one model.

---

## ❌ Mistake 4 — Using `dynamic` everywhere

Avoid:

```dart
dynamic result;
```

when you know the type.

Prefer:

```dart
final String? result = ...
```

or:

```dart
final Product? result = ...
```

Strong typing makes your application safer and easier to maintain.

---

# 25. Constructor vs Named Route Arguments

Let's summarize the two forward-passing approaches.

### Constructor

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ProductDetailsPage(
      product: product,
    ),
  ),
);
```

### Named route

```dart
Navigator.pushNamed(
  context,
  '/details',
  arguments: product,
);
```

Then:

```dart
final product =
    ModalRoute.of(context)!.settings.arguments as Product;
```

For straightforward navigation, constructor-based passing is often easier to read and type-check.

---

# 📊 Quick Reference

## Pass data forward

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => DetailsPage(
      data: data,
    ),
  ),
);
```

---

## Pass arguments with named route

```dart
Navigator.pushNamed(
  context,
  '/details',
  arguments: data,
);
```

---

## Receive named route arguments

```dart
final data =
    ModalRoute.of(context)!.settings.arguments;
```

---

## Return data

```dart
Navigator.pop(
  context,
  result,
);
```

---

## Receive returned data

```dart
final result = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const SelectionPage(),
  ),
);
```

---

## Strongly typed result

```dart
final Product? result =
    await Navigator.push<Product>(
  context,
  MaterialPageRoute(
    builder: (_) => const ProductSelectionPage(),
  ),
);
```

---

# 🧩 Complete Mental Model

You should now visualize navigation like this:

```text
                    NAVIGATION
                        │
            ┌───────────┴───────────┐
            │                       │
       Move Forward             Move Back
            │                       │
            ▼                       ▼
       Navigator.push          Navigator.pop
            │                       │
            │                       │
        Send data              Return data
            │                       │
            ▼                       │
      Screen B ─────────────────────┘
```

Or:

```text
Screen A
   │
   │  Product
   ▼
Screen B
   │
   │  Updated Product
   ▼
Screen A
```

---

# 🎯 What You Should Know After This Lesson

You should now be able to explain:

* Why screens need to exchange data
* How to pass primitive values
* How to pass model objects
* Passing data through constructors
* Passing arguments with named routes
* Reading route arguments
* Returning values with `Navigator.pop()`
* Waiting for navigation results with `await`
* Using generic result types
* Why navigation results can be nullable
* Passing data forward and returning updated data
* When navigation data is appropriate
* Why navigation shouldn't replace state management
* Why strong typing is preferable to `dynamic`

---

# 🧪 Practice Project

Build this small flow:

```text
┌──────────────┐
│ Product List │
└──────┬───────┘
       │
       │ Product
       ▼
┌────────────────┐
│ Product Details│
└───────┬────────┘
        │
        │ Edit
        ▼
┌────────────────┐
│   Edit Product │
└───────┬────────┘
        │
        │ Updated Product
        ▼
┌──────────────┐
│ Product List │
└──────────────┘
```

### Requirements

Create a model:

```dart
class Product {
  final int id;
  final String name;
  final double price;

  const Product({
    required this.id,
    required this.name,
    required this.price,
  });
}
```

Then:

1. Display several products in a `ListView`.
2. Tap a product.
3. Pass the `Product` object to the details screen.
4. Display its information.
5. Open an edit screen.
6. Pass the product to the edit screen.
7. Modify the product.
8. Return the updated product using `Navigator.pop()`.
9. Receive the updated product in the list screen.
10. Update the UI.

### ⭐ Challenge

Make the navigation result strongly typed:

```dart
final Product? updatedProduct =
    await Navigator.push<Product>(
  context,
  MaterialPageRoute(
    builder: (_) => EditProductPage(
      product: product,
    ),
  ),
);
```

If you can build this without copying the lesson, you have genuinely understood the topic.

---

# 🏁 Key Takeaway

> **Navigation carries the user from one destination to another; data makes that navigation meaningful.**

The two patterns you should remember are:

```dart
// Send data forward
ProductDetailsPage(
  product: product,
)
```

and:

```dart
// Return data backward
Navigator.pop(
  context,
  updatedProduct,
);
```

Once these concepts are comfortable, the next topic becomes much more important:

# ⏭️ Next: State with `setState()`


