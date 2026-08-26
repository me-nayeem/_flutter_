# 🟢 Phase 3 — Building Complete Apps

# 6. Form Validation

> **Goal:** Learn how to build reliable Flutter forms, validate user input, display useful validation messages, and handle form submission professionally.

Forms are everywhere in real applications:

```text
Login
Registration
Search
Profile editing
Checkout
Address
Feedback
Password change
```

A professional Flutter developer should understand not only how to create a form, but also **how to validate the data before using or submitting it**.

---

# 🧠 1. What Is Form Validation?

Form validation means checking whether the data entered by the user is acceptable.

For example:

```text
Email:
[ abc@gmail.com       ] ✅

Password:
[ 123                 ] ❌
Password must be at least 8 characters.
```

Another example:

```text
Name:
[                     ] ❌
Name is required.
```

The general flow is:

```text
User enters data
       ↓
User submits form
       ↓
Validate input
       ↓
 ┌─────┴─────┐
 │           │
Valid       Invalid
 │           │
 ▼           ▼
Submit     Show errors
```

---

# 2. Flutter's Form System

Flutter provides several important widgets and concepts for forms:

```text
Form
TextFormField
GlobalKey<FormState>
validator
onSaved
autovalidateMode
```

The most important relationship is:

```text
Form
 │
 ├── TextFormField
 ├── TextFormField
 └── TextFormField
        │
        ▼
   validator()
```

---

# 3. `TextField` vs `TextFormField`

You have already seen `TextField`.

For example:

```dart
TextField(
  decoration: const InputDecoration(
    labelText: 'Email',
  ),
)
```

`TextField` is useful for general text input.

But when you're building a form that needs validation, `TextFormField` is usually the better choice:

```dart
TextFormField(
  decoration: const InputDecoration(
    labelText: 'Email',
  ),
  validator: (value) {
    // validation logic
  },
)
```

The key difference is that:

```text
TextField
   ↓
Text input

TextFormField
   ↓
Text input + Form integration + validation
```

---

# 4. The `Form` Widget

A professional form normally starts with:

```dart
Form(
  child: Column(
    children: [
      // form fields
    ],
  ),
)
```

For example:

```dart
Form(
  child: Column(
    children: [
      TextFormField(),
      TextFormField(),
      ElevatedButton(
        onPressed: () {},
        child: const Text('Submit'),
      ),
    ],
  ),
)
```

But we need a way to control and validate the form.

That's where:

```dart
GlobalKey<FormState>
```

comes in.

---

# 5. `GlobalKey<FormState>`

Create a key:

```dart
final _formKey = GlobalKey<FormState>();
```

Then attach it to the `Form`:

```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      // fields
    ],
  ),
)
```

Now we can access the form's state through:

```dart
_formKey.currentState
```

For example:

```dart
_formKey.currentState!.validate();
```

This is one of the most important patterns to remember.

---

# 6. Basic Form Example

Let's build a simple login form.

```dart
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid.
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

# 7. Understanding `validator`

The most important part is:

```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }

  return null;
},
```

The validator must return:

```text
String → validation failed
null   → validation passed
```

So:

```dart
return 'Email is required';
```

means:

> ❌ This field is invalid.

While:

```dart
return null;
```

means:

> ✅ This field is valid.

---

# 🧠 8. The Validator Contract

Remember this simple rule:

```text
validator()
     │
     ├── return String → ❌ Invalid
     │
     └── return null   → ✅ Valid
```

This is fundamental.

---

# 9. Why Check `value == null`?

You will frequently see:

```dart
if (value == null || value.isEmpty)
```

Why both?

Because the value passed to the validator can be nullable:

```dart
String?
```

If:

```dart
value == null
```

then calling:

```dart
value.isEmpty
```

would be unsafe.

The `||` operator short-circuits, so if `value == null` is true, Dart doesn't evaluate:

```dart
value.isEmpty
```

Therefore this is a safe pattern:

```dart
if (value == null || value.isEmpty) {
  return 'This field is required';
}
```

---

# 10. Calling `validate()`

The actual validation happens when we call:

```dart
_formKey.currentState!.validate()
```

For example:

```dart
onPressed: () {
  if (_formKey.currentState!.validate()) {
    // Valid
  }
}
```

The result is:

```text
validate()
   │
   ├── true  → all fields valid
   │
   └── false → at least one field invalid
