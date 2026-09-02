# Phase 6 — Architecture

## 5. Domain Layer

Now we move to the **Domain Layer**.

This topic is important because a common mistake in Flutter architecture is thinking:

> "Every app must have a Domain Layer."

**No.**

A domain layer is useful when your application contains enough **business rules and complexity** to justify it.

Your roadmap explicitly emphasizes this: **don't add a domain layer simply because a tutorial says every app needs one.** 

---

# 1. What is the Domain Layer?

The **Domain Layer** contains the application's **core business concepts and rules**.

It answers questions like:

* What does the application actually do?
* What rules must always be followed?
* What operations does the application support?
* What business logic should be independent of Flutter, HTTP, or databases?

Think:

```text
UI
 ↓
ViewModel
 ↓
Domain
 ↓
Data
```

The domain sits in the middle and represents the **actual business logic** of your application.

---

# 2. A Real-World Example

Imagine you're building an e-commerce application.

The user wants to place an order.

There may be rules like:

```text
- User must be logged in
- Product must be available
- Quantity must be greater than 0
- Discount cannot exceed 50%
- Order total must be calculated correctly
```

These are **business rules**.

They aren't really UI logic.

They aren't database logic either.

They belong to the application's domain.

---

# 3. Domain Models

A **Domain Model** represents an important concept in your business/application.

For an e-commerce application:

```text
User
Product
Cart
Order
Payment
```

could all be domain concepts.

For example:

```dart
class Product {
  final String id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });
}
```

This represents the concept of a `Product`.

The important thing is that the model represents the **business concept**, not how the data happens to be stored.

---

# 4. Domain Model vs API Model

This distinction becomes important in larger applications.

Suppose your API returns:

```json
{
  "product_id": "101",
  "product_name": "Laptop",
  "product_price": 800
}
```

You might create an API/data model:

```dart
class ProductDto {
  final String productId;
  final String productName;
  final double productPrice;

  ProductDto({
    required this.productId,
    required this.productName,
    required this.productPrice,
  });
}
```

But your application might use:

```dart
class Product {
  final String id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });
}
```

The API model represents:

> **How the server sends the data.**

The domain model represents:

> **What a Product means to our application.**

You don't always need both. For a simple application, one model may be enough.

---

# 5. Use Cases

This is one of the most important concepts in the Domain Layer.

A **Use Case** represents a specific action the application can perform.

Examples:

```text
LoginUser
GetProducts
PlaceOrder
CalculateCartTotal
UpdateProfile
DeleteAccount
SendMessage
```

Think of a use case as:

> **One meaningful operation of the application.**

---

# 6. Example: Place Order

Instead of putting order logic directly into the ViewModel:

```dart
class OrderViewModel {
  void placeOrder() {
    // 50 lines of business logic...
  }
}
```

we could create:

```dart
class PlaceOrder {
  Future<void> execute(Order order) async {
    // Business rules
  }
}
```

Then the ViewModel simply calls:

```dart
await placeOrder.execute(order);
```

The flow becomes:

```text
UI
 ↓
ViewModel
 ↓
PlaceOrder Use Case
 ↓
Repository
 ↓
Data Source
```

---

# 7. Why Use Cases?

Suppose your order process becomes complicated:

```text
Place Order
 ├── Validate cart
 ├── Check stock
 ├── Calculate price
 ├── Apply discount
 ├── Calculate tax
 ├── Process payment
 └── Create order
```

Putting all of that inside a ViewModel makes the ViewModel difficult to understand and test.

Instead:

```text
OrderViewModel
       ↓
 PlaceOrder
       ↓
OrderRepository
       ↓
Data sources
```

The ViewModel coordinates the UI.

The Use Case contains the application operation.

The Repository handles data access.

---

# 8. Business Rules

Business rules are the rules that determine **how your application should behave**.

For example:

### Banking app

```text
Cannot withdraw more money than balance.
```

### E-commerce

```text
Discount cannot exceed allowed limit.
```

### Food delivery

```text
Order cannot be placed if restaurant is closed.
```

### Learning app

```text
Student cannot unlock lesson 5 before completing lesson 4.
```

These rules are independent of Flutter widgets.

That's why they can belong in the domain layer.

---

# 9. Example of a Business Rule

Suppose an e-commerce application allows a maximum discount of 50%.

```dart
class CalculateDiscount {
  double execute(double price, double discountPercent) {
    if (discountPercent > 50) {
      discountPercent = 50;
    }

    return price * discountPercent / 100;
  }
}
```

Now:

```dart
final calculateDiscount = CalculateDiscount();

final discount = calculateDiscount.execute(
  1000,
  60,
);
```

Even though the user requested 60%:

```text
60% ❌
50% ✅ maximum allowed
```

The business rule is centralized.

---

# 10. Domain Layer Should Not Depend on Flutter

A good domain layer should ideally not care about:

