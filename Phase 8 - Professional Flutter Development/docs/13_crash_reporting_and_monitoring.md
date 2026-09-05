# Phase 8 — Professional Flutter Development

## Topic 13: Crash Reporting and Monitoring

> **Core idea:** Once an app ships, you lose your debugger. Monitoring tools are how you find out something broke — before users have to tell you.

---

## 1. Crash Reporting

Automatically captures uncaught exceptions from real users' devices and sends them to a dashboard.

```
User's device
   ↓
App crashes
   ↓
Stack trace + device info sent
   ↓
Crash dashboard
```

```dart
FlutterError.onError = (details) {
  FirebaseCrashlytics.instance.recordFlutterError(details);
};
```

---

## 2. Error Tracking

Not every error is a full crash — caught exceptions, failed API calls, and handled errors are worth tracking too.

```
try {
  await fetchData();
} catch (e, stack) {
  ErrorTracker.report(e, stack);
}
```

```
Crash        → app died
Tracked error → app survived, but something went wrong
```

---

## 3. Performance Monitoring

Tracks real-world performance, not just what you see on your dev device:

```
App start time
Screen render time
Network request duration
Frame drops (jank)
```

```
Fast on your flagship phone
     ≠
Fast on a user's 3-year-old budget device
```

---

## 4. Release Monitoring

Watch metrics immediately after a release goes live:

```
New version rolled out
   ↓
Crash rate spikes?
   ↓
Pause rollout / hotfix
```

This is why staged rollouts (Topic 12) pair naturally with monitoring — you can catch a bad release at 5% instead of 100%.

---

## 5. User-Impact Analysis

Not all crashes are equal — prioritize by how many users they affect:

```
Crash A → 1 user, rare device
Crash B → 40% of users, common flow
```

```
Fix order: highest user impact first, not just "most recent."
```

---

## 6. Tools

```
Firebase Crashlytics → free, tight Firebase integration, crash + basic analytics
Sentry               → detailed error tracking, works well across platforms/stacks
Other options        → Datadog, Bugsnag, New Relic Mobile
```

Most teams pick one crash/error tool and one performance tool (sometimes the same product covers both).

---

## 🧠 Mental Model

```
Ship app
   ↓
Crash reporting  → what broke
Error tracking   → what almost broke
Performance mon. → what's slow
Release mon.     → is this release healthy?
User-impact      → what to fix first
```

> **Rule of thumb:** If you can't see what's happening in production, you're debugging blind. Monitoring replaces guessing with data.

## Key Takeaways

- Crash reporting captures uncaught exceptions from real devices automatically.
- Error tracking catches handled failures crash reporting alone misses.
- Performance monitoring reflects real users' devices, not your dev machine.
- Prioritize fixes by user impact, and watch new releases closely after rollout.

## Practice

1. Integrate Firebase Crashlytics or Sentry into a sample app.
2. Manually report a caught exception instead of letting it crash silently.
3. Explain why a rare crash affecting 40% of users matters more than a common crash affecting 1%.