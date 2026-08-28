# 9. Local Persistence

Imagine your Study Tracker app.

A user creates:

```text
Today's Tasks
────────────────────
☑ Learn Dart
☑ Learn REST API
☐ Learn Flutter
```

If you only keep these tasks in memory, closing the app could make them disappear.

With local persistence:

```text
Flutter App
     │
     ▼
Local Storage
     │
     ├── Tasks
     ├── Settings
     ├── User preferences
     └── Cached API data
```

When the app starts again:

```text
Local Storage
     │
     ▼
Flutter App
     │
     ▼
Display previous data
```

---

# 1. Key-Value Storage

## What is it?

**Key-value storage** stores data as a pair:

```text
key → value
```

For example:

```text
username → "Nayeem"
darkMode → true
language → "English"
theme → "dark"
```

Think of it like a simple dictionary:

```text
┌──────────────┬──────────────┐
│ Key          │ Value        │
├──────────────┼──────────────┤
│ username     │ Nayeem       │
│ darkMode     │ true         │
│ language     │ English      │
└──────────────┴──────────────┘
```

---

## When should you use it?

Key-value storage is good for **small, simple pieces of data**.

For example:

```text
Is the user logged in?
→ true

Selected theme?
→ dark

Onboarding completed?
→ true

User's preferred language?
→ English
```

It is **not normally the right choice for large, relational datasets**.

---

## Flutter example

A common Flutter approach is using a package such as `shared_preferences`.

Conceptually:

```dart
await prefs.setBool('isLoggedIn', true);
```

Later:

```dart
final isLoggedIn = prefs.getBool('isLoggedIn');
```

So:

```text
setBool()
    ↓
key: isLoggedIn
value: true
```

Then:

```text
getBool('isLoggedIn')
    ↓
true
```

### Mental model

```text
Key-Value Storage
       │
       ├── "username" → "Nayeem"
       ├── "isLoggedIn" → true
       └── "darkMode" → false
```

**Use it when the question is:**

> "I just need to remember this small value."

---

# 2. Local Databases

Now imagine your Study Tracker has **10,000 study sessions**.

You might have:

```text
Study Sessions
────────────────────────
id | subject | duration | date
1  | Dart    | 60 min   | Aug 20
2  | Flutter | 90 min   | Aug 21
3  | C++     | 45 min   | Aug 21
...
```

Key-value storage isn't ideal for managing this kind of structured data.

That's where a **local database** comes in.

---

## What is a local database?

A local database stores structured data **directly on the user's device**.

Conceptually:

```text
Flutter
   │
   ▼
Local Database
   │
   ├── Users
   ├── Tasks
   ├── Study Sessions
   └── Notes
```

The data doesn't need to travel to your backend every time you want to read it.

---

## Example

Suppose you have:

```text
Task
──────────────
id
title
completed
createdAt
```

A database can contain:

```text
1 | Learn Dart       | true  | 2026-08-20
2 | Learn Flutter    | false | 2026-08-21
3 | Learn REST API   | true  | 2026-08-22
```

You can then perform operations such as:

```text
INSERT
SELECT
UPDATE
DELETE
```

These correspond to CRUD:

```text
Create → INSERT
Read   → SELECT
Update → UPDATE
Delete → DELETE
```

---

## Local database vs key-value storage

This distinction is extremely important.

|                | Key-Value            | Local Database   |
| -------------- | -------------------- | ---------------- |
| Data           | Simple values        | Structured data  |
| Example        | `darkMode → true`    | Tasks table      |
| Querying       | Limited              | Powerful         |
| Relationships  | Poor fit             | Can support them |
| Large datasets | Not ideal            | Good             |
| Typical use    | Settings/preferences | App data         |

Think:

> **Key-value = remember a value.**

> **Database = manage a collection of data.**

---

# 3. Caching

Caching is one of the most important concepts when working with REST APIs.

Suppose your Flutter app requests:

```http
GET /courses
```

The server responds:

```json
[
  {
    "id": 1,
    "name": "Dart"
  },
  {
    "id": 2,
    "name": "Flutter"
  }
]
```

Instead of throwing this data away after displaying it, your application can **save a local copy**.

That local copy is a **cache**.

```text
               API Server
                   │
                   │
                   ▼
              Flutter App
                   │
                   ▼
              Local Cache
```

---

## Why cache data?

Imagine the user opens your app.

Without caching:

```text
Open App
   ↓
Internet request
   ↓
Server
   ↓
Response
   ↓
Show courses
```

If the internet is slow:

```text
Open App
   ↓
Waiting...
   ↓
Waiting...
   ↓
Waiting...
```

With caching:

```text
Open App
   ↓
Read cached courses
   ↓
Show courses immediately
   ↓
Fetch latest courses
   ↓
Update cache
```

This can make an application feel **much faster**.

---

# Cache example

Suppose the first API request happens at 10:00:

```text
Server:
Flutter
Dart
C++
```

Your app saves:

```text
Cache:
Flutter
Dart
C++
```

At 10:05, the user opens the app.

The app can immediately display:

```text
Flutter
Dart
C++
```

Then make a network request:

```text
Server
   ↓
Latest data
   ↓
Update cache
   ↓
Update UI
```

This is often called a **cache-first / stale-while-revalidate style** approach depending on the exact strategy.

---

# 4. Offline Data

Caching naturally leads to another important concept:

> **What happens when there is no internet?**

Suppose your user is on a flight.

They open your Study Tracker.

There is no network:

```text
Flutter App
     X
     │
   Internet
     X
```

But you already have local data:

```text
Local Database
      │
      ▼
Flutter App
```

So the app can still display previously downloaded information.

That's **offline data support**.

---

## Online-only app

```text
App
 │
 ▼
Internet
 │
 ▼
Server
 │
 ▼
Data
```

