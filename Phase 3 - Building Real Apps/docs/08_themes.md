# 🟢 Phase 3 — Building Complete Apps

# 8. Themes in Flutter

> **Goal:** Learn how to build a consistent, maintainable, and scalable visual design system using Flutter's theme system instead of hardcoding styles throughout the application.

A beginner often writes UI like this:

```dart
Text(
  'Welcome',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
)
```

Then somewhere else:

```dart
Text(
  'Login',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
)
```

And somewhere else:

```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
  ),
)
```

This works for a small app.

But imagine doing this across **50 screens**.

If your design changes:

```text
Blue → Purple
24px → 26px
Button radius 8 → 12
```

you would have to change many places manually.

Flutter's **theme system** solves this problem.

---

# 🧠 1. What Is a Theme?

A theme is a collection of visual rules that define how your application should look.

It can control things like:

```text
Colors
Typography
Buttons
Input fields
Cards
AppBar
Checkboxes
Dialogs
Navigation components
...
```

Think of a theme as your application's **design system**.

```text
                    App Theme
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
     Colors        Typography      Components
        │              │              │
   ┌────┴────┐      TextTheme     Buttons
   │         │                      Inputs
Primary   Surface                    Cards
```

---

# 2. Why Themes Matter

Without a theme:

```text
Screen A → blue button
Screen B → dark blue button
Screen C → another blue
Screen D → slightly different text
Screen E → different border radius
```

With a theme:

```text
                 App Theme
                    │
        ┌───────────┼───────────┐
        ▼           ▼           ▼
      Screen A    Screen B    Screen C
        │           │           │
        └───────────┼───────────┘
                    ▼
             Consistent UI
```

The biggest benefits are:

* Consistency
* Maintainability
* Reusability
* Easier redesign
* Light/dark mode
* Scalable UI architecture

---

# 3. Where Do We Define a Theme?

Usually at the top of your application:

```dart
MaterialApp(
  theme: ThemeData(...),
)
```

For example:

```dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
    ),
  ),
  home: const HomePage(),
)
```

The theme becomes available throughout the widget tree.

---

# 4. `ThemeData`

The main class you'll work with is:

```dart
ThemeData
```

Example:

```dart
final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
  ),
);
```

Then:

```dart
MaterialApp(
  theme: theme,
  home: const HomePage(),
)
```

`ThemeData` contains configuration for many Material widgets.

---

# 5. Modern Flutter: `ColorScheme`

One of the most important concepts to understand is:

```dart
ColorScheme
```

Instead of thinking:

```text
Blue
Red
Green
Grey
```

a `ColorScheme` gives semantic roles to colors.

For example:

```text
primary
onPrimary
secondary
onSecondary
surface
onSurface
error
onError
```

The word **semantic** is important.

Instead of saying:

> "Use this exact blue."

you say:

> "This is the primary color of my application."

---

# 6. Creating a Color Scheme

A common approach:

```dart
ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
  ),
)
```

Flutter generates a coordinated color scheme from the seed color.

This is much better than manually choosing unrelated colors for every component.

---

# 7. Understanding `primary`

Suppose:

```dart
colorScheme.primary
```

represents your main brand/accent color.

You can use:

```dart
Container(
  color: Theme.of(context).colorScheme.primary,
)
```

Instead of:

```dart
Container(
  color: Colors.blue,
)
```

The second version hardcodes the color.

The first version uses the application's theme.

---

# 8. Understanding `onPrimary`

You'll often see pairs like:

```text
primary
onPrimary
```

The idea is:

```text
primary
   ↓
Background color

onPrimary
   ↓
Content displayed on that background
```

For example:

```dart
Container(
  color: colorScheme.primary,
  child: Text(
    'Continue',
    style: TextStyle(
      color: colorScheme.onPrimary,
    ),
  ),
)
```

This allows the theme to determine a suitable foreground color for the primary background.

---

# 9. `surface` and `onSurface`

Similarly:

```text
surface
   ↓
Surface/background-like component color

onSurface
   ↓
Content shown on that surface
```

For example:

```dart
final colorScheme = Theme.of(context).colorScheme;

Container(
  color: colorScheme.surface,
  child: Text(
    'Profile',
    style: TextStyle(
      color: colorScheme.onSurface,
    ),
  ),
)
```

