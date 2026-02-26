# doctor_patient_token_mobile_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

- To create .g glasses run this command
flutter pub run build_runner build
- If sometime if .g classes not generate perfectly then run this command
flutter clean
flutter pub get
flutter pub run build_runner build
flutter pub run build_runner build --delete-conflicting-outputs

- To add any new dependency into flutter project run this command
flutter pub add "Dependency Name"

- To add localization run these commands
get generate locales assets/locales

- Use the full path (works immediately)
$HOME/.pub-cache/bin/get generate locales assets/locales

-To generate SHA-1 Run this command
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore

-Use this password
android

flutter pub run flutter_launcher_icons

Firebase Crashlytics
id("com.google.firebase.crashlytics") version "3.0.2"
id("com.google.firebase.crashlytics")
firebase_analytics: ^11.0.0
firebase_crashlytics: ^4.1.0


