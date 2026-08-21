Phase 2 — Flutter Fundamentals

1. Flutter Project Structure

Great. Phase 1 is complete. 🎯

Now we're moving from Dart itself into Flutter.

The first thing is understanding what Flutter creates for you when you run:

flutter create my_app

Before learning widgets like MaterialApp and Scaffold, you should know where your Flutter code lives and what the important folders/files are for.


---

1. The basic Flutter project

A newly created Flutter project looks roughly like this:

my_app/
│
├── android/
├── ios/
├── lib/
│   └── main.dart
│
├── test/
│
├── web/
├── windows/
├── macos/
├── linux/
│
├── pubspec.yaml
├── pubspec.lock
└── analysis_options.yaml

You don't need to memorize every file.

For now, focus on:

lib/
main.dart
pubspec.yaml
test/
android/
ios/


---

2. lib/ — your main Flutter code

This is the most important folder for you right now.

lib/

Your application's Dart/Flutter source code normally goes here.

For example:

lib/
├── main.dart
├── home_page.dart
├── login_page.dart
└── user.dart

As your application grows, you'll organize your code into folders.

For example:

lib/
├── main.dart
├── screens/
├── widgets/
├── models/
└── services/

Don't worry about architecture or complicated folder structures yet.

We'll learn those later.


---

3. main.dart

This is usually the starting point of your Flutter application.

A basic Flutter application might contain:

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

The important part is:

void main()

You already know main() from Dart.

It's the entry point of the Dart program.

Then:

runApp(...)

tells Flutter:

> "Start the Flutter application using this widget."



We'll learn runApp() and MaterialApp properly in the next lessons.

For now, just understand the flow:

main()
   ↓
runApp()
   ↓
Flutter application starts


---

4. pubspec.yaml

This is one of the most important files in a Flutter project.

You'll find:

pubspec.yaml

at the project root.

It contains information about your project, including things such as:

project name

version

dependencies

assets

environment information


For example:

name: my_app

dependencies:
  flutter:
    sdk: flutter

Later, when you use packages, you'll add them here.

For example, conceptually:

dependencies:
  http: ...

Then Flutter/Dart knows your application depends on that package.


---

5. Assets

You can also declare assets in pubspec.yaml.

For example, suppose your project has:

assets/
└── images/
    └── profile.png

You can configure the asset in pubspec.yaml.

Then your Flutter code can access it.

We'll study assets much later in Phase 3, so don't worry about the syntax yet.

Just remember:

> pubspec.yaml is where Flutter project configuration and dependencies/assets are declared.




---

6. test/

The:

test/

directory is for automated tests.

For example:

test/
└── widget_test.dart

You don't need to learn testing now.

Testing is part of Phase 8 — Professional development in our roadmap. 

So for now:

test/
   ↓
automated tests

That's enough.


---

7. android/

This folder contains the Android-specific part of your Flutter project.

android/

Flutter applications can contain native platform code.

For example:

Flutter code
     ↓
   Android

The Android project lives inside:

android/

You don't need to start learning Android native development now.

Remember our roadmap explicitly says not to worry about native platform code early. 

We'll come back to platform integration much later.


---

8. ios/

Similarly:

ios/

contains the iOS-specific project configuration/code.

So:

android/ → Android side
ios/     → iOS side
lib/     → Flutter/Dart side

This distinction is very important.


---

9. What about web/, windows/, macos/, linux/?

Flutter can target multiple platforms.

So depending on the project configuration, you may see:

web/
windows/
macos/
linux/

These contain platform-specific project files.

You don't need to study them individually right now.

The big picture is:

Flutter project
                       │
              ┌────────┴────────┐
              │                 │
          lib/             Platform folders
              │                 │
        Dart/Flutter       Android / iOS / etc.


---

10. The most important distinction

When you're starting Flutter, keep this mental model:

lib/

"This is where I build my Flutter application."

main.dart

"This is normally where my Flutter app starts."

pubspec.yaml

"This describes/configures my project and its dependencies/assets."

android/ and ios/

"These contain platform-specific parts."

test/

"This is where tests live."

That's enough for now.


---

11. A real beginner project

Imagine we're building a Notes app.

Initially:

notes_app/
│
├── lib/
│   └── main.dart
│
├── test/
│
├── android/
├── ios/
│
└── pubspec.yaml

Later, when the app becomes larger:

notes_app/
│
├── lib/
│   ├── main.dart
│   ├── screens/
│   ├── widgets/
│   ├── models/
│   └── services/
│
├── test/
├── android/
├── ios/
└── pubspec.yaml

Notice that we don't need to create all those folders immediately.

We'll introduce them when we actually need them.


---

🧠 One important concept

Don't confuse:

Dart project

with:

Flutter project

A Flutter project uses Dart, but Flutter adds its own project structure, tooling, widgets, platform integration, assets, and configuration.

So your journey is now:

Dart
 ↓
Flutter
 ↓
Widgets
 ↓
Applications

You've finished the Dart fundamentals needed to start this.


---

🎯 Quick check

Before moving to 2. MaterialApp, tell me what these three are used for:

1. lib/
2. main.dart
3. pubspec.yaml

Just explain them in your own words. Don't worry about perfect terminology.
