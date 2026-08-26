# 🟢 Phase 3 — Building Complete Apps

# 7. Assets in Flutter

> **Goal:** Learn how to properly work with assets in Flutter, including images, icons, fonts, asset folders, `pubspec.yaml`, and best practices for organizing assets in a real-world project.

Assets are files that your Flutter application needs at runtime.

Examples include:

```text
assets/
├── images/
│   ├── logo.png
│   ├── profile.png
│   └── banner.jpg
│
├── icons/
│   ├── google.png
│   └── facebook.png
│
└── fonts/
    └── custom_font.ttf
```

Flutter doesn't automatically know about arbitrary files inside your project.

You need to **declare assets** so Flutter can package them with your application.

---

# 🧠 1. What Are Assets?

An asset is a file bundled with your Flutter application.

Common examples:

| Asset       | Example                 |
| ----------- | ----------------------- |
| Images      | `.png`, `.jpg`, `.webp` |
| SVG         | `.svg`                  |
| Fonts       | `.ttf`, `.otf`          |
| JSON        | `.json`                 |
| Other files | `.txt`, etc.            |

For example:

```text
assets/images/logo.png
```

can be loaded and displayed in your application.

---

# 2. Why Do We Need Assets?

Suppose you want to display your company logo.

You have:

```text
assets/images/logo.png
```

Flutter needs to know:

> "This file should be included in the application."

That's why we declare it in:

```text
pubspec.yaml
```

The general flow is:

```text
Asset file
    ↓
pubspec.yaml
    ↓
Flutter bundles asset
    ↓
Dart code references asset
    ↓
Asset appears in UI
```

---

# 3. Recommended Asset Structure

A small project might use:

```text
my_app/
│
├── lib/
│
├── assets/
│   ├── images/
│   ├── icons/
│   ├── fonts/
│   └── data/
│
├── pubspec.yaml
└── ...
```

For example:

```text
assets/
├── images/
│   ├── logo.png
│   ├── banner.png
│   └── profile.jpg
│
├── icons/
│   ├── google.png
│   └── facebook.png
│
└── data/
    └── countries.json
```

This organization becomes valuable as your application grows.

---

# 4. Declaring Assets in `pubspec.yaml`

Suppose you have:

```text
assets/images/logo.png
```

You can declare it:

```yaml
flutter:
  assets:
    - assets/images/logo.png
```

The indentation is important.

YAML is indentation-sensitive.

---

# ⚠️ 5. A Common Mistake

This is incorrect:

```yaml
flutter:
assets:
  - assets/images/logo.png
```

Because `assets` must be nested under `flutter`.

Correct:

```yaml
flutter:
  assets:
    - assets/images/logo.png
```

Think:

```text
flutter
  └── assets
       └── logo.png
```

---

# 6. Registering an Entire Directory

Instead of registering every image individually:

```yaml
flutter:
  assets:
    - assets/images/
```

Now Flutter includes the files in that directory.

For example:

```text
assets/images/
├── logo.png
├── profile.png
└── banner.jpg
```

You can reference them individually:

```dart
'assets/images/logo.png'
```

```dart
'assets/images/profile.png'
```

---

# 7. Individual Files vs Directories

### Individual file

```yaml
flutter:
  assets:
    - assets/images/logo.png
```

### Directory

```yaml
flutter:
  assets:
    - assets/images/
```

The directory approach is convenient when you have many related assets.

However, don't blindly register your entire project directory.

It's better to organize assets intentionally.

---

# 8. Displaying an Image

Once the asset is declared, use:

```dart
Image.asset(
  'assets/images/logo.png',
)
```

Example:

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
        ),
      ),
    );
  }
}
```

The important part is:

```dart
Image.asset()
```

---

# 9. `Image.asset()` vs `Image.network()`

This distinction is very important.

### Local asset

```dart
Image.asset(
  'assets/images/logo.png',
)
```

The image is bundled with your application.

### Network image

```dart
Image.network(
  'https://example.com/image.png',
)
```

The image is downloaded from the internet.

Think:

```text
Image.asset
    ↓
Local / bundled file

Image.network
    ↓
Internet / remote server
```

---

# 10. Asset Path

Suppose your project contains:

```text
assets/
└── images/
    └── logo.png