```

---

# 11. What Happens Internally?

Suppose we have:

```text
Email
Password
Username
```

When:

```dart
_formKey.currentState!.validate()
```

runs, Flutter asks the form fields to validate.

Conceptually:

```text
Form.validate()
       │
       ├── Email validator
       │
       ├── Password validator
       │
       └── Username validator
              │
              ▼
        Overall result
```

If any field is invalid:

```text
false
```

Otherwise:

```text
true
```

---

# 12. Required Field Validation

The simplest validation:

```dart
validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required';
  }

  return null;
},
```

Notice:

```dart
value.trim()
```

This is often better than just:

```dart
value.isEmpty
```

because:

```text
"     "
```

is technically not empty.

But after trimming:

```text
"     ".trim()
     ↓
""
```

So whitespace-only input can be rejected.

---

# 13. Email Validation

A simple validation:

```dart
validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email is required';
  }

  if (!value.contains('@')) {
    return 'Enter a valid email';
  }

  return null;
},
```

This is okay for learning.

However, remember:

> A real-world email validation rule can be more complicated than simply checking for `@`.

For production applications, follow the requirements of your backend and product instead of assuming one simple pattern is universally correct.

---

# 14. Password Validation

Example:

```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }

  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }

  return null;
},
```

Flow:

```text
Password
   │
   ├── Empty → ❌
   │
   ├── < 8 characters → ❌
   │
   └── 8+ characters → ✅
```

---

# 15. Confirm Password

This is a very common real-world requirement.

Suppose:

```text
Password:
[ ******** ]

Confirm Password:
[ ******** ]
```

They must match.

Example:

```dart
final passwordController = TextEditingController();
```

Password field:

```dart
TextFormField(
  controller: passwordController,
  obscureText: true,
  decoration: const InputDecoration(
    labelText: 'Password',
  ),
),
```

Confirm password:

```dart
TextFormField(
  obscureText: true,
  decoration: const InputDecoration(
    labelText: 'Confirm Password',
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  },
),
```

Now the validator depends on another field.

This is called **cross-field validation**.

---

# 16. Using `TextEditingController`

You can connect a controller to a field:

```dart
final emailController = TextEditingController();
```

Then:

```dart
TextFormField(
  controller: emailController,
)
```

Now you can access the entered value:

```dart
emailController.text
```

For example:

```dart
final email = emailController.text;
```

---

# 17. Why Use a Controller?

A controller is useful when you need to:

* Read input
* Modify input
* Clear input
* Set an initial value
* Listen for changes

For example:

```dart
emailController.clear();
```

or:

```dart
emailController.text = 'example@gmail.com';
```

---

# ⚠️ 18. Dispose Controllers

If you create a `TextEditingController` inside a `StatefulWidget`, dispose of it when the State is removed.

```dart
@override
void dispose() {
  emailController.dispose();
  super.dispose();
}
```

For multiple controllers:

```dart
@override
void dispose() {
  emailController.dispose();
  passwordController.dispose();

  super.dispose();
}
```

This is an important professional habit.

---

# 19. `autovalidateMode`

By default, validation is generally triggered when you explicitly validate the form.

But Flutter provides:

```dart
autovalidateMode
```

For example:

```dart
TextFormField(
  autovalidateMode: AutovalidateMode.onUserInteraction,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }

    return null;
  },
)
```

Now validation can happen while the user interacts with the field.

---

# 20. Available `AutovalidateMode` Values

The important modes are:

```dart
AutovalidateMode.disabled
```

```dart
AutovalidateMode.always
```

```dart
AutovalidateMode.onUserInteraction
```

### `disabled`

Don't automatically validate.

```dart
AutovalidateMode.disabled
```

### `always`

Always run validation.

```dart
AutovalidateMode.always
```

### `onUserInteraction`

Validate after the user interacts with the field.

```dart
AutovalidateMode.onUserInteraction
```

For many interactive forms, this is a useful option.

---

# 21. Form Submission

A clean submission pattern is:

```dart
void submitForm() {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  // Form is valid.
}
```

Then:

```dart
ElevatedButton(
  onPressed: submitForm,
  child: const Text('Submit'),
)
```

This is cleaner than putting a large amount of validation logic directly inside the button callback.

---

# 22. A More Professional Login Example

```dart
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    debugPrint('Email: $email');
    debugPrint('Password: $password');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }

                  if (!value.contains('@')) {
                    return 'Enter a valid email';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }

                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

