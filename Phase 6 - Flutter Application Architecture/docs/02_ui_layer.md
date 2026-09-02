# Phase 6 — Architecture

## 2. UI Layer

> **Core idea:** The UI layer is responsible for **showing application state to the user and receiving user interactions**. It should not contain data-access or complex business logic. ([Flutter Docs][1])

---

## 📚 1. What Is the UI Layer?

The **UI layer** is the part of your application that the user directly interacts with.

It has two main responsibilities:

1. **Display data**
2. **Receive user actions**

For example, in a Notes app:

```text
┌──────────────────────────────┐
│          Notes               │
├──────────────────────────────┤
│ • Learn Flutter              │
│ • Practice DSA               │
│ • Build project              │
│                              │
│          [+ Add Note]        │
└──────────────────────────────┘
```

The UI layer is responsible for displaying those notes and detecting when the user taps **Add Note**.

Flutter's recommended architecture divides the UI layer into two main components:

```text
UI Layer
│
├── View
│
└── ViewModel
```

This follows the **MVVM** pattern. ([Flutter Docs][1])

---

# 🧠 2. View vs ViewModel

The easiest way to understand the difference:

> **View = What the user sees**
>
> **ViewModel = What the UI needs to know and do**

For example:

```text
                UI Layer
                   │
        ┌──────────┴──────────┐
        │                     │
      View                ViewModel
        │                     │
   Displays UI          Manages UI state
   Receives events      Handles UI logic
   Calls commands       Talks to repositories
```

### View

Usually composed of Flutter widgets:

```dart
class NotesScreen extends StatelessWidget {
  const NotesScreen({
    super.key,
    required this.viewModel,
  });

  final NotesViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Text('${viewModel.notes.length} notes'),
    );
  }
}
```

The View should primarily **render the state** and forward user events.

### ViewModel

The ViewModel contains the UI-related logic:

```dart
class NotesViewModel {
  NotesViewModel(this.repository);

  final NotesRepository repository;

  List<Note> notes = [];

  Future<void> loadNotes() async {
    notes = await repository.getNotes();
  }

  Future<void> addNote(String text) async {
    await repository.addNote(text);
    await loadNotes();
  }
}
```

The View doesn't need to know **how** notes are loaded or stored.

---

# 🎯 3. Why Do We Separate Them?

Imagine putting everything inside a widget:

```dart
class NotesScreen extends StatelessWidget {
  // UI
  // API calls
  // database logic
  // filtering
  // authentication
  // error handling
  // business logic
}
```

It might work for a small experiment.

But as the application grows, this becomes difficult to:

* understand
* modify
* debug
* reuse
* test

Flutter's architecture guidance therefore recommends keeping widgets **lean** and putting application logic into appropriate classes such as ViewModels. ([Flutter Docs][2])

The important principle is:

```text
❌ View
   ├── UI
   ├── API
   ├── Database
   ├── Business logic
   └── Everything else

✅ View
   │
   │ displays state
   ▼
ViewModel
   │
   │ requests data / performs UI logic
   ▼
Repository
```

---

# 🧠 4. What Should a View Actually Do?

A View can contain simple UI-related logic.

Flutter's guidance gives examples such as:

* showing/hiding widgets based on state
* animation logic
* layout decisions based on screen size/orientation
* simple routing logic ([Flutter Docs][1])

For example:

```dart
if (viewModel.isLoading) {
  return const CircularProgressIndicator();
}

return NotesList(notes: viewModel.notes);
```

That's fine.

But this is **not** something the View should normally do:

```dart
final response = await http.get(...);
```

Because now the View knows about the networking implementation.

---

# 🔄 5. How Does Data Reach the UI?

Suppose the user opens a Notes screen.

The flow is roughly:

```text
Repository
     │
     │ application data
     ▼
ViewModel
     │
     │ UI-friendly state
     ▼
View
     │
     ▼
User
```

The ViewModel may need to transform the data.

For example, the repository might provide:

```text
Note objects
```

while the UI needs:

```text
filtered notes
sorted notes
loading state
error state
selected note
```

The ViewModel prepares the state that the View actually needs.