```

The asset path is:

```dart
'assets/images/logo.png'
```

Not:

```dart
'/assets/images/logo.png'
```

and not:

```dart
'../assets/images/logo.png'
```

Flutter asset paths are referenced from the project root in the declared asset structure.

---

# 11. Controlling Image Size

You can specify:

```dart
Image.asset(
  'assets/images/logo.png',
  width: 150,
  height: 150,
)
```

For example:

```dart
Image.asset(
  'assets/images/profile.png',
  width: 100,
  height: 100,
  fit: BoxFit.cover,
)
```

---

# 12. Understanding `BoxFit`

`BoxFit` determines how an image fits inside the available space.

Common values include:

```dart
BoxFit.cover
BoxFit.contain
BoxFit.fill
BoxFit.fitWidth
BoxFit.fitHeight
BoxFit.none
BoxFit.scaleDown
```

The two you'll use frequently are:

### `BoxFit.cover`

The image fills the available area, potentially cropping parts of the image.

```dart
Image.asset(
  'assets/images/banner.png',
  width: double.infinity,
  height: 200,
  fit: BoxFit.cover,
)
```

Think:

```text
Image
┌────────────────────┐
│████████████████████│
│████ image █████████│
│████████████████████│
└────────────────────┘
```

Some portions may be cropped.

---

### `BoxFit.contain`

The entire image remains visible.

```dart
Image.asset(
  'assets/images/logo.png',
  width: 200,
  height: 200,
  fit: BoxFit.contain,
)
```

Think:

```text
┌────────────────────┐
│                    │
│      ┌──────┐      │
│      │ image│      │
│      └──────┘      │
│                    │
└────────────────────┘
```

There may be unused space.

---

# 13. `AssetImage`

You can also use:

```dart
const AssetImage(
  'assets/images/logo.png',
)
```

For example:

```dart
Container(
  decoration: const BoxDecoration(
    image: DecorationImage(
      image: AssetImage(
        'assets/images/banner.png',
      ),
      fit: BoxFit.cover,
    ),
  ),
)
```

This is useful when an image is being used as a decoration rather than directly as an `Image` widget.

---

# 14. Asset Images in `CircleAvatar`

A common UI pattern:

```dart
CircleAvatar(
  radius: 50,
  backgroundImage: const AssetImage(
    'assets/images/profile.png',
  ),
)
```

This is useful for profile images.

---

# 15. Asset Images in `DecorationImage`

Example:

```dart
Container(
  height: 200,
  width: double.infinity,
  decoration: BoxDecoration(
    image: const DecorationImage(
      image: AssetImage(
        'assets/images/banner.jpg',
      ),
      fit: BoxFit.cover,
    ),
    borderRadius: BorderRadius.circular(16),
  ),
)
```

This is commonly useful for cards and banners.

---

# 16. SVG Assets

Flutter's basic image widget doesn't directly provide full SVG support in the same way as PNG/JPEG.

A common approach is to use the `flutter_svg` package.

Add the dependency to `pubspec.yaml`:

```yaml
dependencies:
  flutter_svg: ^latest
```

Then:

```dart
import 'package:flutter_svg/flutter_svg.dart';
```

Use:

```dart
SvgPicture.asset(
  'assets/icons/google.svg',
)
```

This is particularly useful for:

* Logos
* UI icons
* Vector illustrations

> **Note:** In a real project, use the current package version recommended by pub.dev rather than blindly copying a version from an old tutorial.

---

# 17. Why SVG Can Be Useful

Compare:

```text
PNG
 ↓
Raster image
 ↓
Scaling can affect quality
```

with:

```text
SVG
 ↓
Vector graphics
 ↓
Scales cleanly
```

For logos and simple icons, SVG can be very useful.

However, choose the format based on the asset itself rather than assuming SVG is always better.

---

# 18. Fonts as Assets

Assets aren't limited to images.

You can bundle custom fonts.

Example:

```text
assets/
└── fonts/
    └── MyFont-Regular.ttf
```

Declare it:

```yaml
flutter:
  fonts:
    - family: MyFont
      fonts:
        - asset: assets/fonts/MyFont-Regular.ttf
