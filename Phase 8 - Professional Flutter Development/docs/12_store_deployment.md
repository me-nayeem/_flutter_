# Phase 8 — Professional Flutter Development

## Topic 12: Store Deployment

> **Core idea:** Building the app is only half the job. Getting it in front of users means navigating each store's review process, listing requirements, and release mechanics.

---

### Android

## 1. Google Play Console

The dashboard for managing your Android app: releases, listings, testing tracks, and analytics.

```
Play Console
├── App bundle upload
├── Store listing
├── Release tracks
└── Reports
```

---

## 2. App Bundle

Google requires the AAB format (not raw APK) for production releases:

```
flutter build appbundle --release --flavor prod
```

Play generates optimized, device-specific APKs from the bundle at install time.

---

## 3. Store Listing

```
App name
Short + full description
Screenshots (per device type)
Icon
Privacy policy URL
Content rating
```

Incomplete listings are a common reason for review delays.

---

## 4. Release Tracks

```
Internal testing  → small team, instant
Closed testing    → invited testers
Open testing      → public beta
Production        → all users
```

Promote a build through tracks rather than pushing straight to production.

---

## 5. Production Release

```
Upload AAB
   ↓
Fill release notes
   ↓
Submit for review
   ↓
Rollout (can be staged, e.g. 20% → 100%)
```

Staged rollouts let you catch issues before every user is affected.

---

### iOS

## 6. App Store Connect

Apple's equivalent dashboard: builds, listings, TestFlight, and submission status.

```
App Store Connect
├── Build upload (via Xcode/Transporter)
├── App information
├── TestFlight
└── Submission
```

---

## 7. iOS Distribution

Requires a distribution certificate + provisioning profile (Topic 10), then:

```
flutter build ipa --release
```

The `.ipa` is uploaded via Xcode or the Transporter app.

---

## 8. TestFlight

Apple's beta testing platform, similar in spirit to Play's testing tracks:

```
Internal testers → up to 100, no review needed
External testers → up to 10,000, requires brief Beta App Review
```

---

## 9. App Submission

```
Upload build
   ↓
Fill metadata (screenshots, description, privacy)
   ↓
Submit for App Review
   ↓
Apple reviews (manual + automated checks)
   ↓
Approved / Rejected
```

Rejections often cite guideline violations — read Apple's review notes carefully before resubmitting.

---

## 10. Production Release

```
Approved
   ↓
Manual release / Automatic release / Scheduled release
   ↓
Live on the App Store
```

---

## 🧠 Mental Model

```
Android                    iOS
Play Console       ↔       App Store Connect
AAB                ↔       IPA
Release tracks     ↔       TestFlight
Production rollout ↔       App Review → Release
```

> **Rule of thumb:** Test through the store's own beta channel (internal track / TestFlight) before every production release — it catches issues a local build never will.

## Key Takeaways

- Android ships as AAB through Play Console; iOS ships as IPA through App Store Connect.
- Both platforms offer staged testing before full production release.
- Store listings (screenshots, descriptions, privacy policy) are part of the release, not an afterthought.
- Use staged/phased rollouts to limit blast radius if something goes wrong.

## Practice

1. Build and upload an AAB to Play Console's internal testing track.
2. Set up an iOS TestFlight build with internal testers.
3. Explain why a staged rollout is safer than releasing to 100% of users immediately.