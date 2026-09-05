# Phase 7 — Advanced Flutter

## Topic 12: Notifications

Notifications let your application communicate with users **outside the normal app UI**.

There are two main types:

```text
Local Notification
    → Created by the device/app itself

Push Notification
    → Sent from a remote server
```

---

## 1. Local Notifications

A **local notification** is scheduled or triggered directly on the device.

Examples:

* Reminder
* Scheduled task
* Alarm
* Daily notification

Conceptually:

```text
Flutter App
    ↓
Schedule / Trigger
    ↓
OS Notification System
    ↓
User sees notification
```

A common Flutter approach is using a notification plugin rather than implementing platform-specific notification APIs yourself.

---

## 2. Push Notifications

A **push notification** originates from a backend/server.

Typical flow:

```text
Your Server
    ↓
Push Notification Service
    ↓
Android / iOS
    ↓
User's Device
    ↓
Your App
```

For example:

```text
Server → "You have a new message"
             ↓
          Device
             ↓
       Notification
```

The important distinction:

> **Local = generated on the device.**
> **Push = delivered from an external system.**

---

## 3. Notification Permissions

Notifications are subject to **OS permission rules**.

Your app may need to request permission before it can show notifications, particularly on newer versions of Android and on iOS.

Conceptually:

```text
App
 ↓
Request permission
 ↓
User decides
 ↓
Allowed / Denied
 ↓
App handles the result
```

Never assume permission is automatically granted.

---

## 4. Notification Handling

A notification can interact with your application in different states:

```text
App open
App in background
App completely closed
```

Your notification handling logic should account for these states.

For example:

```text
Notification received
        ↓
What state is the app in?
        ↓
   ┌────┼────┐
   ↓    ↓    ↓
Open  Background  Closed
   ↓    ↓    ↓
Handle appropriately
```

The exact behavior depends on the notification system and platform.

---

## 5. Deep Linking from Notifications

Notifications can act as **entry points into a specific feature**.

For example:

```text
Notification:
"New message from Ahmed"
        ↓
User taps
        ↓
App opens
        ↓
Chat screen
        ↓
Conversation ID = 123
```

Conceptually:

```text
Notification
     ↓
Payload
     ↓
Route
     ↓
Screen
     ↓
Feature data
```

This connects directly with the previous topic:

> **Deep linking isn't only about URLs. A notification can also be an external entry point into your application's navigation.**

---

## 🧠 Mental Model

Think of notifications as another way users can **enter or interact with your application**:

```text
                    ┌── User opens app normally
                    │
User interaction ───┼── Deep link
                    │
                    └── Notification
                            ↓
                         Router
                            ↓
                         Feature
```

### What you should remember

* **Local notification** → generated/scheduled locally.
* **Push notification** → delivered from a server.
* **Permission** → controlled by the operating system.
* **Handling** → consider foreground, background, and terminated states.
* **Notification tap** → can navigate directly to a specific feature.
* Use a **reliable Flutter plugin** for the platform-specific notification implementation rather than writing native code yourself unless necessary.

Your roadmap explicitly places **Notifications after Platform Integration**, so the important connection is understanding that notifications are another example of Flutter communicating with platform capabilities. 
