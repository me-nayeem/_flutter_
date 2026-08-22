# 🟢 Phase 2 — Topic 17: Forms & Validation

> **A `Form` groups related input fields and gives you a structured way to validate, save, reset, and manage user input.**

You have already learned `TextField`, `TextEditingController`, `FocusNode`, `InputDecoration`, and input handling.

Now we move from **individual input fields → complete forms**.

According to the roadmap, **Forms** comes immediately after **Text fields** in Phase 2. 

---

# 📚 Table of Contents

1. [Why Do We Need Forms?](#-1-why-do-we-need-forms)
2. [`Form` vs `TextField`](#-2-form-vs-textfield)
3. [`TextFormField`](#-3-textformfield)
4. [Basic Form Structure](#-4-basic-form-structure)
5. [`GlobalKey<FormState>`](#-5-globalkeyformstate)
6. [Understanding `FormState`](#-6-understanding-formstate)
7. [Form Validation](#-7-form-validation)
8. [`validator`](#-8-validator)
9. [Returning Validation Errors](#-9-returning-validation-errors)
10. [Validating Multiple Fields](#-10-validating-multiple-fields)
11. [Submitting a Form](#-11-submitting-a-form)
12. [`FormState.validate()`](#-12-formstatevalidate)
13. [`FormState.save()`](#-13-formstatesave)
14. [`onSaved`](#-14-onsaved)
15. [`FormState.reset()`](#-15-formstatereset)
16. [`autovalidateMode`](#-16-autovalidatemode)
17. [Form Validation Flow](#-17-form-validation-flow)
18. [Controllers + Form Validation](#-18-controllers--form-validation)
19. [Cross-Field Validation](#-19-cross-field-validation)
20. [Real-World Registration Form](#-20-real-world-registration-form)
21. [Common Mistakes](#-21-common-mistakes)
22. [Professional Best Practices](#-22-professional-best-practices)
23. [Practice](#-23-practice)
24. [Knowledge Check](#-24-knowledge-check)
25. [Quick Reference](#-25-quick-reference)
26. [Key Takeaways](#-26-key-takeaways)

---

# 🧠 1. Why Do We Need Forms?

Imagine a registration screen:

```text
        Create Account

┌─────────────────────────────┐
│ Name                        │
└─────────────────────────────┘

┌─────────────────────────────┐
│ Email                       │
└─────────────────────────────┘

┌─────────────────────────────┐
│ Password                    │
└─────────────────────────────┘

┌─────────────────────────────┐
│ Confirm Password            │
└─────────────────────────────┘

          [ Sign Up ]
```

We need to answer questions like:

* Is the name empty?
* Is the email valid?
* Is the password long enough?
* Do both passwords match?
* Can we submit the form?
* How do we show errors?
* How do we save the values?
* How do we reset everything?

Doing all of this manually with separate `TextField`s can become messy.

That's where:

```dart
Form
```

and:

```dart
TextFormField
```

come in.

---

# 💡 2. `Form` vs `TextField`

This distinction is extremely important.

### `TextField`

Used for an individual text input.

```dart
TextField()
```

It does **not** provide Flutter's form validation system by itself.

---

### `TextFormField`

A `TextField` designed to work with:

```dart
Form
```

It provides features such as:

* validation
* saving
* resetting
* integration with `FormState`

---

### Mental Model

Think:

```text
TextField
    ↓
Individual input


Form
    ↓
Group of related inputs


TextFormField
    ↓
Input field designed to participate in a Form
```

---

# 📚 3. `TextFormField`

The basic syntax:

```dart
TextFormField()
```

It looks and behaves similarly to `TextField`, but adds form-specific functionality.

For example:

```dart
TextFormField(
  decoration: const InputDecoration(
    labelText: 'Email',
    border: OutlineInputBorder(),
  ),
)
```

The important addition is:

```dart
validator
```

Example:

```dart
TextFormField(
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    return null;
  },
)
```

This is the foundation of Flutter form validation.

---

# 🏗️ 4. Basic Form Structure

A typical form looks like this:

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

Conceptually:

```text
Form
 │
 ├── TextFormField
 │
 ├── TextFormField
 │
 └── Submit Button
```

The `Form` acts as the **container for form-related state and behavior**.

---

# 🧠 5. `GlobalKey<FormState>`

Now we reach one of the most important concepts.

To control a form programmatically, we commonly create:

```dart
final formKey = GlobalKey<FormState>();
```

Then attach it:

```dart
Form(
  key: formKey,
  child: ...
)
```

Now we can access the form's state:

```dart
formKey.currentState
```

---

# 🔍 Why `GlobalKey`?

Think of the widget tree:

```text
Widget Tree

Form
 │
 ├── TextFormField
 ├── TextFormField
 └── Button
```

The key gives your code a way to identify and access that particular `Form`.

Conceptually:

```text
formKey
   │
   ▼
 Form
   │
   ▼
FormState
```

This lets us perform operations such as:

```dart
formKey.currentState!.validate();
```

```dart
formKey.currentState!.save();
```

```dart
formKey.currentState!.reset();
```

These three methods are extremely important.

---

# 🧠 6. Understanding `FormState`

`FormState` represents the current state of a `Form`.

The three methods you'll use most are:

```dart
validate()
save()
reset()
```

Think:

```text
FormState
   │
   ├── validate()
   ├── save()
   └── reset()
```

---

# ✅ 7. Form Validation

Validation means:

> **Checking whether the user's input satisfies the rules required by your application.**

For example:

```text
Email
 ↓
Is it empty?
 ↓
Is the format reasonable?
 ↓
Valid / Invalid
```

Password:

```text
Password
 ↓
Is it empty?
 ↓
Is it long enough?
 ↓
Valid / Invalid
```

---

# 💻 8. `validator`

`validator` is a function that checks a field's value.

Example:

```dart
TextFormField(
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    return null;
  },
)
```

The callback receives:

```dart
value
```

which contains the current field value.

---

# 🧠 The Most Important Rule

A validator has two possible outcomes:

### ❌ Invalid

Return an error message:

```dart
return 'Email is required';
```

### ✅ Valid

Return:

```dart
return null;
```

So remember:

> **`null` means valid. A non-null string means invalid.**

This is one of the most important things to memorize.

---

# 💡 9. Returning Validation Errors

Suppose:

```dart
TextFormField(
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    return null;
  },
)
```

If the user submits an empty field:

```text
┌─────────────────────────────┐
│ Name                        │
└─────────────────────────────┘
  Please enter your name
```

Flutter can display the returned error message as part of the form field's validation UI.

---

# 🧪 Example: Email Validation

```dart
TextFormField(
  decoration: const InputDecoration(
    labelText: 'Email',
    border: OutlineInputBorder(),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    if (!value.contains('@')) {
      return 'Enter a valid email';
    }

    return null;
  },
)
```

The logic is:

```text
value
 │
 ├── null/empty?
 │      └── ERROR
 │
 ├── missing @?
 │      └── ERROR
 │
 └── otherwise
        ↓
       null
        ↓
       VALID
```

---

# 🧠 10. Validating Multiple Fields

A form can contain many fields.

Example:

```dart
Form(
  key: formKey,
  child: Column(
    children: [
      TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Name is required';
          }

          return null;
        },
      ),

      TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email is required';
          }

          return null;
        },
      ),

      TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          }

          return null;
        },
      ),
    ],
  ),
)
```

Now the `Form` manages all those validation fields together.

Conceptually:

```text
Form
 │
 ├── Name
 │    └── validator
 │
 ├── Email
 │    └── validator
 │
 └── Password
      └── validator
```

---

# 🚀 11. Submitting a Form

The submit button usually does something like:

```dart
ElevatedButton(
  onPressed: () {
    if (formKey.currentState!.validate()) {
      // Form is valid
    }
  },
  child: const Text('Submit'),
)
```

This is one of the most common Flutter form patterns.

---

# 🔍 12. `FormState.validate()`

This method:

```dart
formKey.currentState!.validate()
```

runs the validators of the form's fields.

It returns:

```dart
bool
```

So:

```dart
if (formKey.currentState!.validate()) {
  // Valid
}
```

means:

```text
Run all validators
      ↓
Are all fields valid?
      │
   ┌──┴──┐
   │     │
  YES    NO
   │     │
   ▼     ▼
Continue Show errors
```

---

# 🧠 Why `validate()` is so useful

Without a form system, you might have to manually check:

```dart
name
email
password
confirmPassword
```

individually.

With `Form`:

```dart
formKey.currentState!.validate()
```

the form coordinates validation for you.

---

# 💾 13. `FormState.save()`

Forms also support saving values.

A `TextFormField` can define:

```dart
onSaved
```

Example:

```dart
String? email;

TextFormField(
  onSaved: (value) {
    email = value;
  },
)
```

Then:

```dart
formKey.currentState!.save();
```

causes the `onSaved` callbacks to run.

---

# 💡 14. `onSaved`

Example:

```dart
String? name;

TextFormField(
  onSaved: (value) {
    name = value;
  },
)
```

Then:

```dart
if (formKey.currentState!.validate()) {
  formKey.currentState!.save();

  print(name);
}
```

The flow:

```text
User input
    ↓
TextFormField
    ↓
validate()
    ↓
Valid?
    ↓
save()
    ↓
onSaved()
    ↓
Application data
```

---

# ⚠️ Important: `validate()` and `save()` are different

Don't confuse them.

### `validate()`

Checks whether input is valid.

```dart
formKey.currentState!.validate();
```

### `save()`

Calls the fields' `onSaved` callbacks.

```dart
formKey.currentState!.save();
```

They serve different purposes.

---

# 🔄 15. `FormState.reset()`

You can reset the form:

```dart
formKey.currentState!.reset();
```

This resets the form fields to their initial state and clears validation state.

For example:

```dart
TextButton(
  onPressed: () {
    formKey.currentState!.reset();
  },
  child: const Text('Reset'),
)
```

Useful for:

* Reset buttons
* Clearing forms
* Cancel actions
* Reusing forms

---

# ⚡ 16. `autovalidateMode`

By default, validation is commonly triggered when you explicitly call:

```dart
validate()
```

But Flutter also provides:

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

# 🧠 Common `AutovalidateMode` Options

### `disabled`

```dart
AutovalidateMode.disabled
```

Don't automatically validate.

---

### `onUserInteraction`

```dart
AutovalidateMode.onUserInteraction
```

Validate after the user interacts with the field.

---

### `always`

```dart
AutovalidateMode.always
```

Always perform automatic validation.

---

# 💡 Which should you use?

For many normal forms:

```dart
autovalidateMode: AutovalidateMode.onUserInteraction,
```

can provide a good user experience.

But don't blindly validate everything immediately.

Professional UX considers **when the user should see an error**, not merely whether validation exists.

---

# 🔄 17. Form Validation Flow

A typical form lifecycle looks like:

```text
            User enters data
                    │
                    ▼
              TextFormField
                    │
                    ▼
              User submits
                    │
                    ▼
             validate()
                    │
          ┌─────────┴─────────┐
          │                   │
        INVALID             VALID
          │                   │
          ▼                   ▼
     Show errors            save()
                              │
                              ▼
                         onSaved()
                              │
                              ▼
                       Business logic
                              │
                              ▼
                     API / Database
```

This is the mental model you should remember.

---

# 🔥 18. Controllers + Form Validation

You can use:

```text
TextEditingController
+
TextFormField
+
Form
```

together.

Example:

```dart
final emailController = TextEditingController();

TextFormField(
  controller: emailController,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    return null;
  },
)
```

Then:

```dart
if (formKey.currentState!.validate()) {
  print(emailController.text);
}
```

This is perfectly reasonable.

---

# 🧠 When should you use `onSaved` vs Controller?

Both are valid approaches.

### Controller

Useful when you need ongoing programmatic access:

```dart
emailController.text
```

For example:

* reading values
* clearing fields
* setting values
* reacting to changes

### `onSaved`

Useful when you want the form itself to collect values during form submission.

```dart
onSaved: (value) {
  email = value;
}
```

For simple forms, either approach can work.

Don't use both unnecessarily.

---

# 🔍 19. Cross-Field Validation

Now let's solve a more realistic problem.

Suppose we have:

```text
Password
Confirm Password
```

We need:

```text
Password == Confirm Password
```

The second field needs access to the first field's value.

A controller makes this straightforward:

```dart
final passwordController = TextEditingController();
```

Password field:

```dart
TextFormField(
  controller: passwordController,
  obscureText: true,
)
```

Confirm password:

```dart
TextFormField(
  obscureText: true,
  validator: (value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  },
)
```

Now:

```text
Password
     │
     │ compare
     ▼
Confirm Password
     │
     ▼
Same?
 ┌───┴───┐
YES      NO
 │        │
 ▼        ▼
Valid    Error
```

This is called **cross-field validation** because one field's validation depends on another field.

---

# 🏗️ 20. Real-World Registration Form

Let's combine everything.

```dart
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  void register() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    // Form is valid.
    // Perform registration logic here.
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Name is required';
              }

              return null;
            },
          ),

          const SizedBox(height: 16),

          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
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
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
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

          const SizedBox(height: 16),

          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value != passwordController.text) {
                return 'Passwords do not match';
              }

              return null;
            },
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: register,
              child: const Text('Create Account'),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

# 🧠 Breaking Down the Architecture

Don't just memorize this code.

Understand its responsibilities.

```text
RegisterScreen
│
├── Form
│    │
│    ├── Name field
│    │    └── validation
│    │
│    ├── Email field
│    │    └── validation
│    │
│    ├── Password field
│    │    └── validation
│    │
│    └── Confirm password
│         └── cross-field validation
│
└── register()
      │
      ├── validate
      ├── read values
      └── perform registration
```

This separation is important.

The form is responsible for **collecting and validating input**.

Your registration method is responsible for deciding **what to do with valid input**.

---

# ⚠️ 21. Common Mistakes

## ❌ Mistake 1 — Forgetting the `Form` key

This:

```dart
Form(
  child: ...
)
```

is fine if you don't need programmatic form operations.

But if you want:

```dart
validate()
save()
reset()
```

you need a key:

```dart
final formKey = GlobalKey<FormState>();
```

and:

```dart
Form(
  key: formKey,
  child: ...
)
```

---

## ❌ Mistake 2 — Returning a message when the field is valid

Wrong:

```dart
validator: (value) {
  if (value!.isEmpty) {
    return 'Required';
  }

  return 'Valid'; // ❌
}
```

Correct:

```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Required';
  }

  return null;
}
```

Remember:

```text
null → valid
String → invalid
```

---

## ❌ Mistake 3 — Using `value!` carelessly

Avoid:

```dart
if (value!.isEmpty)
```

unless you're certain it can't be null.

Safer:

```dart
if (value == null || value.isEmpty)
```

---

## ❌ Mistake 4 — Calling `validate()` but ignoring the result

Bad:

```dart
formKey.currentState!.validate();

registerUser();
```

The registration would continue even if validation failed.

Better:

```dart
if (formKey.currentState!.validate()) {
  registerUser();
}
```

---

## ❌ Mistake 5 — Performing API calls inside validators

Don't do:

```dart
validator: (value) {
  // Call server
  // Query database
  // Make API request
}
```

Validators should normally be **fast and predictable**.

For example:

```text
Local validation
      ↓
Form valid
      ↓
Submit
      ↓
API request
      ↓
Server validation
```

Client-side validation is for user experience.

It does **not** replace server-side validation.

---

## ❌ Mistake 6 — Treating client validation as security

Suppose you validate:

```dart
password.length >= 8
```

on the client.

A malicious client can bypass your UI.

Therefore:

> **Important rules must also be enforced on the server.**

Flutter validation improves UX; it isn't a security boundary.

---

## ❌ Mistake 7 — Creating `GlobalKey` inside `build()`

Don't:

```dart
@override
Widget build(BuildContext context) {
  final formKey = GlobalKey<FormState>(); // ❌

  return Form(
    key: formKey,
    child: ...
  );
}
```

`build()` can execute many times.

Create the key as a state field:

```dart
final formKey = GlobalKey<FormState>();
```

---

# 🚀 22. Professional Best Practices

## 1. Keep validation readable

Instead of a giant validator:

```dart
validator: (value) {
  // 50 lines...
}
```

extract reusable validation logic when the application grows.

For example:

```dart
String? validateEmail(String? value) {
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
  validator: validateEmail,
)
```

Much cleaner.

---

## 2. Trim user input where appropriate

For fields such as:

```text
Name
Email
Username
```

you'll often want:

```dart
value.trim()
```

For example:

```dart
final email = emailController.text.trim();
```

Don't blindly trim every kind of input—spaces may be meaningful in some fields.

---

## 3. Keep UI validation separate from business logic

Prefer:

```text
UI
 ↓
validate input
 ↓
submit
 ↓
business logic
 ↓
repository/service
```

rather than putting everything inside the widget.

This becomes especially important when you reach architecture and state management.

---

## 4. Don't over-validate

Validation should help users.

For example, an overly complicated email validator can reject legitimate addresses.

A professional developer asks:

> **What is the minimum validation necessary to provide a good user experience and satisfy the application's requirements?**

---

## 5. Provide useful error messages

Bad:

```text
Invalid input
```

Better:

```text
Email is required
```

Even better:

```text
Enter a valid email address
```

The user should understand **what went wrong and how to fix it**.

---

# 🔍 Client Validation vs Server Validation

This is an important real-world concept.

Suppose the user enters:

```text
nayeem@example.com
```

Flutter might check:

```text
Is it empty?
Does it look like an email?
```

Then:

```text
Flutter
   ↓
Valid format
   ↓
API request
   ↓
Server
   ↓
Does this account already exist?
```

The server may reject it because the email is already registered.

Therefore:

```text
Client validation
      +
Server validation
```

are complementary.

Never assume:

> "The Flutter validator says it's valid, therefore the data is definitely valid."

---

# 🧪 23. Practice

## 🟢 Beginner — Login Form

Create:

```text
Email
Password
Login
```

Requirements:

* `Form`
* `GlobalKey<FormState>`
* `TextFormField`
* Email validation
* Password validation
* `validate()`

---

## 🟢 Beginner — Required Fields

Create a form containing:

```text
Name
Email
Phone
```

Each field must show an error when empty.

---

## 🟡 Intermediate — Registration Form

Create:

```text
Name
Email
Phone
Password
Confirm Password
```

Requirements:

* proper keyboard types
* password obscuring
* validation
* password confirmation
* submit button
* reset button

---

## 🟡 Intermediate — `onSaved`

Create a form using:

```dart
onSaved
```

instead of reading every value directly from controllers.

After:

```dart
formKey.currentState!.save();
```

print the collected values.

---

# 🔴 Challenge — Production-Style Login Form

Build a login screen with:

```text
             Login

┌─────────────────────────────┐
│ ✉  Email                    │
└─────────────────────────────┘

┌─────────────────────────────┐
│ 🔒 Password             👁 │
└─────────────────────────────┘

        [ Login ]

       Forgot Password?
```

Requirements:

### Email

* Required
* Email keyboard
* Email icon
* Meaningful error messages

### Password

* Required
* Minimum 8 characters
* Obscure text
* Visibility toggle

### Form

* `GlobalKey<FormState>`
* `validate()`
* Controllers
* Proper disposal

### Submit

Only continue when:

```dart
formKey.currentState!.validate()
```

returns `true`.

---

# 🧠 24. Knowledge Check

Before moving forward, make sure you can answer these without looking at the lesson.

1. Why do we use `Form`?
2. What is the difference between `TextField` and `TextFormField`?
3. What is `FormState`?
4. Why do we use `GlobalKey<FormState>`?
5. What does `validate()` do?
6. What does `save()` do?
7. What does `reset()` do?
8. What is a `validator`?
9. What does `return null` mean inside a validator?
10. What does returning a `String` mean?
11. What is `onSaved`?
12. What is `autovalidateMode`?
13. Why shouldn't validators perform API requests?
14. Why is client-side validation not enough for security?
15. How would you validate that two passwords match?
16. Why shouldn't a `GlobalKey` be created inside `build()`?
17. When would you use a controller with `TextFormField`?
18. What is the difference between validation and submission?
19. What happens when `validate()` returns `false`?
20. Why should error messages be useful to the user?

---

# 📌 25. Quick Reference

## Basic Form

```dart
final formKey = GlobalKey<FormState>();

Form(
  key: formKey,
  child: Column(
    children: [
      TextFormField(),
    ],
  ),
)
```

---

## Validation

```dart
TextFormField(
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }

    return null;
  },
)
```

---

## Submit

```dart
if (formKey.currentState!.validate()) {
  // Form is valid
}
```

---

## Save

```dart
formKey.currentState!.save();
```

With:

```dart
TextFormField(
  onSaved: (value) {
    // Save value
  },
)
```

---

## Reset

```dart
formKey.currentState!.reset();
```

---

## Automatic Validation

```dart
TextFormField(
  autovalidateMode: AutovalidateMode.onUserInteraction,
)
```

---

## Controller + Form

```dart
final emailController = TextEditingController();

TextFormField(
  controller: emailController,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    return null;
  },
)
```

---

# 🎯 26. Key Takeaways

### `Form`

> Groups related form fields and manages form-level state.

### `TextFormField`

> A form-aware text input widget that supports validation and saving.

### `GlobalKey<FormState>`

> Provides access to the state of a particular `Form`.

### `validator`

> Checks whether a field's current value is valid.

### `return null`

> Means the field is valid.

### Return an error `String`

> Means the field is invalid.

### `validate()`

> Runs the form's validators and returns whether the form is valid.

### `save()`

> Runs the fields' `onSaved` callbacks.

### `reset()`

> Resets the form fields and validation state.

### `autovalidateMode`

> Controls when fields automatically perform validation.

---

# 🧠 Final Mental Model

Don't think of a form as simply:

```text
Form = several text fields
```

Think of it as a **small input-management system**:

```text
                         FORM
                          │
        ┌─────────────────┼─────────────────┐
        │                 │                 │
        ▼                 ▼                 ▼
   TextFormField     TextFormField     TextFormField
        │                 │                 │
        ▼                 ▼                 ▼
    Validator         Validator         Validator
        │                 │                 │
        └─────────────────┼─────────────────┘
                          │
                          ▼
                       validate()
                          │
                    ┌─────┴─────┐
                    │           │
                  Invalid      Valid
                    │           │
                    ▼           ▼
               Show errors    save()
                                │
                                ▼
                           onSaved()
                                │
                                ▼
                        Business logic
                                │
                                ▼
                          API / Database
```

The professional mental model is:

> **A form is the boundary between raw user input and your application's business logic.**

Your UI collects the data → validation checks basic requirements → valid data moves into your application logic → the backend performs its own authoritative validation.

This foundation will become extremely important when we later build **real applications, API calls, state management, and architecture**. 
