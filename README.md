# Doctor Token Booking System - IMC (Mobile App)

A **Doctor Token Booking Mobile App** designed for Ikram Medical Center (IMC) to manage online and in-clinic appointments efficiently. Patients can securely book and track live tokens, manage profiles, view prescriptions, and receive real-time notifications. The app also supports receptionist bookings, doctor-side appointment management, and secure payment integration.

---

## Features

### Patient Module
- Book a single token for multiple patients.
- Track live token status for current day appointments.
- View appointment history and manage profiles (email, phone, password) via secure OTP.
- Receive real-time notifications when the token is nearing.
- Book tokens for morning or evening slots only within allowed times.
- Secure payment gateway integration for token booking.
- Add prescriptions for doctor view after booking.

### Receptionist Module
- Book tokens for patients via the app.
- View patient appointments (current and past).
- Access detailed token booking information, including arrival status.

### Doctor Module
- View all patient appointments (morning, evening, and past).
- Manage booking times and update token status (checked, skipped).
- View patient prescriptions.
- Manage doctor profile.

---

## Tech Stack
- **Frontend:** Flutter
- **State Management:** GetX
- **Backend:** Laravel REST API
- **Other Integrations:** Firebase Analytics, Crashlytics, App Distribution, Push Notifications

---

## Getting Started

### Prerequisites
- Flutter SDK >= 3.0
- Android Studio / VS Code
- Running Laravel backend REST API (with endpoints for authentication, appointments, tokens, prescriptions, notifications, and payments)

### Installation & Running the App
**1. Clone the repository: ** 
   git clone https://github.com/your-username/doctor-token-booking-system-mobile-app-IMC.git
   
**2. Navigate to the project folder:**
   cd doctor-token-booking-system-mobile-app-IMC

**3. Install dependencies:**
   flutter pub get

**4. Run the app:**
   flutter run
   
**Contributing**
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.