Flutter describes this as the ViewModel **converting application data into UI state**. ([Flutter Docs][1])

---

# 🔄 6. What Happens When the User Interacts?

The direction reverses for user actions:

```text
User
  │
  │ taps "Add"
  ▼
View
  │
  │ calls ViewModel command
  ▼
ViewModel
  │
  │ requests data change
  ▼
Repository
  │
  ▼
Data changes
  │
  ▼
ViewModel receives new state
  │
  ▼
View rebuilds
```

So remember:

```text
DATA:
Repository → ViewModel → View

EVENT:
View → ViewModel → Repository
```

This becomes extremely important when we study **Unidirectional Data Flow** later.

---

# 🔍 7. View and ViewModel Relationship

Flutter's architecture guidance recommends a **one-to-one relationship between a View and its ViewModel**. ([Flutter Docs][1])

For example:

```text
HomeScreen       → HomeViewModel
NotesScreen      → NotesViewModel
ProfileScreen    → ProfileViewModel
SettingsScreen   → SettingsViewModel
```

But don't misunderstand this as:

```text
One Widget → One ViewModel
```

A **View is usually a collection of widgets**, not a single widget.

```text
NotesScreen
│
├── AppBar
├── SearchBar
├── ListView
│   ├── NoteCard
│   ├── NoteCard
│   └── NoteCard
└── FloatingActionButton

        ↓

   NotesViewModel
```

The entire screen/feature can be considered the View.

---

# 💡 8. The Most Important Mental Model

Don't think:

> "ViewModel is just a place where I put code so my widget isn't too large."

Think:

> **The ViewModel represents what the UI currently needs to know and provides the actions the UI can perform.**

For example:

```dart
class LoginViewModel {
  bool isLoading = false;
  String? errorMessage;

  Future<void> login(String email, String password) async {
    // login-related UI logic
  }
}
```

The View can simply react:

```text
isLoading == true
      ↓
Show loading indicator

errorMessage != null
      ↓
Show error

login successful
      ↓
Navigate to home
```

The View doesn't need to understand the implementation details.

---

# 🏗️ 9. A Simple Architecture

For the architecture we're learning:

```text
                 UI LAYER
┌─────────────────────────────────────┐
│                                     │
│   View  ←────────→  ViewModel       │
│    │                    │            │
│    │ displays state     │            │
│    │                    │            │
│    └── user events ────►            │
│                         │            │
└─────────────────────────┼────────────┘
                          │
                          ▼
                     DATA LAYER
```

Later we'll add:

* Repositories
* Services
* Dependency Injection
* Optional Domain Layer

So don't try to memorize the entire architecture yet.

First understand this:

> **View displays. ViewModel manages UI state and UI logic.**

---

# ⚠️ 10. A Common Misunderstanding

**ViewModel is not the same thing as a Repository.**

They have different responsibilities.

| Component      | Main responsibility                    |
| -------------- | -------------------------------------- |
| **View**       | Display UI and receive user input      |
| **ViewModel**  | Manage UI state and UI-related logic   |
| **Repository** | Manage application data                |
| **Service**    | Communicate with external data sources |

For example:

```text
"Show a loading spinner"
        → ViewModel

"Sort notes alphabetically for this screen"
        → ViewModel

"Get notes from database/API"
        → Repository

"Make HTTP request"
        → Service
```

We'll study these boundaries in detail in the next topics.

---

# 🎯 Core Mental Model

Keep this model in your head:

```text
                 UI LAYER

      ┌─────────────────────────┐
      │          VIEW           │
      │                         │
      │  Displays UI state      │
      │  Receives user events   │
      └────────────┬────────────┘
                   │
                   ▼
      ┌─────────────────────────┐
      │       VIEWMODEL         │
      │                         │
      │  Holds UI state         │
      │  Handles UI logic       │
      │  Transforms data        │
      │  Exposes actions        │
      └────────────┬────────────┘
                   │
                   ▼
              DATA LAYER
```

The most important rule:

> **Keep the View focused on presentation. Keep UI logic in the ViewModel. Keep data access in the data layer.**

This separation is one of the main foundations of maintainable Flutter architecture.