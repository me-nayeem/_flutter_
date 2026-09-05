# Phase 8 — Professional Flutter Development

## Topic 6: Environment Configuration

> **Core idea:** A production app never uses one fixed set of URLs, keys, or settings. It needs different configurations for different environments, without mixing them up.

---

## 1. Development Environment

The environment you use while building the app.

```
Dev API: https://dev-api.example.com
Debug logging: ON
Crash reporting: OFF
```

Fast iteration matters more than stability here. Fake or sandboxed data is common.

---

## 2. Staging Environment

A near-production copy used for testing before release.

```
Staging API: https://staging-api.example.com
Debug logging: Limited
Crash reporting: ON
```

QA and stakeholders test here. It should behave like production but with real, isolated data.

---

## 3. Production Environment

What real users actually run.

```
Prod API: https://api.example.com
Debug logging: OFF
Crash reporting: ON
```

Mistakes here are expensive, so production must be reached deliberately, not by accident.

---

## 4. Configuration Separation

Don't hardcode one URL and edit it manually before every release.

```
AppConfig
├── apiUrl
├── enableLogging
└── environmentName
```

A common pattern is one config class per environment, selected at build time:

```dart
class AppConfig {
  final String apiUrl;
  final bool enableLogging;

  const AppConfig({required this.apiUrl, required this.enableLogging});
}

const devConfig = AppConfig(
  apiUrl: 'https://dev-api.example.com',
  enableLogging: true,
);

const prodConfig = AppConfig(
  apiUrl: 'https://api.example.com',
  enableLogging: false,
);
```

The rest of the app depends on `AppConfig`, not on any specific environment.

---

## 5. Environment Variables

Values injected at build/run time instead of written into source code.

```
flutter run --dart-define=API_URL=https://dev-api.example.com
```

```dart
const apiUrl = String.fromEnvironment('API_URL');
```

This keeps environment-specific values out of the codebase itself.

---

## 6. Secrets Management

API keys, tokens, and credentials should never be committed to source control.

```
.env
.env.local
secrets.json
```

```
# .gitignore
.env
secrets.json
```

Prefer `--dart-define`, CI/CD secret stores, or platform key management over hardcoded strings — a secret in a public GitHub repo is a secret that's already leaked.

---

## 🧠 Mental Model

```
Environment
├── Dev      → fast iteration, fake data
├── Staging  → production-like, real testing
└── Prod     → real users, real stakes

Config      → one source, many environments
Variables   → injected, not hardcoded
Secrets     → never in source control
```

> **Rule of thumb:** The code should never know it's "in production." It should only know it's using `AppConfig`, and the correct config should be chosen outside the app logic.

## Key Takeaways

- Dev, staging, and production serve different purposes — don't blur them.
- Centralize environment differences into one config object.
- Use environment variables instead of hardcoded values.
- Never commit secrets; use `.gitignore` and secret managers.

## Practice

1. Create `AppConfig` classes for dev and prod with different `apiUrl` values.
2. Pass an API key via `--dart-define` and read it with `String.fromEnvironment`.
3. Explain why a `.env` file should be gitignored even in a private repo.