# 10. Authentication

## What is Authentication?

**Authentication = verifying who the user is.**

For example, when a user enters:

```text
Email:    nayeem@example.com
Password: ********
```

your backend needs to answer:

> "Is this actually Nayeem's account, and are the credentials correct?"

If yes, the backend authenticates the user.

---

## Authentication vs Authorization

These two terms are often confused.

### Authentication

> **Who are you?**

Example:

```text
Email + Password
       ↓
   Verify identity
       ↓
   User authenticated
```

### Authorization

> **What are you allowed to do?**

For example:

```text
Normal User
    ↓
Can view own profile
Can create tasks

Admin
    ↓
Can view all users
Can delete users
Can manage system
```

So:

```text
Authentication → Identity
Authorization  → Permissions
```

Authentication usually happens **before** authorization.

---

# The Complete Authentication System

A typical Flutter application looks like this:

```text
                    Flutter App
                        │
                        │
                 Login/Register
                        │
                        ▼
                  REST API
                        │
                        ▼
                    Backend
                        │
                        ▼
                    Database
```

After successful login:

```text
Backend
   │
   │ returns tokens
   ▼
Flutter App
   │
   ├── Access Token
   └── Refresh Token
```

The Flutter application can then use the access token to make authenticated API requests.

---

# 1. Login

Login is the process where an existing user proves their identity.

Usually the user provides:

```text
Email
Password
```

Flutter sends something like:

```http
POST /auth/login
Content-Type: application/json
```

Request body:

```json
{
  "email": "nayeem@example.com",
  "password": "mypassword"
}
```

The backend:

```text
Receive email/password
        ↓
Find user
        ↓
Verify password
        ↓
Credentials correct?
      /       \
    YES        NO
     ↓          ↓
Generate      Reject
tokens        request
```

If successful, the server might return:

```json
{
  "accessToken": "eyJhbGci...",
  "refreshToken": "eyJhbGci..."
}
```

---

# 2. Registration

Registration is different from login.

### Registration

> Create a new account.

### Login

> Authenticate an existing account.

For registration:

```http
POST /auth/register
```

Request:

```json
{
  "name": "Nayeem",
  "email": "nayeem@example.com",
  "password": "mypassword"
}
```

Backend:

```text
Receive information
        ↓
Validate input
        ↓
Check email
        ↓
Hash password
        ↓
Create user
        ↓
Save to database
```

The important professional point is:

> **Passwords should not be stored as plain text in the database.**

The backend should securely hash passwords before storing them.

---

# Login vs Registration

|                  | Registration     | Login                   |
| ---------------- | ---------------- | ----------------------- |
| Purpose          | Create account   | Access existing account |
| Typical endpoint | `/auth/register` | `/auth/login`           |
| Input            | User information | Credentials             |
| Database         | Creates user     | Finds/verifies user     |
| Result           | Account created  | User authenticated      |

---

# 3. Tokens

After login, you don't want the Flutter app to send the user's password with every API request.

Imagine doing this:

```http
GET /profile

email: nayeem@example.com
password: mypassword
```

Every request would expose sensitive credentials unnecessarily.

Instead, after successful authentication, the server gives the client a **token**.

Think of a token as a temporary credential:

```text
Login
  ↓
Server verifies credentials
  ↓
Token issued
  ↓
Flutter stores token
  ↓
Use token for authenticated requests
```

Then:

```http
GET /profile
Authorization: Bearer <access-token>
```

The server checks the token.

---

# What is a Bearer Token?

You'll commonly see:

```http
Authorization: Bearer eyJhbGci...
```

The structure is:

```text
Authorization:
        ↓
Bearer
        ↓
Token
```

`Bearer` essentially indicates that the request is presenting a token as its credential.

---

# 4. Access Tokens

An **access token** is used to access protected resources.

For example:

```http
GET /profile
Authorization: Bearer ACCESS_TOKEN
```

or:

```http
GET /tasks
Authorization: Bearer ACCESS_TOKEN
```

The backend verifies the token and, if valid, allows the request.

---

## Why should access tokens usually expire?

Imagine someone gets hold of an access token.

If it never expires:

```text
Attacker gets token
       ↓
Can potentially use it
       ↓
For a very long time
```

If it expires:

```text
Attacker gets token
       ↓
Token eventually expires
       ↓
Cannot use expired token
```

So access tokens are commonly **short-lived**.

For example, conceptually:

```text
Access token
     ↓
Expires after some period
```

The exact lifetime depends on the backend's security design.

---

# 5. Refresh Tokens

Now we have a problem.

If access tokens expire frequently, the user would constantly have to log in again.

That would be terrible UX.

That's why many authentication systems use a **refresh token**.

The basic idea:

