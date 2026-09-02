# Phase 6 — Architecture

## 3. View Models / State Holders

The four things you need to understand are:

* **UI-facing state**
* **Business interaction**
* **State transformation**
* **Event handling**

---

## 1. What is a View Model / State Holder?

A **View Model** or **State Holder** is a class responsible for managing the state that the UI needs.

Think about a login screen.

The UI needs to know things like:

```text
email
password
isLoading
errorMessage
isLoggedIn
```

Instead of putting all of this logic directly inside the UI, we can have a separate class:

```text
UI
 ↓
ViewModel / State Holder
 ↓
Repository
 ↓
API
```

The UI displays the state.

The ViewModel manages the state.

---

# 2. Why do we need it?

Imagine you put everything inside your Flutter widget:

```dart
class LoginScreen extends StatefulWidget {
  ...
}
```

And inside it you have:

```dart
// API call
// validation
// loading state
// error handling
// authentication logic
// UI code
```

The widget can quickly become huge.

For example:

```text
LoginScreen
 ├── TextFields
 ├── Buttons
 ├── validation
 ├── API request
 ├── loading logic
 ├── error handling
 ├── token handling
 └── navigation
```

That's a **Separation of Concerns** problem.

Instead:

```text
LoginScreen
      ↓
 LoginViewModel
      ↓
AuthRepository
      ↓
   API
```

Each part has a clearer responsibility.

---

# 3. UI-facing State

This is the first important concept.

### What does "UI-facing state" mean?

It simply means:

> **The information the UI needs in order to know what to display.**

For example, suppose we're loading a list of users.

The UI might need:

```dart
bool isLoading;
List<User> users;
String? error;
```

We could represent this as:

```dart
class UserState {
  final bool isLoading;
  final List<User> users;
  final String? error;

  UserState({
    required this.isLoading,
    required this.users,
    this.error,
  });
}
```

Now the UI doesn't need to know **how users are fetched**.

It only needs to know:

```text
Loading?
Users?
Error?
```

For example:

```dart
if (state.isLoading) {
  return CircularProgressIndicator();
}

if (state.error != null) {
  return Text(state.error!);
}

return UserList(users: state.users);
```

The UI simply **renders the state**.

---

# 4. State Holder

A State Holder is something that **owns and manages UI state**.

A simple example:

```dart
class CounterViewModel {
  int count = 0;

  void increment() {
    count++;
  }
}
```

The ViewModel owns:

```dart
count
```

and provides an operation:

```dart
increment()
```

But in real Flutter applications, we need a mechanism to notify the UI when state changes.

For example, using `ChangeNotifier`:

```dart
class CounterViewModel extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }
}
```

Now:

```text
User taps button
       ↓
increment()
       ↓
count changes
       ↓
notifyListeners()
       ↓
UI rebuilds
```

That's the basic idea of a state holder.

---

# 5. Business Interaction

A ViewModel shouldn't just store variables.

It also acts as a place where the UI **interacts with application behavior**.

For example:

```dart
class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;

  Future<void> login(
    String email,
    String password,
  ) async {
    // login process
  }
}
```

The UI can simply say:

```dart
viewModel.login(email, password);
```

The UI doesn't need to know:

```text
How HTTP works
How authentication works
Which API endpoint is used
How JSON is parsed
Where the token is stored
```

Those responsibilities belong elsewhere, such as repositories/services.

So the ViewModel becomes a bridge:

```text
UI
 ↓
ViewModel
 ↓
Repository / Service
 ↓
Data source
```

---

# 6. State Transformation

This is a very important concept.

The data coming from your API is not always exactly what the UI needs.

Suppose your API returns:

```json
{
  "first_name": "Nayeem",
  "last_name": "Islam",
  "is_active": true
}
```

But your UI needs:

```text
Nayeem Islam
Active
```

The ViewModel can transform the raw application data into something useful for the UI.

Conceptually:

```text
Repository data
       ↓
ViewModel
       ↓
UI-friendly state
```

For example:

```dart
class UserViewModel extends ChangeNotifier {
  String displayName = "";
  String status = "";

  void updateUser(User user) {
    displayName = "${user.firstName} ${user.lastName}";
    status = user.isActive ? "Active" : "Inactive";

    notifyListeners();
  }
}
```

The UI now doesn't need to perform this transformation itself.

It simply uses:

```dart
Text(viewModel.displayName)
```

and:

```dart
Text(viewModel.status)
```

---

# 7. Event Handling

The UI constantly generates **events**.

Examples:

```text
Button tapped
Text entered
Refresh requested
Login submitted
Item selected
Logout clicked
```

Instead of putting the logic directly inside the UI, the UI sends the event to the ViewModel.

For example:

```dart
ElevatedButton(
  onPressed: () {
    viewModel.login(email, password);
  },
  child: const Text("Login"),
)
```

Here:

```text
Button tap
    ↓
login()
    ↓
ViewModel
```

The ViewModel decides what should happen.

---

# 8. Complete Example

Let's create a simple login flow.

### State

