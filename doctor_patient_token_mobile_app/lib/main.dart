import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/config/app_config.dart';
import 'app/config/app_pages.dart';
import 'app/environments/environment.dart';
import 'app/services/app_storage.dart';
import 'app/services/localization_service.dart';
import 'app/utils/global.dart';
import 'generated/locales.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// 🔹 Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('💤 Background message received: ${message.notification?.title}');
}

// 🔹 Initialize FCM once globally
Future<void> initFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission (needed for Android 13+ and iOS)
  await messaging.requestPermission();

  // Get FCM Token (you can send this to your backend)
  // Wrap in try-catch to handle iOS APNS token not ready yet
  try {
    final token = await messaging.getToken();
    print('✅ FCM Token: $token');
    await AppStorage.instance.setFcmToken(token ?? '');
  } catch (e) {
    print('⚠️ FCM Token not available yet (will retry later): $e');
    // Token will be retrieved later when APNS token becomes available
  }

  // Foreground message listener
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('📨 Foreground message: ${message.notification?.title}');
    print('📦 Data: ${message.data}');
  });

  // When app opened via notification
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('🚀 Notification clicked: ${message.notification?.title}');
    print('📦 Data: ${message.data}');
  });

  // Set background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Listen for token refresh (will get token when APNS is ready)
  messaging.onTokenRefresh.listen((newToken) {
    print('🔄 FCM Token refreshed: $newToken');
    AppStorage.instance.setFcmToken(newToken);
  });
}

void main() async {
  // Init widgets
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorage.instance.ensureInitialized();
  // Init environment
  String environment = const String.fromEnvironment(
    'ENV',
    // defaultValue: AppService().savedEnv ?? Environment.liv,
    defaultValue: Environment.dev,
  );
  // Init config for app based on environment
  AppConfig(env: Environment.getConfigEnvironment(environment));
  // Init Firebase
  await Firebase.initializeApp();
  // Init FCM
  await initFCM();
  runApp(const DoctorPatientTokenApp());
}

class DoctorPatientTokenApp extends StatelessWidget {
  const DoctorPatientTokenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translationsKeys: AppTranslation.translations,
      locale: LocalizationService.locale,
      initialRoute: AppPages.appInitialRoute,
      getPages: AppPages.pages,
      theme: primaryTheme,
      navigatorObservers: [navigationObserver],
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      navigatorKey: navigatorKey,
    );
  }
}