```text
                 Login
                   │
                   ▼
          ┌──────────────────┐
          │ Backend returns  │
          │                  │
          │ Access Token     │
          │ Refresh Token    │
          └────────┬─────────┘
                   │
          ┌────────┴────────┐
          ▼                 ▼
    Access Token       Refresh Token
    short-lived         longer-lived
```

---

## Access token expires

Suppose:

```text
Access Token
     ↓
Expired
```

Flutter tries:

```http
GET /tasks
Authorization: Bearer EXPIRED_ACCESS_TOKEN
```

Server responds:

```http
401 Unauthorized
```

The application can then use the refresh token:

```http
POST /auth/refresh
```

Request:

```json
{
  "refreshToken": "REFRESH_TOKEN"
}
```

Server verifies it and issues a new access token:

```json
{
  "accessToken": "NEW_ACCESS_TOKEN"
}
```

Then Flutter retries:

```http
GET /tasks
Authorization: Bearer NEW_ACCESS_TOKEN
```

The user doesn't necessarily need to log in again.

---

# Access Token vs Refresh Token

This distinction is extremely important.

|                     | Access Token          | Refresh Token           |
| ------------------- | --------------------- | ----------------------- |
| Purpose             | Access protected APIs | Obtain new access token |
| Lifetime            | Usually shorter       | Usually longer          |
| Sent to normal APIs | Yes                   | No                      |
| Used to refresh     | No                    | Yes                     |
| Sensitivity         | Sensitive             | **Very sensitive**      |

Think:

> **Access token = key you use frequently**

> **Refresh token = key used to get a new access key**

---

# Complete Token Flow

Here's the flow you should understand:

```text
                    LOGIN
                      │
                      ▼
              Backend verifies
                credentials
                      │
                      ▼
             ┌─────────────────┐
             │ Access Token    │
             │ Refresh Token   │
             └────────┬────────┘
                      │
                      ▼
               Store securely
                      │
                      ▼
             API request
                      │
                      ▼
             Access Token
                      │
                      ▼
                Server
                      │
             ┌────────┴────────┐
             │                 │
           Valid             Expired
             │                 │
             ▼                 ▼
          Response       Refresh Token
                               │
                               ▼
                        New Access Token
                               │
                               ▼
                         Retry request
```

This is one of the most important authentication flows to understand before implementing authentication in Flutter.

---

# 6. Secure Storage Concepts

Now comes a very important question:

> **Where should Flutter store the tokens?**

You shouldn't casually put sensitive authentication tokens into ordinary storage.

For example, you might have:

```text
SharedPreferences
```

which is useful for simple preferences such as:

```text
darkMode = true
language = "English"
```

But authentication credentials require stronger protection.

---

## Secure storage

Flutter applications can use secure storage mechanisms provided by the platform, typically backed by facilities such as:

```text
Android → Keystore
iOS     → Keychain
```

A Flutter secure-storage package can provide a common API over these platform mechanisms.

Conceptually:

```text
Flutter
   │
   ▼
Secure Storage
   │
   ├── Access Token
   └── Refresh Token
```

The important concept isn't memorizing a package.

Understand this:

> **Sensitive authentication credentials should be stored using appropriate secure platform-backed storage rather than ordinary preference storage.**

---

# 7. Authentication State

Now imagine the user opens your Flutter app.

How does the app know:

> "The user is already logged in."

You need an **authentication state**.

Conceptually:

```text
Auth State
   │
   ├── Unknown
   ├── Authenticated
   └── Unauthenticated
```

---

## When the app starts

The application might do:

```text
App starts
   ↓
Check stored authentication information
   ↓
Is valid authentication available?
      /        \
    YES         NO
     ↓           ↓
Authenticated  Login screen
```

---

## Example UI flow

### Unauthenticated

```text
┌─────────────────────┐
│                     │
│      Login          │
│                     │
│ Email               │
│ Password            │
│                     │
│      [ Login ]      │
│                     │
└─────────────────────┘
```

### Authenticated

```text
┌─────────────────────┐
│ Hello, Nayeem       │
│                     │
│ Today's Tasks       │
│                     │
│ ☑ Learn Dart        │
│ ☐ Learn Flutter     │
│ ☐ Learn REST API    │
│                     │
└─────────────────────┘
```

Your app's navigation/UI can depend on authentication state.

---

# Authentication State vs Token

These aren't exactly the same thing.

### Token

A credential used when communicating with the backend.

```text
accessToken = "..."
```

### Authentication state

The application's current understanding of the user's authentication status.

```text
authenticated
```

You might have:

```text
AuthState
   │
   ├── loading
   ├── authenticated
   └── unauthenticated
```

The authentication state is something your **Flutter application manages for its UI and behavior**.

---

# 8. Logout

Logout means ending the user's authenticated session from the application's perspective.

A simple client-side flow might be:

