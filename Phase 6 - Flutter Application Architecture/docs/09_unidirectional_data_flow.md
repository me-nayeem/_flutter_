# Phase 6 — Architecture

## 9. Unidirectional Data Flow (UDF)

Now we can connect almost everything we've learned so far.

The core idea is:

> **Data and events move in one predictable direction through the application.**

Your roadmap represents it like this:

```text
User Action
     ↓
State / ViewModel
     ↓
Repository
     ↓
Data Source
     ↓
New State
     ↓
UI
```

This pattern makes the application easier to understand because you always know **where an action goes and where the resulting state comes from**.

---

# 1. What does "Unidirectional" mean?

**Uni = one**

**Directional = direction**

So:

> **Unidirectional Data Flow = information follows a predictable one-way path.**

For example:

```text
User taps "Load Users"
        ↓
    ViewModel
        ↓
    Repository
        ↓
   Data Source
        ↓
    New Data
        ↓
    New State
        ↓
       UI
```

The UI doesn't directly manipulate the repository.

The repository doesn't directly modify the UI.

Each part communicates through defined boundaries.

---

# 2. The Basic Cycle

A typical Flutter feature can follow this cycle:

```text
        ┌──────────────────────┐
        │         UI           │
        └──────────┬───────────┘
                   │
              User Event
                   ↓
        ┌──────────────────────┐
        │     ViewModel        │
        └──────────┬───────────┘
                   ↓
        ┌──────────────────────┐
        │     Repository       │
        └──────────┬───────────┘
                   ↓
        ┌──────────────────────┐
        │     Data Source      │
        └──────────┬───────────┘
                   ↓
                New Data
                   ↓
        ┌──────────────────────┐
        │     ViewModel        │
        │     New State        │
        └──────────┬───────────┘
                   ↓
        ┌──────────────────────┐
        │         UI           │
        └──────────────────────┘
```

The UI displays the current state.

The user generates an event.

The ViewModel handles it.

The data layer performs the operation.

The ViewModel receives the result and produces new state.

The UI renders that state.

---

# 3. Example: Loading Users

Suppose we have a screen displaying users.

Initially:

```dart
class UserState {
  final bool isLoading;
  final List<User> users;
  final String? error;

  UserState({
    this.isLoading = false,
    this.users = const [],
    this.error,
  });
}
```

The UI observes:

```text
isLoading
users
error
```

---

## User performs an action

The user opens the screen or taps Refresh:

```text
User
 ↓
"Refresh"
```

The UI tells the ViewModel:

```dart
viewModel.loadUsers();
```

The UI doesn't fetch the API itself.

---

# 4. ViewModel Handles the Event

The ViewModel changes the state:

```dart
Future<void> loadUsers() async {
  state = UserState(
    isLoading: true,
  );

  notifyListeners();

  final users = await repository.getUsers();

  state = UserState(
    users: users,
  );

  notifyListeners();
}
```

The important sequence is:

```text
Event
 ↓
loadUsers()
 ↓
Loading State
 ↓
Repository
 ↓
Result
 ↓
Success State
```

---

# 5. Repository Handles Data Access

The ViewModel doesn't need to know where users come from.

It simply says:

```dart
final users = await repository.getUsers();
```

The repository might do:

```text
Repository
    ↓
Remote Data Source
    ↓
API
```

or:

```text
Repository
    ↓
Local Data Source
    ↓
Database
```

or even:

```text
Repository
    ↓
Cache
```

The ViewModel doesn't need to know the details.

---

# 6. New State Goes Back to the UI

Suppose the API returns:

```text
Nayeem
Rahim
Karim
```

The ViewModel updates:

```text
UserState
 ├── isLoading = false
 ├── users = [...]
 └── error = null
```

Then the UI rebuilds.

For example:

```dart
if (state.isLoading) {
  return const CircularProgressIndicator();
}

return ListView.builder(
  itemCount: state.users.length,
  itemBuilder: (context, index) {
    return Text(
      state.users[index].name,
    );
  },
);
```

The UI doesn't decide:

> "Let's call the API."

It simply says:

> "The state contains these users, so I'll display them."

---

# 7. UI Should Be Mostly a State Renderer

This is a useful professional mindset.

Instead of thinking:

> "The UI controls everything."

Think:

> **"The UI renders state and emits events."**

For example:

```text
UI
│
├── Reads state
│
└── Sends events
```

That's it.

Conceptually:

```dart
Text(state.username)
```

and:

```dart
onPressed: () {
  viewModel.logout();
}
```

The UI displays state and sends an event.

---

# 8. Events Move Down

Suppose the user presses:

```text
Delete Account
```

The event travels downward:

```text
UI
 ↓
ViewModel
 ↓
Repository
 ↓
Data Source
 ↓
Server
```

---

# 9. State Moves Back Up

After the operation:

```text
Server
 ↓
Data Source
 ↓
Repository
 ↓
ViewModel
 ↓
New State
 ↓
UI
```

So you can remember:

```text
Events ↓
State  ↑
```

Or:

```text
          UI
       ↗     ↘
    State    Event
      ↑        ↓
   ViewModel
      ↑        ↓
   Repository
      ↑        ↓
   Data Source
```

---

# 10. Why Is This Useful?

