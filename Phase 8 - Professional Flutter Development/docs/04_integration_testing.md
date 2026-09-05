# Phase 8 — Professional Flutter Development

## Topic 4: Integration Testing

An **integration test** verifies that multiple parts of your application work together correctly.

Unlike unit and widget tests, integration tests focus on **complete user flows**.

---

## 1. Complete User Flows

Test what a real user actually does.

For example, in a shopping app:

```text
Open App
   ↓
Login
   ↓
Browse Products
   ↓
Open Product
   ↓
Add to Cart
   ↓
Checkout
```

The test verifies that the **whole flow** works together.

---

## 2. Multiple Screens

Integration tests can move across multiple screens:

```text
Login Screen
     ↓
Home Screen
     ↓
Product Screen
     ↓
Cart Screen
     ↓
Checkout Screen
```

This catches problems that isolated widget tests may miss, such as:

* Incorrect navigation
* State not being passed correctly
* Screens not working together
* Unexpected lifecycle/state issues

---

## 3. Real Application Behavior

Integration tests run much closer to the real application environment.

Conceptually:

```text
Integration Test
       ↓
Real App
       ↓
┌───────┼────────┐
UI   State     Data
       ↓
   User Flow
```

You interact with the application similarly to how an actual user would.

---

## 4. Critical Workflows

You don't need to integration-test every possible interaction.

Focus on **critical workflows** where failure would seriously affect the application.

Examples:

```text
Authentication
Payment / Checkout
Creating important data
Core business workflow
Account setup
```

A useful strategy is:

```text
Unit Tests
   ↓
Lots of small logic tests

Widget Tests
   ↓
Important UI behavior

Integration Tests
   ↓
Small number of critical end-to-end flows
```

---

## 🧠 Mental Model

Think of the three test levels like this:

```text
Unit
 ↓
"Does this piece of logic work?"

Widget
 ↓
"Does this widget behave correctly?"

Integration
 ↓
"Does the application work correctly
 when the user follows an important flow?"
```

### Professional rule

**Use integration tests for confidence in critical user journeys, not as a replacement for unit and widget tests.**

They are typically slower and more expensive to maintain, so keep them focused on the workflows that matter most.
