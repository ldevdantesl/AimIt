# Goal Management App

## Overview
This app is designed to help users manage their goals effectively by creating milestones, organizing tasks into workspaces, and tracking progress with a beautifully crafted user interface. It employs robust architecture and advanced Swift development practices to deliver an exceptional experience.

## Key Features
- **Goal and Milestone Management:** Create, edit, and track goals with associated milestones.
- **Workspaces:** Organize tasks and goals into dedicated workspaces.
- **Custom Animations:** Smooth, visually appealing animations enhance the user experience.
- **Charts:** Interactive visualizations to track progress.
- **Notifications:** Integration with `UNUserNotifications` for reminders and alerts.
- **Photo Library Usage:** Add images to tasks or goals for better visualization.
- **Custom Illustrations:** Unique illustrations and button designs for a modern look.
- **Introductory Views:** Onboarding screens to guide new users.
- **Error Handling:** Comprehensive error management using async/await, `throws`, and completion handlers.

## Technical Highlights
- **Architecture:** Clean Architecture + SOLID Principles + MVVM
  - **Repositories:** Handle data access and management.
  - **Use Cases:** Encapsulate business logic.
  - **View Models:** Manage the state and provide data for SwiftUI views.
  - **Managers:** Handle specific tasks (e.g., network, data, or notifications).
- **SwiftUI with UIKit:** Main UI built with SwiftUI, with selective use of UIKit for advanced customizations.
- **Core Data:** Persistent storage for goals, milestones, and user data.
- **Dependency Injection (DI):** Applied via DI containers using the factory paradigm and `Actor` for thread-safe operations.
- **Custom Reusable Components:** Modular and reusable UI elements for consistency and maintainability.
- **Concurrency:** Extensive use of `async/await`, `withCheckedContinuation`, and multithreading for optimal performance.

## Development Practices
- **Error Handling:** User-friendly error messages using custom `LocalizedError` conformances.
- **Testing:** Includes unit tests with `XCTest` to ensure reliability.
- **Analytics:** Integrated analytics for user activity and app usage.
- **Design:** Focus on modern and clean design principles, adhering to Apple’s HIG guidelines.

## How to Build
1. Clone the repository:
   ```bash
   git clone https://github.com/ldevdantesl/AimIt.git
   ```
2. Open the project in Xcode:
   ```bash
   cd AimIt
   open AimIt.xcodeproj
   ```
3. Install dependencies (if applicable, e.g., CocoaPods or Swift Package Manager).
   ```bash
   pod install
   ```
4. Run the app:
   - Select the appropriate simulator/device.
   - Press `Cmd + R` or click **Run** in Xcode.

## Requirements
- **Xcode:** Version 14.0+
- **iOS:** Version 15.0+

## Screenshots
<img src="https://github.com/user-attachments/assets/7d0e3bfc-937b-4dae-984f-cb2815d0f7b5" alt="Description" width="400"/>
<img src="https://github.com/user-attachments/assets/12f43f7c-110c-4a4b-8214-7f9e0c118a5c" alt="Description" width="400"/>
<img src="https://github.com/user-attachments/assets/692ca384-e0dd-4a2f-ab4b-d74a71e7f63b" alt="Description" width="400"/>
<img src="https://github.com/user-attachments/assets/e20d63b2-f786-4e6b-a4da-7df6c1f8926a" alt="Description" width="400"/>
<img src="https://github.com/user-attachments/assets/4c433444-44cc-466f-9eb1-38f0f3f58bee" alt="Description" width="400"/>
<img src="https://github.com/user-attachments/assets/aafe83c1-abc7-43f5-98ef-8bfba2e36408" alt="Description" width="400"/>
<img src="https://github.com/user-attachments/assets/ff514f27-f8cf-444f-862d-7c24810b04cd" alt="Description" width="400"/>
<img src="https://github.com/user-attachments/assets/0855a9cf-0219-4216-a143-e0dfd394906e" alt="Description" width="400"/>
<img src="https://github.com/user-attachments/assets/415f1525-4c88-4119-a8ac-4a62f981fb6d" alt="Description" width="400"/>
<img src="https://github.com/user-attachments/assets/f1abb86b-ba4a-4405-8604-b75e3a5e80b7" alt="Description" width="400"/>

## Contributing
Contributions are welcome! Feel free to fork the repo and submit a pull request. Please ensure all changes adhere to the app's architecture and coding standards.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

---

### Contact
For any inquiries or feedback, please contact:
- **Email:** ldevdantesl@gmail.com
- **GitHub:** [ldevdantesl](https://github.com/ldevdantesl)