Without UDF, you can end up with confusing communication:

```text
UI → ViewModel
UI → Repository
Repository → UI
Service → UI
Database → Widget
ViewModel → Widget A
Widget B → ViewModel
```

Now it's difficult to answer:

> "Where did this state change come from?"

With unidirectional flow:

```text
Event
 ↓
ViewModel
 ↓
Data Layer
 ↓
New State
 ↓
UI
```

The flow is much easier to trace.

---

# 11. Example: Login

Let's apply UDF to login.

### Initial state

```text
isLoading = false
isLoggedIn = false
error = null
```

### User taps Login

```text
UI
 ↓
login(email, password)
```

### ViewModel

```text
isLoading = true
```

UI now displays:

```text
Loading...
```

### Repository

```text
login()
 ↓
Auth Service
 ↓
API
```

### Successful response

```text
Repository
 ↓
ViewModel
 ↓
isLoggedIn = true
```

### UI

```text
Welcome!
```

Complete flow:

```text
User taps Login
       ↓
Login UI
       ↓
LoginViewModel
       ↓
AuthRepository
       ↓
AuthService
       ↓
API
       ↓
Result
       ↓
AuthRepository
       ↓
LoginViewModel
       ↓
New State
       ↓
Login UI
```

---

# 12. UDF Prevents Random State Changes

Imagine a `UserScreen` has:

```dart
bool isLoading = false;
```

and then several different classes can directly modify it.

That's dangerous.

You could end up with:

```text
Service → changes isLoading
Repository → changes isLoading
Widget → changes isLoading
ViewModel → changes isLoading
```

Who owns the state?

Nobody knows.

With UDF:

```text
ViewModel
    ↓
owns state
```

Other components return results.

The ViewModel decides what the new UI state should be.

---

# 13. State Ownership

This connects directly to the previous topic.

A state holder/ViewModel should generally **own the UI-facing state**.

For example:

```dart
class UserViewModel extends ChangeNotifier {
  UserState _state = UserState();

  UserState get state => _state;
}
```

Other layers don't directly manipulate the UI state.

Instead:

```text
Repository
    ↓
returns result
    ↓
ViewModel
    ↓
updates state
```

This creates a clear owner.

---

# 14. UDF and State Management

Different Flutter state-management solutions can implement this idea.

For example:

```text
Provider
Riverpod
Bloc
Cubit
ValueNotifier
ChangeNotifier
```

They may use different APIs and patterns, but the underlying idea can still be:

```text
Event
 ↓
State logic
 ↓
New State
 ↓
UI
```

So **UDF is a design principle**, not a specific package.

---

# 15. UDF Does Not Mean "Only One Direction Exists"

This wording can sometimes confuse beginners.

The application obviously needs results to come back.

The idea is not:

```text
Data goes down forever
```

Instead, there is a predictable cycle:

```text
EVENT
  ↓
Logic
  ↓
Data operation
  ↓
RESULT
  ↓
NEW STATE
  ↓
UI
```

The key is that **state is not randomly mutated from everywhere**.

---

# 16. A Practical Flutter Example

Imagine:

```dart
ElevatedButton(
  onPressed: () {
    viewModel.loadUsers();
  },
  child: const Text("Load Users"),
)
```

### Event

```text
loadUsers()
```

### ViewModel

```dart
Future<void> loadUsers() async {
  setLoading();

  try {
    final users = await repository.getUsers();

    setUsers(users);
  } catch (e) {
    setError("Failed to load users");
  }
}
```

### Repository

```dart
Future<List<User>> getUsers() {
  return remoteDataSource.getUsers();
}
```

### Result

```text
users
```

### ViewModel

```text
State(users)
```

### UI

```dart
ListView(...)
```

That's UDF in practice.

---

# 17. The Most Important Rule

When building a feature, ask:

### "What event happened?"

```text
Login clicked
Refresh clicked
Item selected
Form submitted
```

Then:

### "Who handles that event?"

Usually:

```text
ViewModel / State Holder
```

Then:

### "Where does the data come from?"

```text
Repository
```

Then:

### "What new state should the UI display?"

```text
ViewModel
```

Finally:

### "How does the UI react?"

```text
Render the new state
```

---

# 18. Complete Mental Model

You can memorize this:

```text
                USER
                  ↓
             User Action
                  ↓
                  UI
                  ↓
             ViewModel
                  ↓
             Repository
                  ↓
             Data Source
                  ↓
            API / Database
                  ↓
                Result
                  ↓
             ViewModel
                  ↓
              New State
                  ↓
                  UI
```

### In one sentence:

> **The UI sends events downward, application/data layers process them, and the resulting state flows back to the UI for rendering.**

---

## ⭐ Final Takeaway

**Unidirectional Data Flow** gives your Flutter application a predictable structure:

```text
User Action
     ↓
ViewModel
     ↓
Repository
     ↓
Data Source
     ↓
Result
     ↓
New State
     ↓
UI
```

The major benefit is **predictability**.

When something goes wrong, you can trace:

> **What event happened → who handled it → what data operation occurred → what state changed → why the UI changed.**

This principle will also make the next topic—**Separation of Concerns**—much easier to understand, because we'll examine exactly **which responsibility belongs to which part of the application**.
