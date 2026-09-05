# Phase 8 — Professional Flutter Development

## Topic 7: Build Flavors

> **Core idea:** Flavors let you build multiple versions of the same app — dev, staging, production — from one codebase, each with its own name, icon, and configuration.

---

## 1. Why Flavors Exist

Without flavors, switching environments means manually editing config before every build — error-prone and easy to ship the wrong one.

```
One codebase
     ↓
Multiple installable apps
     ↓
Dev app + Staging app + Prod app (side by side on device)
```

Flavors let dev, staging, and prod exist as separate installs on the same phone at the same time.

---

## 2. Development Flavor

```
App name: MyApp Dev
Icon: Dev badge overlay
API: https://dev-api.example.com
```

Built often, installed alongside other flavors, safe to break.

---

## 3. Staging Flavor

```
App name: MyApp Staging
Icon: Staging badge overlay
API: https://staging-api.example.com
```

Used by QA/testers — should look and behave like production, but point at test infrastructure.

---

## 4. Production Flavor

```
App name: MyApp
Icon: Final app icon
API: https://api.example.com
```

The only flavor that ever ships to the App Store / Play Store.

---

## 5. Setting Up Flavors

**Android** (`android/app/build.gradle`):

```
flavorDimensions "env"
productFlavors {
    dev {
        dimension "env"
        applicationIdSuffix ".dev"
        resValue "string", "app_name", "MyApp Dev"
    }
    staging {
        dimension "env"
        applicationIdSuffix ".staging"
        resValue "string", "app_name", "MyApp Staging"
    }
    prod {
        dimension "env"
        resValue "string", "app_name", "MyApp"
    }
}
```

**iOS** uses Xcode Schemes + Configurations to achieve the same thing.

**Running a flavor:**

```
flutter run --flavor dev -t lib/main_dev.dart
flutter run --flavor prod -t lib/main_prod.dart
```

---

## 6. Entry Points Per Flavor

Each flavor typically gets its own `main_*.dart` that sets config, then calls a shared `main()`:

```dart
// main_dev.dart
void main() {
  runApp(MyApp(config: devConfig));
}

// main_prod.dart
void main() {
  runApp(MyApp(config: prodConfig));
}
```

The widget tree and business logic stay identical — only `config` changes.

---

## 7. Different App Names/Icons

Each flavor gets distinct branding so you can tell them apart at a glance on your home screen:

```
MyApp Dev      → orange icon
MyApp Staging  → yellow icon
MyApp          → real icon
```

This prevents the classic mistake: testing on staging while believing you're on production.

---

## 8. Environment-Specific Configuration

Flavors and the `AppConfig` pattern from Topic 6 work together:

```
Flavor (build-time)
     ↓
Selects which config
     ↓
AppConfig (apiUrl, flags, etc.)
     ↓
App logic (flavor-agnostic)
```

The flavor decides *which* config loads. The app itself never checks "am I dev or prod?" directly.

---

## 🧠 Mental Model

```
Flavors
├── Dev      → separate install, fast iteration
├── Staging  → separate install, QA testing
└── Prod     → the real thing, ships to stores

Same code, different:
├── App name
├── Icon
├── API endpoint
└── Config values
```

> **Rule of thumb:** If you ever have to ask "wait, which build am I looking at?", your flavors aren't distinct enough.

## Key Takeaways

- Flavors produce separately installable apps from one codebase.
- Each flavor should have a distinct name/icon to avoid confusion.
- Use separate entry points (`main_dev.dart`, etc.) that feed a shared app.
- Flavors decide *which* config loads; app logic stays environment-agnostic.

## Practice

1. Set up `dev` and `prod` flavors for an Android project.
2. Create `main_dev.dart` and `main_prod.dart` entry points.
3. Explain why installing dev and prod side by side is safer than switching config manually.