# Phase 7 — Advanced Flutter

## Topic 8: Accessibility

> **Core idea:** Accessibility means making your Flutter app usable by people with different abilities, including users who rely on **screen readers, keyboard navigation, or other assistive technologies**.

---

## 1. Semantics

Flutter uses a **Semantics tree** to describe UI elements to assistive technologies.

For example:

```dart
Semantics(
  label: 'Profile picture',
  child: Image.asset('profile.png'),
)
```

This gives a screen reader meaningful information about the widget.

Use `Semantics` when Flutter cannot automatically determine what an element means.

---

## 2. Screen Readers

Screen readers read accessible information aloud.

For example, instead of a button being understood as:

```text
"Button"
```

you want:

```text
"Delete note, button"
```

Make interactive elements have meaningful labels and avoid relying only on icons.

---

## 3. Touch Target Sizes

Interactive elements should have a sufficiently large area to tap comfortably.

For example:

```text
❌ tiny icon → difficult to tap

✅ larger interactive area
```

Don't make the visible icon unnecessarily large just to achieve this; the **interactive hit area** can be larger than the visual element.

---

## 4. Contrast

Text and important UI elements should have enough contrast against their background.

Avoid:

```text
Light gray text
       +
White background
```

because some users may struggle to read it.

Think about accessibility when choosing colors, rather than treating color as the only way to communicate information.

---

## 5. Keyboard Navigation

Your app should also work for users who navigate using a keyboard.

Important considerations include:

* Can users reach interactive elements?
* Is the focus order logical?
* Is the focused element visually obvious?
* Can users activate controls without a mouse/touch?

This becomes particularly important for **desktop and web Flutter applications**.

---

## 6. Accessible Custom Widgets

When creating custom UI components, don't assume Flutter automatically understands what your component means.

For example, a custom control may need:

```dart
Semantics(
  button: true,
  label: 'Play',
  child: MyCustomPlayButton(),
)
```

The goal is that assistive technology understands:

```text
What is this?
What does it do?
What is its current state?
```

---

## 🧠 Mental Model

Think about accessibility in three layers:

```text
Visual UI
   │
   ├── What does it look like?
   │
   ▼
Interaction
   │
   ├── Can it be tapped / focused?
   │
   ▼
Semantics
   │
   └── Can assistive technology understand it?
```

> **Accessibility isn't a separate feature you add at the end. It should be considered while designing and building your UI.**