No internet:

```text
App
 │
 X
Internet
```

The app can't retrieve the data.

---

## Offline-capable app

```text
             ┌──────────────┐
             │ Flutter App  │
             └──────┬───────┘
                    │
          ┌─────────┴─────────┐
          ▼                   ▼
     Local Database        REST API
          │                   │
          ▼                   ▼
      Cached Data          Server
```

Now the app can work with local data even when the network isn't available.

---

# 5. Persistence Strategies

This is where you start thinking like an application developer rather than simply learning storage APIs.

The question isn't:

> "Which database package should I use?"

The better question is:

> **"What data should be stored locally, where should it be stored, and when should it be synchronized with the server?"**

That's a **persistence strategy**.

---

## Strategy 1 — Local-only

Some data doesn't need a server at all.

Example:

```text
Theme preference
Font size
Onboarding completed
```

Architecture:

```text
Flutter
  │
  ▼
Local Storage
```

No API required.

---

# Strategy 2 — Server-only

Some data can always come from the backend.

For example:

```text
Public announcements
```

You might simply do:

```text
Flutter
   ↓
API
   ↓
Server
   ↓
Response
```

No local persistence necessary.

---

# Strategy 3 — Cache server data

You retrieve data from the server and keep a local copy.

```text
             API
              │
              ▼
         Flutter App
              │
              ▼
            Cache
```

Next time:

```text
Cache → UI
  │
  └──→ API → latest data
```

This improves perceived performance and can provide limited offline functionality.

---

# Strategy 4 — Offline-first

This is a more advanced approach.

The application treats the **local database as the primary source for the UI**, while synchronization with the server happens in the background.

For example:

```text
User creates task
       │
       ▼
Local Database
       │
       ▼
UI updates immediately
       │
       ▼
Internet available?
       │
      YES
       │
       ▼
Sync with Server
```

If there is no internet:

```text
User creates task
       │
       ▼
Local Database
       │
       ▼
UI updates
       │
       X
    Internet
       │
       │
   Wait for network
       │
       ▼
    Sync later
```

This produces a very responsive experience.

---

# A real Flutter application architecture

As you become more advanced, you might structure your application something like this:

```text
                 Flutter UI
                     │
                     ▼
                Repository
                /         \
               /           \
              ▼             ▼
       Local Data Source   Remote Data Source
              │             │
              ▼             ▼
       Local Database      REST API
              │             │
              ▼             ▼
          Device          Backend
```

The **Repository** decides how data should be obtained.

For example:

```text
UI asks:
"Give me tasks"

        ↓

Repository

        ↓

Is cached/local data available?

      /       \
    YES        NO
     │          │
     ▼          ▼
 Local DB      API
     │          │
     └────┬─────┘
          ▼
         UI
```

Later, you may learn this pattern in much more depth when you reach Flutter architecture.

---

# An important distinction: Storage vs Cache

These concepts can look similar but have different purposes.

### Persistent data

You generally consider it important enough to keep.

Examples:

```text
User-created tasks
Notes
Study history
App settings
```

### Cached data

You can generally **recreate it from another source**.

Examples:

```text
Downloaded course list
Recent API response
Product catalog
News articles
```

A useful question is:

> **"If I delete this local data, can I retrieve/rebuild it from somewhere else?"**

If yes, it may be cache.

---

# Example: Study Tracker

Let's design storage for your Study Tracker.

### User preferences

```text
darkMode
notificationsEnabled
selectedLanguage
```

Use:

```text
Key-value storage
```

---

### Tasks

```text
id
title
description
completed
deadline
```

Use:

```text
Local database
```

---

### Study history

```text
subject
duration
startTime
endTime
```

Use:

```text
Local database
```

---

### API course list

```text
Dart
Flutter
REST API
OOP
```

Use:

```text
Cache
```

---

### Offline-created tasks

```text
User creates task
      ↓
Local database
      ↓
Internet unavailable
      ↓
Keep task locally
      ↓
Internet returns
      ↓
Sync with server
```

Use:

```text
Offline-first / synchronization strategy
```

---

# How all five concepts connect

```text
                  LOCAL PERSISTENCE
                         │
          ┌──────────────┼──────────────┐
          │              │              │
          ▼              ▼              ▼
     Key-Value       Database        Cache
          │              │              │
          │              │              │
       Simple          Structured     Temporary/
        data             data         reusable data
          │              │              │
          └──────────────┼──────────────┘
                         ▼
                   Offline Data
                         │
                         ▼
                Persistence Strategy
```

The progression is important:

```text
Store data
   ↓
Understand different storage types
   ↓
Cache server data
   ↓
Support offline usage
   ↓
Design a persistence/sync strategy
```

## What you should be able to answer

After learning this topic, you should be able to explain:

**Q: Where would you store `darkMode = true`?**

→ Key-value storage.

**Q: Where would you store 5,000 study sessions?**

→ Local database.

**Q: What is cached API data?**

→ A locally stored copy of data obtained from another source, usually the server.

**Q: Why cache API responses?**

→ Faster UI, reduced network requests, and potentially limited offline access.

**Q: What is offline data?**

→ Data that the application can access/use without an active network connection.

**Q: What is a persistence strategy?**

→ A deliberate design for deciding **what data is stored locally, how it is stored, when it is read, and how it is synchronized with remote data**.

### Professional mental model

Remember it this way:

> **Key-value → small values**
> **Database → structured application data**
> **Cache → locally keep data you can retrieve again**
> **Offline → app can work without network**
> **Persistence strategy → decide how all of these work together**

This topic becomes particularly important once your Flutter applications start combining **REST APIs + authentication + local storage + state management**. That's where you stop building apps that merely "fetch data" and start building apps that behave reliably in real-world network conditions.