This semantic approach becomes very useful when supporting light and dark themes.

---

# 10. Accessing the Theme

Inside a widget:

```dart
Theme.of(context)
```

For example:

```dart
final theme = Theme.of(context);
```

Then:

```dart
theme.colorScheme
```

or:

```dart
theme.textTheme
```

So:

```dart
final colorScheme = Theme.of(context).colorScheme;
```

is a very common pattern.

---

# 11. Using Theme Colors

Instead of:

```dart
Text(
  'Welcome',
  style: const TextStyle(
    color: Colors.blue,
  ),
)
```

use:

```dart
Text(
  'Welcome',
  style: TextStyle(
    color: Theme.of(context).colorScheme.primary,
  ),
)
```

Now the color comes from the application's theme.

---

# 12. `TextTheme`

Colors aren't the only thing a theme controls.

Flutter also provides:

```dart
TextTheme
```

A `TextTheme` defines typography styles.

For example:

```dart
Theme.of(context).textTheme
```

Common styles include:

```text
displayLarge
displayMedium
displaySmall

headlineLarge
headlineMedium
headlineSmall

titleLarge
titleMedium
titleSmall

bodyLarge
bodyMedium
bodySmall

labelLarge
labelMedium
labelSmall
```

You don't need to memorize every one immediately.

Understand the concept first:

```text
TextTheme
    ↓
Reusable typography system
```

---

# 13. Using `TextTheme`

Example:

```dart
Text(
  'Welcome Back',
  style: Theme.of(context).textTheme.headlineMedium,
)
```

Another:

```dart
Text(
  'Enter your email address',
  style: Theme.of(context).textTheme.bodyMedium,
)
```

Now your typography comes from the theme.

---

# 14. Why `TextTheme` Is Better

Without a theme:

```dart
TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
)

TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
)

TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
)
```

With a theme:

```dart
theme.textTheme.headlineMedium
```

Every screen can use the same typography definition.

If you change it later, you can change it centrally.

---

# 15. Customizing `TextTheme`

You can provide your own styles:

```dart
ThemeData(
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
    ),
  ),
)
```

Then:

```dart
Text(
  'Welcome',
  style: Theme.of(context).textTheme.headlineMedium,
)
```

---

# 16. Combining ColorScheme and TextTheme

A realistic theme:

```dart
final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
    ),
  ),
);
```

Then:

```dart
MaterialApp(
  theme: appTheme,
  home: const HomePage(),
)
```

---

# 17. Theme vs Hardcoded Styling

### ❌ Hardcoded

```dart
Text(
  'Hello',
  style: const TextStyle(
    color: Colors.blue,
    fontSize: 24,
  ),
)
```

### ✅ Theme-based

```dart
Text(
  'Hello',
  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
    color: Theme.of(context).colorScheme.primary,
  ),
)
```

However, don't interpret this as:

> "Never use `TextStyle` directly."

There are situations where a one-off style is appropriate.

The principle is:

> **Centralize styles that are part of the application's design system.**

---

# 18. Component Themes

Themes can also configure Material components.

For example:

```dart
ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
)
```

Now your `ElevatedButton`s can share the same style.

You don't need:

```dart
ElevatedButton.styleFrom(...)
```

on every button.

---

# 19. Button Theme Example

```dart
final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
);
```

Then:

```dart
ElevatedButton(
  onPressed: () {},
  child: const Text('Login'),
)
```

The button automatically receives the theme's configuration.

---

# 20. Input Decoration Theme

Forms are another great example.

Instead of configuring every `TextFormField` separately:

```dart
TextFormField(
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
)
```

you can configure:

```dart
inputDecorationTheme
```

Example:

```dart
ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
)
```

Now your form fields can inherit the style.

This connects directly with the previous topic:

> **Form Validation**

---

# 21. Card Theme

You can also define card styling:

```dart
ThemeData(
  cardTheme: CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
)
```

Then:

```dart
Card(
  child: const Padding(
    padding: EdgeInsets.all(16),
    child: Text('Hello'),
  ),
)
```

can inherit the common styling.