```text
User taps Logout
       ↓
Delete stored credentials
       ↓
Clear authentication state
       ↓
Navigate to Login
```

For example:

```text
Secure Storage
      │
      ├── Access Token ❌
      └── Refresh Token ❌
```

Then:

```text
AuthState
    ↓
Unauthenticated
```

and the application shows:

```text
Login Screen
```

---

# But Logout Can Be More Complex

In a more advanced authentication system, the backend may also need to invalidate/revoke the refresh token or session.

For example:

```http
POST /auth/logout
```

Flutter:

```text
        Flutter
           │
           ▼
      /auth/logout
           │
           ▼
        Backend
           │
           ▼
 Revoke/invalidate session
           │
           ▼
 Flutter clears local credentials
```

So logout can involve **both server-side and client-side work**, depending on the authentication architecture.

---

# Complete Authentication Architecture

Now put everything together:

```text
                         FLUTTER APP
                              │
               ┌──────────────┴──────────────┐
               │                             │
          Auth State                   Secure Storage
               │                             │
               │                     ┌───────┴───────┐
               │                     │               │
               │                Access Token    Refresh Token
               │
               ▼
             Login
               │
               ▼
          REST API
               │
               ▼
           Backend
               │
               ▼
           Database
```

---

# Complete Login → API → Refresh → Logout Flow

This is the flow I'd recommend you memorize conceptually:

```text
                ┌──────────────┐
                │    Login     │
                └──────┬───────┘
                       │
                 Email + Password
                       │
                       ▼
                  Auth Server
                       │
                Credentials valid?
                  /           \
                NO             YES
                │               │
                ▼               ▼
              Error      Access + Refresh
                              Tokens
                                │
                                ▼
                         Secure Storage
                                │
                                ▼
                       Authenticated State
                                │
                                ▼
                         Protected API
                                │
                                ▼
                         Access Token
                                │
                         ┌──────┴──────┐
                         │             │
                       Valid         Expired
                         │             │
                         ▼             ▼
                      Response    Refresh Token
                                       │
                                       ▼
                                New Access Token
                                       │
                                       ▼
                                  Retry API
                                       │
                                       ▼
                                     Data


                 LOGOUT
                    │
                    ▼
             Logout endpoint
                    │
                    ▼
           Clear local tokens
                    │
                    ▼
         Unauthenticated State
                    │
                    ▼
               Login Screen
```

---

# How This Looks in a Flutter Project

As your Flutter applications become more professional, you might eventually have something conceptually similar to:

```text
lib/
├── core/
│   ├── network/
│   └── storage/
│
├── features/
│   └── auth/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── main.dart
```

And the responsibilities might be separated:

```text
Auth UI
   ↓
Auth Controller / State Management
   ↓
Auth Repository
   ↓
Auth API
   ↓
Backend
```

While token management might involve:

```text
Auth Repository
      ↓
Secure Storage
      ↓
Access / Refresh Tokens
```

You don't need to learn this architecture yet. **First understand the authentication lifecycle.** Architecture and implementation patterns will make much more sense afterward.

---

# Common Mistakes to Avoid

### ❌ Sending the password with every request

Don't do:

```text
GET /tasks
email + password
```

Instead, authenticate once and use appropriate tokens.

---

### ❌ Storing sensitive tokens carelessly

Don't treat authentication tokens like ordinary preferences.

Use appropriate secure storage mechanisms.

---

### ❌ Treating an expired access token as "user logged out"

An expired access token can simply mean:

```text
Access token expired
        ↓
Use refresh token
        ↓
Get new access token
```

The user may still have a valid authenticated session.

---

### ❌ Mixing authentication and authorization

Remember:

```text
Authentication
"Who are you?"

Authorization
"What can you do?"
```

---

# The 8 Concepts You Should Remember

| Concept                  | Meaning                                                 |
| ------------------------ | ------------------------------------------------------- |
| **Login**                | Verify an existing user's credentials                   |
| **Registration**         | Create a new user account                               |
| **Token**                | Credential used to authenticate requests                |
| **Access token**         | Short-lived credential used for protected APIs          |
| **Refresh token**        | Used to obtain a new access token                       |
| **Secure storage**       | Appropriate protected storage for sensitive credentials |
| **Authentication state** | Whether the app considers the user authenticated        |
| **Logout**               | End the authenticated session and clear credentials     |

### The professional mental model

Remember this:

> **Register → create account**
> **Login → verify identity**
> **Access token → access APIs**
> **Refresh token → get a new access token**
> **Secure storage → protect credentials**
> **Auth state → control app behavior/UI**
> **Logout → clear/end authentication**

Once these concepts are clear, the next practical step is learning how Flutter actually implements them with **HTTP requests, JSON models, interceptors, secure storage, and authentication state management**.