```

Then use it:

```dart
Text(
  'Hello Flutter',
  style: const TextStyle(
    fontFamily: 'MyFont',
  ),
)
```

---

# 19. Multiple Font Weights

A professional app often needs:

```text
Regular
Medium
Bold
```

Suppose:

```text
assets/fonts/
├── MyFont-Regular.ttf
├── MyFont-Medium.ttf
└── MyFont-Bold.ttf
```

You can declare:

```yaml
flutter:
  fonts:
    - family: MyFont
      fonts:
        - asset: assets/fonts/MyFont-Regular.ttf
          weight: 400

        - asset: assets/fonts/MyFont-Medium.ttf
          weight: 500

        - asset: assets/fonts/MyFont-Bold.ttf
          weight: 700
```

Then:

```dart
Text(
  'Flutter',
  style: const TextStyle(
    fontFamily: 'MyFont',
    fontWeight: FontWeight.w700,
  ),
)
```

Flutter can select the appropriate font file based on the requested weight.

---

# 20. Asset JSON Files

Assets can also contain data files.

For example:

```text
assets/data/countries.json
```

Declare:

```yaml
flutter:
  assets:
    - assets/data/countries.json
```

Later, you can load it using Flutter's asset system.

This becomes particularly useful when working with:

* Local configuration
* Static data
* Mock data
* JSON files

---

# 21. Loading an Asset With `rootBundle`

Flutter provides:

```dart
rootBundle
```

for reading bundled assets.

Example:

```dart
import 'package:flutter/services.dart';

final jsonString = await rootBundle.loadString(
  'assets/data/countries.json',
);
```

This is asynchronous because Flutter may need to load the bundled resource.

We'll use this idea much more when we study data and APIs.

---

# 22. Asset Variants

Flutter supports asset variants.

A common example is:

```text
assets/images/
├── logo.png
└── 2.0x/
    └── logo.png
```

The idea is that Flutter can choose an appropriate resolution variant for the device.

This is useful when you need sharper images on high-density displays.

You don't need to manually decide which image to load in ordinary cases.

---

# 23. Why Asset Variants Exist

Imagine:

```text
Device A
Low pixel density
      ↓
logo.png

Device B
High pixel density
      ↓
2.0x/logo.png
```

Flutter's asset resolution mechanism can select the appropriate variant.

Conceptually:

```text
                Asset
                  │
        ┌─────────┼─────────┐
        │         │         │
      1.0x      2.0x      3.0x
        │         │         │
        └─────────┼─────────┘
                  │
             Flutter chooses
```

---

# 24. `pubspec.yaml` Is Critical

Many asset-related errors come from incorrect `pubspec.yaml`.

For example:

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/icons/
```

Notice the indentation.

YAML is not forgiving about indentation.

This:

```yaml
flutter:
    assets:
```

is not equivalent to:

```yaml
flutter:
  assets:
```

depending on the surrounding structure and expected nesting.

Use consistent indentation.

---

# 25. After Changing `pubspec.yaml`

When you add a new dependency or modify asset configuration, Flutter may need to refresh the project configuration.

Usually run:

```bash
flutter pub get
```

If you're working inside an IDE, the tooling may detect the change automatically, but understanding `flutter pub get` is important.

---

# 26. Common Asset Error

You may see something like:

```text
Unable to load asset:
assets/images/logo.png
```

This usually means Flutter couldn't find or load the declared asset.

Check:

```text
1. Does the file exist?
2. Is the path correct?
3. Is the asset declared?
4. Is pubspec.yaml indentation correct?
5. Did you run flutter pub get?
6. Did you use the correct filename?
```

---

# 27. Filename Case Matters

Suppose the actual file is:

```text
Logo.png
```

but your code says:

```dart
Image.asset(
  'assets/images/logo.png',
)
```

Don't assume Flutter will treat these as identical.

Use the exact path and filename.

Good practice:

```text
logo.png
profile.png
home_banner.png
```

rather than inconsistent naming.

---

# 28. Asset Naming Convention

For a professional project, use predictable names.

Prefer:

```text
profile_avatar.png
home_banner.webp
google_logo.svg
empty_state.png
```

Avoid:

```text
IMG123.png
new final 2.png
image copy.png
```

A clean naming system becomes increasingly important as your project grows.

---

# 29. Organizing Assets by Purpose

Instead of:

```text
assets/
├── image1.png
├── image2.png
├── image3.png
├── icon1.png
└── font.ttf
```