> Flutter's theme APIs can vary slightly between Flutter releases, so when working on a specific project, check the API available in that project's Flutter SDK.

---

# 22. AppBar Theme

You can configure the app bar globally:

```dart
ThemeData(
  appBarTheme: const AppBarTheme(
    centerTitle: true,
  ),
)
```

Then:

```dart
AppBar(
  title: const Text('Home'),
)
```

inherits the configuration.

---

# 23. Creating a Complete Theme

Let's combine several pieces:

```dart
final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
  ),

  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
    ),
  ),

  appBarTheme: const AppBarTheme(
    centerTitle: true,
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50),
    ),
  ),
);
```

Then:

```dart
MaterialApp(
  theme: appTheme,
  home: const HomePage(),
)
```

---

# 🌙 24. Light and Dark Themes

One of the biggest advantages of a proper theme system is supporting dark mode.

Flutter allows you to define:

```dart
theme
darkTheme
themeMode
```

Example:

```dart
MaterialApp(
  theme: lightTheme,
  darkTheme: darkTheme,
  themeMode: ThemeMode.system,
)
```

Now Flutter can follow the device's system theme.

---

# 25. `ThemeMode`

Common values:

```dart
ThemeMode.light
```

Always use light theme.

```dart
ThemeMode.dark
```

Always use dark theme.

```dart
ThemeMode.system
```

Follow the operating system preference.

So:

```dart
themeMode: ThemeMode.system,
```

is a very useful default for applications that support both modes.

---

# 26. Creating a Light Theme

```dart
final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    brightness: Brightness.light,
  ),
);
```

And dark:

```dart
final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    brightness: Brightness.dark,
  ),
);
```

Then:

```dart
MaterialApp(
  theme: lightTheme,
  darkTheme: darkTheme,
  themeMode: ThemeMode.system,
)
```

---

# 27. Why `ColorScheme` Helps With Dark Mode

Suppose you hardcode:

```dart
Colors.white
```

everywhere.

In dark mode, that might become problematic.

Instead, use semantic colors:

```dart
colorScheme.surface
```

and:

```dart
colorScheme.onSurface
```

The theme can provide appropriate values for each brightness.

Think:

```text
Light Theme
     ↓
surface = light surface
onSurface = dark content

Dark Theme
     ↓
surface = dark surface
onSurface = light content
```

This is one of the strongest reasons to use semantic colors.

---

# 28. Complete Light/Dark Example

```dart
final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    brightness: Brightness.light,
  ),
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    brightness: Brightness.dark,
  ),
);
```

Then:

```dart
MaterialApp(
  theme: lightTheme,
  darkTheme: darkTheme,
  themeMode: ThemeMode.system,
  home: const HomePage(),
)
```

That's already a good foundation.

---

# 29. Reading the Current Theme

Inside a widget:

```dart
final theme = Theme.of(context);
```

Then:

```dart
theme.colorScheme.primary
```

or:

```dart
theme.textTheme.headlineMedium
```

For example:

```dart
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);

  return Text(
    'Welcome',
    style: theme.textTheme.headlineMedium,
  );
}
```

This is cleaner than repeatedly writing:

```dart
Theme.of(context)
```

---

# 30. `copyWith()`

Sometimes you want to use a theme style but make a small local adjustment.

For example:

```dart
Text(
  'Welcome',
  style: Theme.of(context)
      .textTheme
      .headlineMedium
      ?.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
)
```

You're saying:

> "Use the existing headline style, but change this one property."

This is preferable to rebuilding the entire style from scratch.

---

# 31. Don't Overuse `copyWith()`

This is important.

If you repeatedly do:

```dart
headlineMedium?.copyWith(...)
```

with the same changes everywhere, that's a sign the style probably belongs in the theme itself.

Think:

```text
One-off customization
        ↓
copyWith()

Repeated design rule
        ↓
ThemeData
```

---

# 32. Theme Inheritance

Flutter themes are inherited through the widget tree.

Conceptually:

```text
MaterialApp
    │
    ▼
   Theme
    │
 ┌──┼───────────────┐
 ▼  ▼               ▼
Page Page            Page
 │                    │
 ▼                    ▼
Widget              Widget
```

A descendant widget can access the theme using:

```dart
Theme.of(context)
```