```text
Widget
BuildContext
Text
Scaffold
HTTP
JSON
SQLite
```

For example, this is not ideal domain logic:

```dart
class CalculatePrice {
  Widget execute() {
    return Text("...");
  }
}
```

The domain shouldn't create UI.

Instead:

```dart
class CalculatePrice {
  double execute(double price, double tax) {
    return price + tax;
  }
}
```

Then the UI decides how to display the result.

---

# 11. Domain Layer and Repository

This relationship is extremely important.

Suppose we have:

```dart
class PlaceOrder {
  final OrderRepository repository;

  PlaceOrder(this.repository);

  Future<void> execute(Order order) {
    return repository.placeOrder(order);
  }
}
```

The use case knows:

> "I need an order repository."

It doesn't need to know whether the repository uses:

```text
REST API
Firebase
SQLite
Cache
```

That is the Data Layer's responsibility.

So:

```text
Domain
   ↓
Repository abstraction
   ↓
Data Layer implementation
```

This is where **Dependency Inversion** becomes useful.

---

# 12. The Complete Architecture

Now connect everything we've learned.

```text
                 UI
                  ↓
             ViewModel
                  ↓
              Use Case
                  ↓
             Repository
                  ↓
        ┌─────────┴─────────┐
        ↓                   ↓
 Remote Data Source    Local Data Source
        ↓                   ↓
    API Client            Database
        ↓
      Server
```

Each layer has a clear responsibility.

### UI

```text
Display information
Capture user actions
```

### ViewModel

```text
Manage UI state
Handle UI events
```

### Domain

```text
Business rules
Use cases
Core application concepts
```

### Repository

```text
Abstract data access
```

### Data Layer

```text
API
Database
Cache
External data sources
```

---

# 13. When Should You Use a Domain Layer?

This is perhaps the **most important part of this topic**.

## Small application

Suppose you're building:

```text
Todo App
```

with:

```text
Add todo
Delete todo
Mark complete
```

You might only need:

```text
UI
 ↓
ViewModel
 ↓
Repository
 ↓
Database
```

Adding:

```text
UseCase
AddTodoUseCase
DeleteTodoUseCase
CompleteTodoUseCase
```

might create more code without providing much value.

---

## Large application

Now imagine:

```text
Banking Application
```

with:

```text
Transfers
Payments
Accounts
Cards
Transactions
Fraud rules
Limits
Authentication
Notifications
```

There can be significant business logic.

Then:

```text
UI
 ↓
ViewModel
 ↓
Use Cases
 ↓
Repositories
 ↓
Data Layer
```

can make the application much easier to maintain.

---

# 14. A Good Rule

Don't ask:

> "Does professional architecture require a Domain Layer?"

Ask:

> **"Does my application have enough business complexity that a Domain Layer gives me meaningful separation?"**

If yes → use it.

If no → don't force it.

This is exactly the architectural mindset you should develop as a professional developer.

---

# 15. Simple Example: Without Domain Layer

For a simple feature:

```text
LoginScreen
    ↓
LoginViewModel
    ↓
AuthRepository
    ↓
AuthService
    ↓
API
```

That's perfectly reasonable.

---

# 16. With Domain Layer

For a more complex system:

```text
LoginScreen
    ↓
LoginViewModel
    ↓
LoginUserUseCase
    ↓
AuthRepository
    ↓
AuthService
    ↓
API
```

The use case becomes valuable if login involves significant rules:

```text
Validate credentials
Check account status
Handle MFA
Check login restrictions
Process authentication
```

---

# 17. The Biggest Mistake

A common architecture mistake is creating a use case for **everything**:

```text
GetUserUseCase
GetUserNameUseCase
GetUserEmailUseCase
GetUserPhotoUseCase
```

Even though each one simply does:

```dart
return repository.getUser();
```

Now you have:

```text
100 tiny classes
```

with very little benefit.

Architecture should reduce complexity, not increase it.

---

# 18. Remember the Difference

| Component        | Main Responsibility                       |
| ---------------- | ----------------------------------------- |
| **UI**           | Display state                             |
| **ViewModel**    | Manage UI state/events                    |
| **Use Case**     | Perform an application/business operation |
| **Domain Model** | Represent core business concepts          |
| **Repository**   | Abstract data access                      |
| **Data Source**  | Actually access API/database              |

### Easy mental model

```text
ViewModel
"What happened in the UI?"

Use Case
"What should the application do?"

Repository
"Where/how do I get or save the data?"

Data Source
"How do I actually access it?"
```

---

## ⭐ Final takeaway

The **Domain Layer is the home of important business concepts and rules**.

It commonly contains:

```text
Domain Layer
│
├── Domain Models
│
├── Use Cases
│
└── Business Rules
```

But **not every Flutter application needs it**.

> **Use a Domain Layer when business complexity makes it useful—not because an architecture diagram says you should.**