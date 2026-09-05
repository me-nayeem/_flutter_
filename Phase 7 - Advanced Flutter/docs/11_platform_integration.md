# Phase 7 — Advanced Flutter

## Topic 11: Platform Integration

Flutter lets you write most of an application with Dart, but sometimes you need functionality provided directly by **Android or iOS**.

That is where platform integration comes in.

---

## 1. Android/iOS Differences

Flutter provides a common UI and framework, but Android and iOS have different:

* APIs
* Permissions
* Lifecycle behavior
* Native UI/components
* Hardware capabilities
* Platform conventions

So don't assume:

> "If it works on Android, it must work exactly the same on iOS."

A good Flutter application keeps platform-specific behavior isolated instead of spreading it throughout the UI.

---

## 2. Platform APIs

A **platform API** is functionality provided by the underlying operating system.

Examples:

```text
Camera
Location
Bluetooth
Notifications
Biometrics
File system
Sensors
Background tasks
```

Flutter often accesses these through plugins rather than requiring you to write native code yourself.

---

## 3. Plugins

A **plugin** is a package that provides Dart APIs for functionality that may require platform-specific implementation.

Conceptually:

```text
Flutter/Dart
    ↓
Plugin API
    ↓
Android / iOS implementation
    ↓
Platform API
```

For example, instead of directly writing Android camera code, you can use an existing Flutter camera plugin.

### Professional rule

**Check whether a reliable plugin already exists before writing native code.**

---

## 4. Platform Channels

Sometimes Flutter needs to communicate directly with native code.

**Platform channels** provide a communication mechanism between Dart and platform-specific code.

Conceptually:

```text
Flutter
  │
  │ Platform Channel
  ↓
Android / iOS
  │
  ↓
Native API
```

For example:

```text
Dart
 ↓
"Get battery information"
 ↓
Android/iOS native code
 ↓
Battery API
 ↓
Result → Dart
```

You don't need to memorize the channel APIs yet. The important concept is:

> **Platform channels are a bridge between Dart code and native platform code.**

---

## 5. When Is Native Code Actually Necessary?

Native code is usually necessary when:

1. **No suitable plugin exists**
2. You need a platform API that Flutter doesn't expose
3. You need highly platform-specific behavior
4. An existing plugin doesn't provide the functionality you need
5. You need to integrate an existing native SDK

Example:

```text
Need biometric authentication
        ↓
Reliable Flutter plugin exists?
        ↓
      YES → Use plugin
        ↓
       NO
        ↓
Implement native integration
```

Don't write native code simply because you *can*.

---

## 6. Keep Platform Code Isolated

Avoid:

```text
UI Widget
 ├── Android-specific code
 ├── iOS-specific code
 └── Business logic
```

Prefer:

```text
UI
 ↓
Application logic
 ↓
Platform abstraction
 ↓
Plugin / Native implementation
```

This makes the rest of your application independent of Android/iOS details.

---

## 🧠 Mental Model

Think of Flutter as an application layer sitting above the operating system:

```text
┌──────────────────────┐
│     Flutter App      │
│       Dart           │
└──────────┬───────────┘
           ↓
    Plugin / Channel
           ↓
┌──────────────────────┐
│ Android / iOS        │
│ Native APIs          │
└──────────────────────┘
```

### Remember

* **Plugin** → reuse existing platform integration.
* **Platform channel** → communicate with native code.
* **Native code** → use only when the Flutter/plugin layer cannot provide what you need.
* **Architecture** → isolate platform-specific code from the rest of the application.

This is especially important in production apps because platform-specific code should remain a **small, well-defined boundary**, not become part of your entire application's business logic.
