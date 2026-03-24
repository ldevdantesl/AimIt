# AimIt — Goal Management for iOS

A full-featured goal tracking app built with **SwiftUI**, **Core Data**, and **Clean Architecture**. Published on the App Store. Designed, architected, and developed solo.


[![Download on the App Store](https://img.shields.io/badge/App_Store-Download-blue?logo=apple)](https://apps.apple.com/us/app/aim-it/id6740979997)

## Screenshots

<p>
  <img src="https://github.com/user-attachments/assets/7d0e3bfc-937b-4dae-984f-cb2815d0f7b5" width="180"/>
  <img src="https://github.com/user-attachments/assets/12f43f7c-110c-4a4b-8214-7f9e0c118a5c" width="180"/>
  <img src="https://github.com/user-attachments/assets/692ca384-e0dd-4a2f-ab4b-d74a71e7f63b" width="180"/>
  <img src="https://github.com/user-attachments/assets/e20d63b2-f786-4e6b-a4da-7df6c1f8926a" width="180"/>
  <img src="https://github.com/user-attachments/assets/4c433444-44cc-466f-9eb1-38f0f3f58bee" width="180"/>
</p>
<p>
  <img src="https://github.com/user-attachments/assets/aafe83c1-abc7-43f5-98ef-8bfba2e36408" width="180"/>
  <img src="https://github.com/user-attachments/assets/ff514f27-f8cf-444f-862d-7c24810b04cd" width="180"/>
  <img src="https://github.com/user-attachments/assets/0855a9cf-0219-4216-a143-e0dfd394906e" width="180"/>
  <img src="https://github.com/user-attachments/assets/415f1525-4c88-4119-a8ac-4a62f981fb6d" width="180"/>
  <img src="https://github.com/user-attachments/assets/f1abb86b-ba4a-4405-8604-b75e3a5e80b7" width="180"/>
</p>

## What It Does

AimIt helps users break down long-term goals into milestones, organize work into dedicated workspaces, and track progress through interactive charts. It includes onboarding, push notifications for reminders, photo attachments, and custom illustrations throughout the UI.

## Tech Stack

| Layer | Details |
|-------|---------|
| **UI** | SwiftUI + selective UIKit for advanced customizations |
| **Architecture** | Clean Architecture, MVVM, SOLID |
| **Persistence** | Core Data |
| **Concurrency** | async/await, withCheckedContinuation, Actors |
| **DI** | Custom DI container using Factory pattern with Actor-based thread safety |
| **Testing** | XCTest unit tests |
| **Notifications** | UNUserNotifications |

## Architecture

```
Presentation        Domain             Data
┌──────────┐    ┌──────────────┐    ┌──────────────┐
│  SwiftUI │───▶│  Use Cases   │───▶│ Repositories │
│  Views   │    │  (Business   │    │ (Core Data)  │
│          │    │   Logic)     │    │              │
│ ViewModels│◀──│              │◀───│              │
└──────────┘    └──────────────┘    └──────────────┘
```

The app follows a strict dependency rule — outer layers depend on inner layers, never the reverse. ViewModels talk to Use Cases, Use Cases talk to Repository protocols, and the Data layer provides concrete implementations backed by Core Data.

## Highlights

**End-to-end ownership** — sole developer from concept to App Store release, including architecture decisions, UI/UX design, data modeling, and deployment.

**Clean separation of concerns** — Repositories handle data access, Use Cases encapsulate business logic, ViewModels manage UI state. Each layer is independently testable.

**Modern Swift concurrency** — async/await throughout the networking and data layers, with `withCheckedContinuation` to bridge callback-based APIs and Actor isolation for thread-safe shared state.

**Custom DI system** — dependency injection container built on the Factory pattern, avoiding third-party DI frameworks while maintaining full testability.

**Polished UI details** — custom animations, hand-crafted illustrations, reusable component library, and onboarding flow. Follows Apple's Human Interface Guidelines.

## Getting Started

```bash
git clone https://github.com/ldevdantesl/AimIt.git
cd AimIt
open AimIt.xcodeproj
# Cmd + R to build and run
```

Requires Xcode 14.0+ and targets iOS 15.0+.

## License

This project is shared for portfolio and educational purposes only. All rights reserved.

You may view and fork this repository for reference, but you may not copy, modify, distribute, or use any part of this code in your own projects — personal or commercial — without explicit written permission from the author.

## Contact

Buzurgmehr Rahimzoda — [ldevdantesl@gmail.com](mailto:ldevdantesl@gmail.com) · [GitHub](https://github.com/ldevdantesl)
