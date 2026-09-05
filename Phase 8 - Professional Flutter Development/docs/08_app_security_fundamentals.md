# Phase 8 — Professional Flutter Development

## Topic 8: App Security Fundamentals

> **Core idea:** Mobile apps run on devices you don't control. Treat the client as untrusted, and never assume secrets or data on-device are safe by default.

---

## 1. Secret Management

Never hardcode API keys, private tokens, or credentials directly in Dart source.

```
❌ const apiKey = "sk_live_12345";
✅ apiKey injected via --dart-define or a secure backend
```

Anyone can decompile an app and read hardcoded strings — a "hidden" key in code isn't hidden.

---

## 2. Secure Storage

Don't store sensitive data (tokens, passwords) in `SharedPreferences` — it's unencrypted plain text.

```dart
final storage = FlutterSecureStorage();
await storage.write(key: 'auth_token', value: token);
```

Use `flutter_secure_storage`, which relies on Keychain (iOS) and Keystore (Android).

---

## 3. Authentication Security

```
Login
  ↓
Server validates credentials
  ↓
Server issues token
  ↓
Client stores token securely
```

The client should never decide *whether* a user is authenticated on its own — the server is the source of truth.

---

## 4. Token Handling

```
Access token   → short-lived, sent with each request
Refresh token  → long-lived, used to get new access tokens
```

```
Request fails (401)
     ↓
Use refresh token
     ↓
Get new access token
     ↓
Retry request
```

Expire tokens, rotate refresh tokens, and revoke them on logout.

---

## 5. HTTPS

```
❌ http://api.example.com
✅ https://api.example.com
```

Plain HTTP exposes every request/response to anyone on the network. Always use HTTPS, and consider certificate pinning for high-sensitivity apps.

---

## 6. Avoiding Secrets in Git

```
# .gitignore
.env
secrets.json
google-services.json   (if it contains sensitive keys)
```

A secret committed once stays in Git history forever, even if deleted later — rotate it immediately if that happens.

---

## 7. Basic Mobile Security Principles

```
Treat the client as untrusted
Validate everything again on the server
Encrypt sensitive data at rest
Use HTTPS always
Never trust data from local storage blindly
```

> **Golden rule:** Any check that only happens on the device can be bypassed. Real security decisions happen on the server.

---

## 🧠 Mental Model

```
Client (untrusted)
     ↓
HTTPS
     ↓
Server (source of truth)
     ↓
Tokens issued, validated, expired
     ↓
Secrets never in source code, never in plain storage
```

## Key Takeaways

- Never hardcode secrets — inject them at build/run time.
- Use secure storage for tokens, not `SharedPreferences`.
- The server, not the client, is the authority on authentication.
- Always use HTTPS; never commit secrets to Git.

## Practice

1. Move a hardcoded API key to `--dart-define`.
2. Store an auth token using `flutter_secure_storage` instead of `SharedPreferences`.
3. Explain why deleting a committed secret from a later commit isn't enough.