prefer:

```text
assets/
├── images/
│   ├── profile.png
│   └── banner.png
│
├── icons/
│   ├── google.svg
│   └── facebook.svg
│
├── fonts/
│   └── MyFont-Regular.ttf
│
└── data/
    └── countries.json
```

This makes the project easier to navigate.

---

# 30. Don't Hardcode Asset Paths Everywhere

You might initially write:

```dart
Image.asset(
  'assets/images/logo.png',
)
```

everywhere.

For small projects this is fine.

As the application grows, you can centralize asset paths:

```dart
class AppAssets {
  static const logo = 'assets/images/logo.png';
  static const profile = 'assets/images/profile.png';
  static const banner = 'assets/images/banner.png';
}
```

Then:

```dart
Image.asset(
  AppAssets.logo,
)
```

This reduces repeated strings and makes renaming easier.

---

# 31. Asset Constants

A simple asset class:

```dart
abstract final class AppAssets {
  static const logo = 'assets/images/logo.png';
  static const profile = 'assets/images/profile.png';
  static const google = 'assets/icons/google.svg';
}
```

Then:

```dart
Image.asset(AppAssets.logo);
```

and:

```dart
SvgPicture.asset(AppAssets.google);
```

This is a small but useful organizational technique.

---

# 32. Assets vs Network Resources

This distinction is important for real applications.

### Assets

Usually:

```text
Bundled with application
```

Good for:

* Logos
* Static illustrations
* Local icons
* Fonts
* Static configuration/data

### Network resources

Usually:

```text
Downloaded from server
```

Good for:

* User profile pictures
* Product images
* News images
* Dynamic content

Think:

```text
Static → Asset

Dynamic → Network
```

This isn't an absolute rule, but it's a useful starting point.

---

# 33. Asset Images and Performance

Large images can consume significant memory.

For example, if you have a huge image:

```text
4000 × 4000
```

but display it as:

```text
100 × 100
```

you're potentially loading much more image data than necessary.

For production applications:

* Optimize image dimensions
* Compress images appropriately
* Use suitable formats
* Avoid unnecessarily huge assets
* Consider caching for remote images

Don't just put the highest-resolution image you can find into the project.

---

# 34. Choosing Image Formats

Common formats:

### PNG

Good for:

* Transparency
* UI graphics
* Logos requiring lossless quality

### JPEG

Good for:

* Photographs
* Images where transparency isn't needed

### WebP

Often useful for:

* Smaller image sizes
* Web/app imagery

### SVG

Good for:

* Vector icons
* Logos
* Simple illustrations

There is no single format that's best for every asset.

---

# 35. `const` With Asset Widgets

You'll often see:

```dart
const AssetImage(
  'assets/images/logo.png',
)
```

when the widget/object can be constant.

Likewise:

```dart
const CircleAvatar(
  backgroundImage: AssetImage(
    'assets/images/profile.png',
  ),
)
```

Using `const` where applicable is a good Flutter habit.

---

# 36. Asset Accessibility

Assets aren't only about loading files.

Think about accessibility too.

For example, if an image communicates important information, consider whether the user needs a semantic description.

For an `Image`:

```dart
Image.asset(
  'assets/images/product.png',
  semanticLabel: 'Mechanical keyboard',
)
```

For decorative images, you may not need to expose them as meaningful content to assistive technologies.

Accessibility is part of professional app development, not just visual design.

---

# 37. Common Beginner Mistakes

## ❌ Mistake 1 — Forgetting `pubspec.yaml`

Having:

```text
assets/images/logo.png
```

doesn't automatically make it available to Flutter.

Declare it:

```yaml
flutter:
  assets:
    - assets/images/logo.png
```

---

## ❌ Mistake 2 — Incorrect indentation

YAML:

```yaml
flutter:
  assets:
    - assets/images/
```

Pay attention to indentation.

---

## ❌ Mistake 3 — Incorrect path

If your file is:

```text
assets/images/logo.png
```

don't write:

```dart
Image.asset('images/logo.png');
```

Use:

```dart
Image.asset('assets/images/logo.png');
```

---

## ❌ Mistake 4 — Incorrect filename

Be careful with:

```text
logo.png
Logo.png
logo.PNG
```

Treat asset paths as exact.

---

