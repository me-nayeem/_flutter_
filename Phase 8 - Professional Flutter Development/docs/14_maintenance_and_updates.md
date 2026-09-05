# Phase 8 — Professional Flutter Development

## Topic 14: Maintenance and Updates

> **Core idea:** Shipping v1.0 isn't the finish line. Most of an app's life is spent being maintained, updated, and kept from rotting.

---

## 1. Dependency Updates

```
flutter pub outdated
flutter pub upgrade
```

Outdated packages accumulate security issues and compatibility problems. Update regularly, in small batches — not all at once, right before a deadline.

---

## 2. Flutter SDK Upgrades

```
flutter upgrade
flutter --version
```

```
Old SDK
   ↓
New SDK
   ↓
Re-run tests, re-check platform builds
```

Read the changelog before upgrading a production app — some SDK versions bring behavior changes, not just new features.

---

## 3. Breaking Changes

```
Package v2.0.0 → API renamed/removed
Flutter SDK    → deprecated widget removed
```

```
Deprecated
   ↓
Deprecated + warning
   ↓
Removed
```

Address deprecation warnings early — waiting until removal turns a small edit into an emergency migration.

---

## 4. Migration Strategies

```
Read the migration guide
   ↓
Update one dependency/API at a time
   ↓
Run tests after each step
   ↓
Commit in small, revertable chunks
```

Avoid big-bang migrations that touch dozens of files at once — they're hard to review and hard to bisect if something breaks.

---

## 5. Technical Debt

```
Shortcut taken today
     ↓
Slower development tomorrow
```

```
Examples:
- Duplicated logic instead of a shared function
- Skipped tests
- Hardcoded values "for now"
```

Not all debt is bad — sometimes shipping fast is the right call. The mistake is never paying it back.

---

## 6. Backward Compatibility

Users don't all update at once.

```
v1.0 users  → still calling old API
v1.5 users  → calling new API
```

```
Server: support both API versions during a transition window
App: handle old cached data gracefully after a schema change
```

---

## 7. Production Bug Fixing

```
Bug reported / crash detected
   ↓
Reproduce (use crash reports + user-impact data from Topic 13)
   ↓
Fix + test
   ↓
Release as a patch (bump build number, Topic 9)
   ↓
Monitor the fix actually worked
```

```
Hotfix  → urgent, narrow, minimal-risk change
Regular release → bundled with other work
```

Never ship a production hotfix without at least testing the specific broken path.

---

## 🧠 Mental Model

```
Maintenance loop:

Dependencies age
   ↓
SDK evolves
   ↓
Breaking changes appear
   ↓
Migrate deliberately
   ↓
Pay down debt when it slows you down
   ↓
Fix bugs, respecting users on older versions
   ↓
Repeat
```

> **Rule of thumb:** An app that's never maintained doesn't stay the same — it slowly becomes broken, insecure, and impossible to update safely.

## Key Takeaways

- Update dependencies and the SDK regularly, in small steps.
- Address deprecation warnings before they become breaking removals.
- Migrate incrementally with tests, not all at once.
- Support users on older app versions during transitions.
- Prioritize production fixes using real crash/impact data, not guesswork.

## Practice

1. Run `flutter pub outdated` on a project and upgrade one package safely.
2. Find a deprecated API in your code and migrate it before it's removed.
3. Explain why a big-bang dependency upgrade is riskier than incremental ones.