This is an example of Flutter's inherited-data system.

You don't need to manually pass the theme through every constructor.

---

# 33. Local Themes

You can also override the theme for part of the widget tree.

For example:

```dart
Theme(
  data: Theme.of(context).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
    ),
  ),
  child: const SomeWidget(),
)
```

Now that subtree can use a different theme.

Conceptually:

```text
Global Theme
     │
     ├── Screen A
     │
     └── Local Theme
           │
           └── Screen B
```

Use this intentionally.

Don't create random local themes everywhere.

---

# 34. Theme Extensions

As applications become more advanced, you may have design tokens that aren't covered by the standard `ThemeData` properties.

For example:

```text
Success color
Warning color
Special gradient
Custom spacing
Brand-specific values
```

Flutter provides:

```dart
ThemeExtension
```

for adding custom theme data.

Conceptually:

```text
ThemeData
   │
   ├── ColorScheme
   ├── TextTheme
   ├── ButtonTheme
   └── Custom ThemeExtension
```

This becomes especially useful when building a larger design system.

You don't need to master `ThemeExtension` yet, but you should know why it exists.

---

# 35. Theme Architecture

For a small project, this might be enough:

```text
lib/
├── main.dart
└── screens/
```

But as your app grows, consider:

```text
lib/
├── core/
│   └── theme/
│       ├── app_theme.dart
│       ├── app_colors.dart
│       └── app_text_styles.dart
│
├── features/
│   ├── auth/
│   └── home/
│
└── main.dart
```

Then:

```dart
import 'core/theme/app_theme.dart';
```

and:

```dart
MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
)
```

The exact folder structure can vary, but separating app-wide design configuration from feature code is a good architectural direction.

---

# 36. Example `AppTheme`

You can create:

```dart
abstract final class AppTheme {
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.light,
    ),
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.dark,
    ),
  );
}
```

Then:

```dart
MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: ThemeMode.system,
)
```

This keeps `main.dart` cleaner.

---

# 37. Avoid a Giant `main.dart`

A beginner may write:

```dart
MaterialApp(
  theme: ThemeData(
    // 100 lines of theme configuration
  ),
)
```

inside `main.dart`.

It works.

But as your application grows, this becomes difficult to maintain.

Prefer:

```text
main.dart
   ↓
AppTheme
   ↓
Theme configuration
```

This separation will become increasingly important when we study architecture later.

---

# 38. Hardcoded Colors vs Semantic Colors

### ❌ Hardcoded

```dart
Container(
  color: Colors.indigo,
)
```

### ✅ Semantic

```dart
Container(
  color: Theme.of(context).colorScheme.primary,
)
```

Why is the second approach better?

Because the meaning is clear:

```text
Colors.indigo
    ↓
A specific color

colorScheme.primary
    ↓
The application's primary color
```

That's a major difference in professional UI development.

---

# 39. Hardcoded Text Styles vs Theme Styles

### ❌

```dart
Text(
  'Profile',
  style: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
)
```

### ✅

```dart
Text(
  'Profile',
  style: Theme.of(context).textTheme.headlineMedium,
)
```

The second communicates design intent.

---

# 40. When Should You Use Hardcoded Values?

This is important.

Don't turn your application into:

```dart
Theme.of(context).textTheme...
```

for absolutely everything.

Some local values are perfectly reasonable:

```dart
Padding(
  padding: const EdgeInsets.all(16),
)
```

or:

```dart
SizedBox(height: 12)
```

The goal isn't:

> "Never hardcode anything."

The goal is:

> **Centralize values that represent reusable design decisions.**

For example:

```text
App-wide primary color → Theme
App-wide typography → Theme
App-wide button style → Theme

One specific screen's spacing → Local value may be fine
One unique illustration size → Local value may be fine
```

---

# 41. Theme and `const`

Themes often contain constant values where possible.

For example:

```dart
const TextStyle(
  fontSize: 16,
)
```

Using `const` when appropriate remains a good Flutter practice.

But don't force everything to be `const` if the value depends on runtime state or isn't constant.

---

# 42. Common Beginner Mistakes

## ❌ Mistake 1 — Hardcoding every color

```dart
Colors.blue
Colors.blue
Colors.blue
Colors.blue
```

