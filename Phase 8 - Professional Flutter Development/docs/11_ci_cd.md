# Phase 8 — Professional Flutter Development

## Topic 11: CI/CD

> **Core idea:** Automate the repetitive, error-prone parts of shipping software — building, testing, and deploying — so releases become routine, not risky.

---

## 1. Continuous Integration

Every push/PR automatically triggers checks, catching problems before they merge.

```
Push code
   ↓
CI runs: analyze, test, build
   ↓
Pass ✅ → safe to merge
Fail ❌ → fix before merging
```

---

## 2. Continuous Delivery

Every change that passes CI is automatically packaged into a releasable artifact — a human still decides when to actually release it.

```
CI passes
   ↓
Build artifact produced (APK/IPA)
   ↓
Ready to deploy, on demand
```

(Continuous **Deployment** goes one step further and releases automatically — less common for mobile apps due to store review.)

---

## 3. Automated Testing

```
git push
   ↓
CI pipeline
   ↓
flutter analyze
flutter test
```

Tests run the same way every time, on a clean environment — no more "works on my machine."

---

## 4. Automated Builds

```
CI pipeline
   ↓
flutter build apk --release --flavor prod
flutter build ipa --release
```

Builds become reproducible and don't depend on one developer's laptop configuration.

---

## 5. Build Pipelines

A pipeline is a sequence of stages, each depending on the previous succeeding:

```
Checkout code
   ↓
Install dependencies
   ↓
Analyze + Test
   ↓
Build
   ↓
Upload artifact
```

---

## 6. Deployment Pipelines

Extends the build pipeline further, pushing the artifact somewhere:

```
Build artifact
   ↓
Upload to Play Store (internal track) / TestFlight
   ↓
Notify team
```

---

## 7. GitHub Actions or Equivalent CI Tools

A minimal Flutter workflow (`.github/workflows/ci.yml`):

```yaml
name: CI
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
```

Other common tools: Codemagic, Bitrise, GitLab CI — the concepts (checkout → deps → test → build → deploy) stay the same across all of them.

---

## 🧠 Mental Model

```
CI  → catch problems early, on every change
CD  → make releasing a routine, low-drama event

Pipeline stages:
Checkout → Deps → Analyze/Test → Build → Deploy
```

> **Rule of thumb:** If releasing your app feels scary, that's a sign your pipeline needs more automation, not more caution.

## Key Takeaways

- CI catches issues automatically on every push/PR.
- CD makes shipping a repeatable, low-risk process.
- Pipelines standardize checkout → test → build → deploy.
- Tools differ (GitHub Actions, Codemagic, etc.) but the stages don't.

## Practice

1. Write a GitHub Actions workflow that runs `flutter test` on every push.
2. Extend it to build a release APK on the `main` branch only.
3. Explain the difference between continuous delivery and continuous deployment.