# 🧠 23. Understand the Architecture of This Form

Don't just memorize the code.

Understand the responsibilities:

```text
LoginPage
│
├── _formKey
│     └── Controls the Form
│
├── _emailController
│     └── Controls email input
│
├── _passwordController
│     └── Controls password input
│
├── validators
│     └── Check individual fields
│
└── _submitForm()
      ├── validate
      ├── read values
      └── perform action
```

This is much more useful than memorizing syntax.

---

# 24. `FormState`

When you write:

```dart
_formKey.currentState
```

you are accessing the state of the `Form`.

Some useful methods include:

```dart
validate()
```

and:

```dart
reset()
```

You can also interact with the form state through the key.

---

# 25. Resetting a Form

Suppose the user wants to clear everything.

You can call:

```dart
_formKey.currentState!.reset();
```

This resets the form fields to their initial state.

If you're also using controllers, you may need to manage the controller values appropriately depending on your form design.

For example:

```dart
_formKey.currentState!.reset();

_emailController.clear();
_passwordController.clear();
```

---

# 26. Form Validation ≠ Backend Validation

This is a **very important professional concept**.

Suppose your Flutter app validates:

```text
Email format ✅
Password length ✅
```

That does **not** mean the server should trust the data.

Your backend should validate it too.

Think:

```text
Flutter validation
       ↓
Good user experience
       ↓
Backend validation
       ↓
Actual security / data integrity
```

Client-side validation is primarily about:

* Better UX
* Immediate feedback
* Preventing obvious invalid input

It should not be treated as the application's only security boundary.

---

# 27. Validation vs Sanitization

These are related but different concepts.

### Validation

Asks:

> "Is this data acceptable?"

Example:

```text
Is this email valid?
```

### Sanitization / normalization

Asks:

> "Can we clean or normalize this input into the expected form?"

For example:

```dart
final email = emailController.text.trim();
```

This removes unnecessary whitespace.

Don't confuse the two.

---

# 28. Validation Order

A good validator usually checks from simple to specific.

For example:

```dart
validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email is required';
  }

  if (!value.contains('@')) {
    return 'Enter a valid email';
  }

  return null;
},
```

Why this order?

Because if the field is empty, there's no reason to perform more complicated validation.

Think:

```text
Empty?
  ↓
Yes → stop
  ↓ No
Format valid?
  ↓
Yes → valid
```

---

# 29. Reusable Validators

As your application grows, you may notice repeated validation logic.

Instead of:

```dart
validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'Required';
  }

  return null;
}
```

everywhere, you can create reusable functions.

For example:

```dart
String? requiredValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required';
  }

  return null;
}
```

Then:

```dart
TextFormField(
  validator: requiredValidator,
)
```

This becomes increasingly useful in larger applications.

---

# 30. Combining Validators

You can create specialized validators.

```dart
String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email is required';
  }

  if (!value.contains('@')) {
    return 'Enter a valid email';
  }

  return null;
}
```

Then:

```dart
TextFormField(
  validator: emailValidator,
)
```

This keeps the UI code cleaner.

---

# 31. Common Beginner Mistakes

## ❌ Mistake 1 — Using `TextField` when form validation is needed

If you're building a structured form:

```dart
TextFormField
```