## ❌ Mistake 5 — Huge unoptimized images

Don't use a 10 MB image for a tiny icon.

Optimize assets before shipping your app.

---

## ❌ Mistake 6 — Putting every file into one folder

Avoid:

```text
assets/
├── image1.png
├── image2.png
├── logo.svg
├── font.ttf
├── data.json
└── ...
```

Organize by purpose.

---

# 🧠 38. Professional Mental Model

Think of Flutter assets as a pipeline:

```text
                 PROJECT FILE
                      │
                      ▼
                pubspec.yaml
                      │
                      ▼
               Flutter asset bundle
                      │
                      ▼
                 Dart code
                      │
          ┌───────────┼───────────┐
          ▼           ▼           ▼
       Image.asset  AssetImage  rootBundle
          │           │           │
          ▼           ▼           ▼
          UI       Decoration    Raw data
```

Once you understand this pipeline, asset handling becomes much easier.

---

# 📊 Quick Reference

### Register an image

```yaml
flutter:
  assets:
    - assets/images/
```

### Display image

```dart
Image.asset(
  'assets/images/logo.png',
)
```

### Background image

```dart
DecorationImage(
  image: AssetImage(
    'assets/images/banner.png',
  ),
  fit: BoxFit.cover,
)
```

### Circle avatar

```dart
CircleAvatar(
  backgroundImage: AssetImage(
    'assets/images/profile.png',
  ),
)
```

### SVG

```dart
SvgPicture.asset(
  'assets/icons/google.svg',
)
```

### Custom font

```yaml
flutter:
  fonts:
    - family: MyFont
      fonts:
        - asset: assets/fonts/MyFont-Regular.ttf
```

### Load text/JSON asset

```dart
final data = await rootBundle.loadString(
  'assets/data/data.json',
);
```

---

# 🧪 Practice Project

Build a small **Profile Screen** using local assets.

Create:

```text
assets/
├── images/
│   ├── profile.png
│   └── banner.jpg
│
├── icons/
│   └── github.svg
│
└── fonts/
    └── MyFont-Regular.ttf
```

Your screen should look conceptually like:

```text
┌──────────────────────────────┐
│                              │
│        [ Banner Image ]      │
│                              │
│           (Avatar)           │
│                              │
│         Nayeem Islam         │
│      Flutter Developer       │
│                              │
│       [ GitHub Icon ]        │
│                              │
└──────────────────────────────┘
```

### Requirements

Use:

* `Image.asset`
* `AssetImage`
* `DecorationImage`
* SVG asset
* Custom font
* `pubspec.yaml`
* Proper asset folder structure
* `BoxFit`
* `const` where appropriate

### ⭐ Challenge

Create:

```dart
abstract final class AppAssets {
  // asset paths
}
```

and use that class throughout your screen instead of repeatedly writing asset paths.

---

# 🎯 What You Should Know After This Lesson

You should be able to explain:

* What Flutter assets are
* Why assets need to be declared
* `pubspec.yaml`
* Asset directories
* Individual asset declarations
* `Image.asset`
* `AssetImage`
* `DecorationImage`
* `BoxFit`
* SVG assets
* Custom fonts
* JSON/data assets
* `rootBundle`
* Asset variants
* Asset naming and organization
* Asset optimization
* Local assets vs network resources
* Basic accessibility considerations
* Common asset-loading errors

---

# 🏁 Key Takeaway

Remember the fundamental workflow:

```text
Create asset
    ↓
Organize asset
    ↓
Declare in pubspec.yaml
    ↓
flutter pub get
    ↓
Reference from Dart
    ↓
Display/use asset
```

For example:

```yaml
flutter:
  assets:
    - assets/images/
```

Then:

```dart
Image.asset(
  'assets/images/logo.png',
)
```

> **Assets are part of your application's resources, not just files sitting in your project. A professional Flutter project organizes, declares, loads, and optimizes those resources deliberately.**

---

## ⏭️ Next Topic

### **8. Themes**

We'll learn how to build a consistent application-wide design system using:

* `ThemeData`
* `ColorScheme`
* `TextTheme`
* `Theme.of(context)`
* Light and dark themes
* Custom colors
* Global button/input styles
* Theme extensions
* Avoiding hardcoded styling
* Creating maintainable, scalable Flutter UI themes
