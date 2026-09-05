# Phase 7 — Advanced Flutter

## Topic 10: Deep Links and Routing

### 📚 What are Deep Links?

A **deep link** is a link that opens a specific location inside your app instead of simply opening the app's home screen.

For example:

```text
https://example.com/products/42
```

Instead of:

```text
Open App → Home
```

the app can handle:

```text
Open Link
    ↓
App launches
    ↓
Product Details
    ↓
Product ID = 42
```

---

## 1. Deep Links vs Normal Navigation

### Normal navigation

Navigation happens **inside the app**:

```text
Home
 ↓
Product List
 ↓
Product Details
```

For example:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ProductDetails(id: 42),
  ),
);
```

### Deep linking

Navigation starts **outside the app**:

```text
Browser / Email / Message / Notification
                    ↓
                 Deep Link
                    ↓
                   App
                    ↓
             Product Details
```

---

## 2. Universal Links / App Links

There are two important platform concepts:

| Platform | Concept             |
| -------- | ------------------- |
| Android  | **App Links**       |
| iOS      | **Universal Links** |

They allow normal web URLs to open the corresponding content directly in your application.

Example:

```text
https://example.com/product/42
```

If the app is installed:

```text
URL → Your App → Product 42
```

Otherwise, the URL can open the website.

The important idea is that **the web URL becomes an entry point into your app**.

---

## 3. Route Handling

Your application needs to determine:

> **"What screen should this incoming link open?"**

For example:

```text
/products/42
```

could become:

```text
ProductDetailsScreen(productId: 42)
```

Conceptually:

```text
Incoming URL
     ↓
Parse URL
     ↓
Determine route
     ↓
Extract parameters
     ↓
Navigate
```

A routing package such as `go_router` can make this easier for applications with complex routing.

---

## 4. Navigation State

Deep linking becomes more important when the app is not currently running.

Consider:

```text
User taps:

https://example.com/orders/123
```

The app may need to:

1. Start the application.
2. Determine the incoming route.
3. Restore/establish required application state.
4. Navigate to the correct screen.
5. Load order `123`.

So routing isn't only about **which screen to show**.

It also needs to work correctly with the application's **navigation and state lifecycle**.

---

## 5. Passing Data Through a Deep Link

A URL can contain information needed by the destination:

```text
/products/42
```

Here:

```text
42 → productId
```

Or query parameters:

```text
/products?category=books
```

Here:

```text
category → books
```

Your routing layer parses this information and passes it to the appropriate feature.

---

## 🧠 Mental Model

Think of routing as an **address system** for your application:

```text
URL
 ↓
Route
 ↓
Screen
 ↓
Feature state
 ↓
Data
```

Normal navigation:

```text
UI → Router → Screen
```

Deep navigation:

```text
External Link → Router → Screen
```

The router provides a consistent way to enter the application from different places.

---

## 🎯 When Should You Use Deep Links?

Useful for:

* Product pages
* Specific posts/articles
* Password/account flows
* Email links
* Notifications
* Web-to-app navigation
* Sharing specific content with another user

For a simple app with no externally accessible content, you may not need complex deep-linking infrastructure.

---

## ⚠️ Common Mistakes

* Treating deep links as only a navigation problem.
* Not handling links when the app is **closed**.
* Assuming the required data is already loaded.
* Hardcoding navigation logic throughout widgets.
* Creating complicated routes when simple routes are sufficient.
* Forgetting to test both **installed** and **not-installed** scenarios.

> **Key idea:** Deep linking means your app can be entered from the outside at a specific location, while routing determines how that external address maps to your application's navigation state.
