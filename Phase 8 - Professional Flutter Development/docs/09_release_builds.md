# Phase 8 — Professional Flutter Development

## Topic 9: Release Builds

> **Core idea:** What you run while developing is not what you ship. Release builds are optimized, stripped of debug tools, and prepared for real users.

---

## 1. Debug vs Release Builds

```
Debug                          Release
├── Hot reload                 ├── No hot reload
├── Assertions enabled         ├── Assertions stripped
├── Larger, unoptimized        ├── Smaller, optimized
├── Debug banner shown         ├── No debug banner
└── Slower                     └── Faster
```

```
flutter run              # debug by default
flutter run --release    # test the release performance profile
```

Never judge an app's real performance from a debug build.

---

## 2. Build Configuration

Release builds should use production config, not dev/staging:

```
flutter build apk --release --flavor prod -t lib/main_prod.dart
```

Double-check the flavor and entry point — shipping a "prod" build pointed at the staging API is a common, embarrassing mistake.

---

## 3. Android Release Builds

```
flutter build apk --release          # single APK
flutter build appbundle --release    # AAB, preferred for Play Store
```

Play Store requires the build to be **signed** (covered in Topic 10 — App Signing). Without a proper signing config, the release build will use a debug key and be rejected.

---

## 4. iOS Release Builds

```
flutter build ipa --release
```

This produces an `.ipa` for App Store submission, built through Xcode's release configuration and requiring a valid signing certificate and provisioning profile.

---

## 5. Versioning

Defined in `pubspec.yaml`:

```yaml
version: 1.2.0+7
```

```
1.2.0   → version name (user-facing)
+7      → build number (internal)
```

Follow semantic versioning for the name:

```
MAJOR.MINOR.PATCH
1  .  2  .  0
```

- MAJOR — breaking/major changes
- MINOR — new features, backward-compatible
- PATCH — bug fixes

---

## 6. Build Numbers

```
1.2.0+7
1.2.0+8   ← same version name, next build
```

Every submission to the App Store / Play Store needs a **higher build number** than the last, even if the version name doesn't change (e.g., resubmitting after a rejection).

```
Version name   → what users see
Build number   → what the stores use to tell builds apart
```

---

## 🧠 Mental Model

```
Debug   → for you, while building
Release → for users, optimized and stripped

Version name  → communicates change to users
Build number  → always increments, tracked by the store
```

> **Rule of thumb:** Never ship what you debug in. Always test the actual release build before submitting.

## Key Takeaways

- Debug builds are for development; release builds are for users.
- Build the correct flavor + entry point for production.
- `version: X.Y.Z+N` — name for users, build number for store tracking.
- Build numbers must always increase between submissions.

## Practice

1. Build a release APK using the `prod` flavor.
2. Bump `pubspec.yaml` from `1.0.0+1` to `1.0.1+2` and explain what changed.
3. Explain why testing only in debug mode can hide real performance issues.