is generally the appropriate choice.

---

## ❌ Mistake 2 — Forgetting the `Form` key

You need:

```dart
final _formKey = GlobalKey<FormState>();
```

and:

```dart
Form(
  key: _formKey,
)
```

if you want to validate the form through the key.

---

## ❌ Mistake 3 — Forgetting `return null`

Incorrect:

```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Required';
  }
}
```

A valid case should explicitly return:

```dart
return null;
```

---

## ❌ Mistake 4 — Trusting client-side validation

Never assume:

```text
Flutter says valid
      ↓
Server must accept
```

The backend must validate independently.

---

## ❌ Mistake 5 — Not disposing controllers

If you create controllers in a `State`:

```dart
final _emailController = TextEditingController();
```

remember:

```dart
@override
void dispose() {
  _emailController.dispose();
  super.dispose();
}
```

---

# 32. Professional Form Flow

A good mental model:

```text
              USER INPUT
                  │
                  ▼
           TextFormField
                  │
                  ▼
             Validator
                  │
          ┌───────┴───────┐
          │               │
       Invalid           Valid
          │               │
          ▼               ▼
      Show error       Submit data
                          │
                          ▼
                       Backend
                          │
                          ▼
                    Server validation
```

---

# 🧪 Practice Project

Build a **Registration Form**.

Create the following fields:

```text
┌──────────────────────────────┐
│       Create Account         │
│                              │
│ Name                         │
│ [________________________]   │
│                              │
│ Email                        │
│ [________________________]   │
│                              │
│ Password                     │
│ [________________________]   │
│                              │
│ Confirm Password             │
│ [________________________]   │
│                              │
│ ☑ Accept Terms               │
│                              │
│ [      Create Account      ] │
└──────────────────────────────┘
```

### Requirements

Implement validation for:

* Name cannot be empty
* Email cannot be empty
* Email should have a reasonable format
* Password must meet your chosen minimum length
* Confirm password must match password
* Terms must be accepted

Use:

```dart
Form
GlobalKey<FormState>
TextFormField
TextEditingController
validator
setState
```

---

# ⭐ Challenge

After validation succeeds, don't immediately navigate.

Instead, display something like:

```text
Registration successful!
```

Then add:

```text
Loading
   ↓
Registration
   ↓
Success / Error
```

For example:

```dart
bool isLoading = false;
```

When submitting:

```dart
setState(() {
  isLoading = true;
});
```

After your simulated operation:

```dart
setState(() {
  isLoading = false;
});
```

This combines the **previous topic (`setState`)** with today's topic (**form validation**).

---

# 🎯 What You Should Know After This Lesson

You should be able to explain:

* What form validation is
* `Form`
* `TextFormField`
* `GlobalKey<FormState>`
* `validator`
* `FormState.validate()`
* `FormState.reset()`
* `TextEditingController`
* Why controllers should be disposed
* `autovalidateMode`
* Cross-field validation
* Client-side vs backend validation
* Reusable validators
* How to structure form submission
* How form validation works with `setState()`

---

# 🏁 Key Takeaway

The core pattern to remember is:

```dart
final _formKey = GlobalKey<FormState>();
```

```dart
Form(
  key: _formKey,
  child: TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Required';
      }

      return null;
    },
  ),
)
```

Then:

```dart
if (_formKey.currentState!.validate()) {
  // Form is valid.
}
```

The most important mental model is:

```text
Form
 │
 ├── Input
 │
 ├── Validation
 │
 └── Submission
```

> **A professional form doesn't simply collect input—it validates, communicates errors clearly, handles submission states, and never relies on client-side validation as a security boundary.**

---

## ⏭️ Next Topic

### **7. Assets and Themes**

We'll learn how to properly manage:

* Images
* Fonts
* Icons/assets
* `pubspec.yaml`
* `ThemeData`
* `ColorScheme`
* Text themes
* Light and dark themes
* Global styling
* Theme consistency
* `Theme.of(context)`
* `ColorScheme.of(context)`
* Building a reusable app-wide design system