Use the theme for reusable design colors.

---

## ❌ Mistake 2 — Repeating button styles

If every button has:

```dart
borderRadius: 12
minimumSize: ...
```

move the common style into:

```dart
elevatedButtonTheme
```

---

## ❌ Mistake 3 — Ignoring dark mode

If you plan to support dark mode, don't build your UI around hardcoded:

```dart
Colors.white
Colors.black
```

Use semantic theme colors where appropriate.

---

## ❌ Mistake 4 — Creating too many local themes

A local theme is useful when you genuinely need a subtree-specific variation.

Don't wrap every widget in:

```dart
Theme(...)
```

---

## ❌ Mistake 5 — Over-customizing everything

Flutter's Material theme system already provides sensible defaults.

Customize what your product actually needs.

---

# 🧠 43. Professional Mental Model

Think about Flutter themes like this:

```text
                 DESIGN SYSTEM
                       │
          ┌────────────┼────────────┐
          ▼            ▼            ▼
       Colors      Typography    Components
          │            │            │
          ▼            ▼            ▼
    ColorScheme     TextTheme     ButtonTheme
                                  InputTheme
                                  AppBarTheme
                                      │
                                      ▼
                                Flutter Widgets
```

Then:

```text
ThemeData
   ↓
MaterialApp
   ↓
Widget Tree
   ↓
Theme.of(context)
   ↓
Consistent UI
```

---

# 🧪 44. Practice Project

Take the **Profile Screen** you built in the previous Assets lesson and convert it into a properly themed application.

Create:

```text
lib/
├── main.dart
└── core/
    └── theme/
        └── app_theme.dart
```

Your theme should define:

### Colors

* Primary color
* Secondary color
* Surface
* Error

### Typography

* Large heading
* Body text
* Button text

### Components

* AppBar
* ElevatedButton
* Input fields

Then use:

```dart
Theme.of(context)
```

inside your widgets instead of hardcoding the same colors and text styles repeatedly.

---

# ⭐ Challenge: Dark Mode

Add:

```dart
AppTheme.light
AppTheme.dark
```

Then:

```dart
MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: ThemeMode.system,
)
```

Now test your application by switching your device/emulator between light and dark mode.

Pay attention to:

```text
Text
Background
Cards
Buttons
Input fields
Icons
AppBar
```

Make sure your UI remains readable in both modes.

---

# 🎯 What You Should Know After This Lesson

You should be able to explain:

* What a Flutter theme is
* Why themes are important
* `ThemeData`
* `ColorScheme`
* Semantic colors
* `primary` / `onPrimary`
* `surface` / `onSurface`
* `TextTheme`
* `Theme.of(context)`
* Component themes
* `ElevatedButtonThemeData`
* `InputDecorationTheme`
* `AppBarTheme`
* Light and dark themes
* `ThemeMode`
* Theme inheritance
* Local themes
* `copyWith()`
* `ThemeExtension` concept
* How to organize theme code
* When to use theme values vs local styling

---

# 🏁 Key Takeaway

The most important shift in your thinking is:

### Beginner mindset

```dart
Colors.blue
```

> "I need a blue color."

### Professional mindset

```dart
Theme.of(context).colorScheme.primary
```

> "I need the application's primary color."

That's the real purpose of a theme.

Your application should have a **single source of truth for reusable design decisions**.

```text
                 App Theme
                    │
       ┌────────────┼────────────┐
       ▼            ▼            ▼
    Colors       Typography    Components
       │            │            │
       └────────────┼────────────┘
                    ▼
              Consistent UI
```

> **Don't just make every screen look good individually. Build a system that makes the entire application look consistent.**

---

## ⏭️ Next Topic

### **9. Responsive & Adaptive UI**

We'll move from **"How do I make a UI?"** to **"How do I make one UI work properly across different screen sizes and devices?"**

We'll cover:

* Responsive vs adaptive UI
* `MediaQuery`
* `LayoutBuilder`
* `SafeArea`
* Screen constraints
* Breakpoints
* Mobile vs tablet layouts
* Orientation changes
* Flexible layouts
* Avoiding fixed dimensions
* Building layouts that scale properly
* Practical responsive UI patterns
