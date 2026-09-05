# Phase 7 — Advanced Flutter

## Topic 9: Localization and Internationalization

> **Core idea:** **Internationalization (i18n)** prepares your app to support different languages and regions. **Localization (l10n)** provides the actual language/region-specific content.

---

## 1. Localization Concepts

Instead of hardcoding text:

```dart
Text('Welcome')
```

your app gets the text from a translation system:

```text
English → "Welcome"
Bangla  → "স্বাগতম"
Arabic  → "مرحباً"
```

This allows the same app to adapt to different users.

---

## 2. Locale

A **locale** represents a user's language and regional preferences.

Examples:

```text
en       → English
bn       → Bangla
en-US    → English (United States)
en-GB    → English (United Kingdom)
ar       → Arabic
```

Flutter uses the locale to determine which localized resources should be displayed.

---

## 3. Translations

Don't scatter translated strings throughout your code.

Instead, keep translations in a dedicated localization system:

```text
lib/
└── l10n/
    ├── app_en.arb
    ├── app_bn.arb
    └── app_ar.arb
```

Then your UI requests the appropriate localized string.

The important idea is:

```text
UI
 ↓
Localization system
 ↓
Current Locale
 ↓
Translation
```

---

## 4. Date & Time Formatting

Dates shouldn't always be displayed the same way.

For example:

```text
2026-09-05
```

could be presented differently depending on locale.

Use localization-aware formatting rather than manually constructing date strings.

The Dart `intl` package is commonly used for this:

```dart
DateFormat.yMMMMd().format(date);
```

---

## 5. Number Formatting

Numbers can also have locale-specific formatting.

For example:

```text
1000000
```

may be displayed differently depending on the user's locale.

Using `intl`:

```dart
NumberFormat.decimalPattern().format(1000000);
```

The same principle applies to:

* Currency
* Percentages
* Decimal numbers

---

## 6. RTL — Right-to-Left

Some languages, such as Arabic, use **right-to-left (RTL)** layouts.

Your UI should adapt automatically:

```text
LTR                         RTL

Text →                      ← Text
[ Icon ]                    [ Icon ]
```

Avoid hardcoding left/right positioning when the layout should adapt.

Prefer directional concepts such as:

```dart
EdgeInsetsDirectional
AlignmentDirectional
```

instead of always using:

```dart
EdgeInsets.only(left: ...)
```

---

## 🧠 Mental Model

```text
User
 ↓
Locale
 ↓
┌────────────────────────┐
│ Language                │
│ Date/time format        │
│ Number format           │
│ Direction (LTR / RTL)   │
└───────────┬────────────┘
            ↓
           UI
```

### Most important principles

* **Never assume one language or region.**
* Keep translations separate from UI code.
* Use locale-aware date and number formatting.
* Design layouts that work with both **LTR and RTL**.
* Test your UI with longer translated strings because translations may require more space.
