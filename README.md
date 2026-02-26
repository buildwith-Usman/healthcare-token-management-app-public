# Healthcare Token Management App

A full-featured **Flutter mobile application** built for **Ikram Medical Center (IMC)** to digitize and streamline the doctor-patient appointment and token management workflow. The app serves three distinct user roles — Patient, Doctor, and Receptionist — each with a dedicated, role-specific experience.

---

## Overview

Managing patient flow in a busy clinic is a logistical challenge. This app replaces paper-based token systems with a real-time digital solution: patients book slots online, track their live token position, receive push notifications as their turn approaches, and pay securely — all from their phone.

---

## Screenshots

> _Screenshots/demo to be added here._

---

## Key Features

### Patient
- Book appointment tokens for morning or evening slots within allowed booking windows
- Track live token position in real time throughout the day
- Receive push notifications when their turn is near
- View full appointment history with pagination
- Upload prescriptions for the doctor to review
- Manage profile (name, email, phone, password) via OTP verification
- Secure online payment via JazzCash / PayPro integration
- Google Sign-In support

### Doctor
- View all patient appointments — morning, evening, and historical
- Mark tokens as checked or skipped to advance the queue
- View patient-uploaded prescriptions
- Manage clinic shift timings
- Manage doctor profile

### Receptionist
- Book tokens on behalf of walk-in patients
- View current and past patient appointments
- Access detailed token and arrival status information

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.x (Dart) |
| State Management | GetX |
| Networking | Dio + Retrofit (type-safe REST client) |
| Backend | Laravel REST API |
| Auth | JWT + Flutter Secure Storage |
| Push Notifications | Firebase Cloud Messaging (FCM) |
| Analytics & Crash Reporting | Firebase Analytics + Crashlytics |
| Local Storage | GetStorage |
| Payments | JazzCash / PayPro gateway |
| Code Generation | build_runner, json_serializable, flutter_gen |
| Localization | easy_localization |

---

## Architecture

The project follows a **clean, layered architecture** with clear separation of concerns:

```
lib/
├── app/
│   ├── config/          # App-wide constants, routes, colors, enums
│   ├── environments/    # Dev / Production environment configs
│   ├── services/        # Identity, storage, localization services
│   └── utils/           # Extensions, validators, connectivity helpers
├── data/
│   ├── datasource/      # Remote data sources (Auth, Appointment, Token, Payment, User)
│   ├── repository/      # Repository implementations
│   └── mapper/          # DTO ↔ Domain model mappers
├── domain/
│   ├── model/           # Pure domain models
│   ├── repository/      # Repository interfaces
│   └── usecase/         # Business logic use cases
├── presentation/
│   ├── [feature]/       # Each screen: Page + Controller + Binding (GetX)
│   └── widgets/         # Reusable UI components
└── di/                  # Dependency injection modules
```

**Pattern used:** Repository pattern + Use Case layer + GetX controllers as ViewModels. Each feature folder contains its own `Page`, `Controller`, and `Binding` — keeping features self-contained and testable.

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.6.0`
- Android Studio or VS Code with Flutter/Dart plugins
- A running instance of the Laravel backend API

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/your-username/healthcare-token-management-app.git
cd healthcare-token-management-app/doctor_patient_token_mobile_app

# 2. Install dependencies
flutter pub get

# 3. Generate code (models, assets, routes)
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Configure the backend URL
# Edit lib/app/environments/production_env.dart and set your API base URL

# 5. Run the app
flutter run
```

### Environment Configuration

The app supports separate development and production environments. Set the API base URL in:
- `lib/app/environments/development_env.dart`
- `lib/app/environments/production_env.dart`

---

## Security Highlights

- **JWT authentication** with secure token storage via `flutter_secure_storage`
- **HTTPS only** — no cleartext traffic permitted
- **Encrypted credential storage** on device
- **OTP-based verification** for sensitive profile changes
- **TLS 1.2+ enforced** at the network layer

---

## Platform Support

| Platform | Status |
|---|---|
| Android | Supported (Android 5.0+) |
| iOS | Supported (iOS 12.0+) |

---

## Dependencies (Notable)

| Package | Purpose |
|---|---|
| `get` | State management, routing, dependency injection |
| `dio` + `retrofit` | Type-safe HTTP client |
| `firebase_messaging` | Push notifications |
| `firebase_analytics` + `firebase_crashlytics` | Analytics and crash reporting |
| `flutter_secure_storage` | Encrypted credential storage |
| `easy_localization` | Multi-language support |
| `table_calendar` | Appointment date picker |
| `image_picker` | Prescription image upload |
| `google_sign_in` | OAuth sign-in |
| `connectivity_plus` | Network status monitoring |

---

## License

This project is licensed under the terms in [LICENSE](LICENSE).