```dart
class LoginState {
  final bool isLoading;
  final String? error;
  final bool isLoggedIn;

  LoginState({
    this.isLoading = false,
    this.error,
    this.isLoggedIn = false,
  });
}
```

This represents everything the UI needs.

---

### ViewModel

```dart
class LoginViewModel extends ChangeNotifier {
  LoginState _state = LoginState();

  LoginState get state => _state;

  Future<void> login(String email, String password) async {
    _state = LoginState(isLoading: true);
    notifyListeners();

    try {
      // Call repository here

      await Future.delayed(
        const Duration(seconds: 2),
      );

      _state = LoginState(
        isLoggedIn: true,
      );

      notifyListeners();
    } catch (e) {
      _state = LoginState(
        error: "Login failed",
      );

      notifyListeners();
    }
  }
}
```

Now look at what's happening.

### Initially

```text
isLoading = false
isLoggedIn = false
error = null
```

User presses Login:

```text
login()
   ↓
isLoading = true
   ↓
UI shows loading
```

After successful login:

```text
isLoggedIn = true
   ↓
UI shows logged-in state
```

If something fails:

```text
error = "Login failed"
   ↓
UI shows error
```

---

# 9. The UI becomes much simpler

The UI doesn't need to understand the login process.

It simply observes state:

```dart
if (viewModel.state.isLoading) {
  return const CircularProgressIndicator();
}

if (viewModel.state.error != null) {
  return Text(viewModel.state.error!);
}

if (viewModel.state.isLoggedIn) {
  return const Text("Welcome!");
}
```

And sends events:

```dart
onPressed: () {
  viewModel.login(email, password);
}
```

This is the key relationship:

```text
                 ViewModel
                    │
       ┌────────────┼────────────┐
       ↓            ↓            ↓
     State       Events      Business
       │            │         interaction
       ↓            ↓            ↓
      UI ←────── updates ────────┘
```

---

# 10. ViewModel vs UI

A useful professional rule is:

### UI should answer:

> **"What should I display?"**

### ViewModel should answer:

> **"What state are we currently in, and what should happen when an event occurs?"**

For example:

❌ Don't do this inside the UI:

```dart
onPressed: () async {
  final response = await http.post(...);

  // parse JSON
  // save token
  // handle errors
  // update state
};
```

That's too much responsibility for the UI.

Instead:

```dart
onPressed: () {
  viewModel.login(email, password);
}
```

Then:

```text
UI
 ↓
ViewModel
 ↓
Repository
 ↓
API
```

---

# 11. ViewModel is NOT the Repository

This distinction is extremely important.

### ViewModel

Responsible for:

```text
UI state
Events
UI-facing transformations
UI-related business interaction
```

### Repository

Responsible for:

```text
Getting data
Saving data
Choosing remote/local source
Data access abstraction
```

So don't do this:

```dart
class LoginViewModel {
  Future<void> login() async {
    final response = await http.post(...);
  }
}
```

if you're trying to maintain a clean architecture.

Prefer:

```text
LoginViewModel
      ↓
AuthRepository
      ↓
API service
```

The ViewModel asks:

> "Please log this user in."

The Repository handles:

> "How do I actually get that data?"

---

# 12. A Real Flutter Architecture

A small application might look like:

```text
lib/
│
├── features/
│   └── login/
│       │
│       ├── login_screen.dart
│       ├── login_view_model.dart
│       └── login_state.dart
│
├── data/
│   ├── repositories/
│   └── services/
│
└── core/
```

The flow:

```text
             USER
               ↓
          Login Screen
               ↓
        Login ViewModel
               ↓
        Auth Repository
               ↓
          API Service
               ↓
             API
               ↓
        Auth Repository
               ↓
        Login ViewModel
               ↓
          New State
               ↓
          Login Screen
```

This is essentially the foundation for the **Unidirectional Data Flow** topic you'll study later in this phase.

---

# 13. The Most Important Mental Model

Don't think:

> "ViewModel is another class where I put random code."

Instead think:

> **A ViewModel is the UI's brain/state manager.**

The UI says:

```text
"User clicked Login."
```

The ViewModel handles that event.

The ViewModel communicates with the appropriate application/data layer.

Then it produces new UI-facing state:

```text
Loading
Success
Error
```

The UI renders that state.

So:

```text
             EVENT
               ↓
              UI
               ↓
          ViewModel
               ↓
       Repository/Service
               ↓
          New Result
               ↓
          ViewModel
               ↓
         NEW STATE
               ↓
              UI
```

### Remember these 4 points

| Concept                  | Meaning                                       |
| ------------------------ | --------------------------------------------- |
| **UI-facing state**      | Data the UI needs to render                   |
| **Business interaction** | ViewModel coordinates actions requested by UI |
| **State transformation** | Convert data/results into UI-friendly state   |
| **Event handling**       | Respond to user actions and update state      |

### One-line definition

> **A ViewModel/State Holder manages UI-facing state, handles UI events, coordinates application interactions, and transforms results into state that the UI can render.**

