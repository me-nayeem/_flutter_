# Phase 8 — Professional Flutter Development

## Topic 10: App Signing

> **Core idea:** Every release build must be cryptographically signed so the store — and your users' devices — can verify it really came from you.

---

## 1. Android Signing

Without a real signing config, Flutter release builds fall back to a debug key — which the Play Store rejects.

```
Unsigned/debug-signed APK → rejected by Play Store
Properly signed APK/AAB   → accepted
```

---

## 2. Keystore Concepts

A **keystore** is a file holding your private signing key.

```
my-release-key.jks
├── alias: upload
├── password
└── private key
```

```
keytool -genkey -v -keystore my-release-key.jks \
  -alias upload -keyalg RSA -keysize 2048 -validity 10000
```

Reference it in `android/key.properties` (never committed to Git):

```
storePassword=****
keyPassword=****
keyAlias=upload
storeFile=../my-release-key.jks
```

```
⚠️ Lose this keystore, and you may permanently lose the ability
   to publish updates to the same app listing.
```

---

## 3. iOS Signing Concepts

iOS signing has two linked pieces:

```
Certificate           → proves who you are (identity)
Provisioning Profile  → says which app, which devices, which capabilities
```

Both are tied to your Apple Developer account and managed through Xcode or App Store Connect.

---

## 4. Certificates

```
Development certificate  → for testing on physical devices
Distribution certificate → for TestFlight / App Store releases
```

Certificates expire and must be renewed — an expired certificate blocks new builds from being signed.

---

## 5. Provisioning Profiles

```
Provisioning Profile
├── App ID
├── Certificate(s)
├── Device list (for development profiles)
└── Capabilities (push notifications, etc.)
```

```
Development profile → limited to registered test devices
Distribution profile → required for App Store submission
```

---

## 6. Secure Signing Configuration

```
❌ Keystore/certs committed to Git
❌ Passwords hardcoded in build.gradle
✅ key.properties + .gitignore
✅ Secrets injected via CI/CD secret store
```

```
# .gitignore
key.properties
*.jks
*.p12
```

In CI, signing credentials are typically stored as encrypted secrets and injected at build time — never checked into the repo.

---

## 🧠 Mental Model

```
Android: Keystore + key.properties → signs the APK/AAB
iOS:     Certificate + Provisioning Profile → signs the IPA

Both prove: "This build genuinely came from this developer."
```

> **Rule of thumb:** Signing credentials are as sensitive as passwords — store, back up, and gitignore them accordingly.

## Key Takeaways

- Release builds must be signed; debug-signed builds are rejected by stores.
- Android uses a keystore + `key.properties`; iOS uses certificates + provisioning profiles.
- Losing your Android keystore can block future updates to the same app.
- Never commit signing credentials — use `.gitignore` and CI secret stores.

## Practice

1. Generate an Android upload keystore and wire it into `key.properties`.
2. List what a distribution provisioning profile needs on iOS.
3. Explain why losing your keystore is worse than losing your source code.