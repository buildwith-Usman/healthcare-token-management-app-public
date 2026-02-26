import 'dart:async';
import 'package:doctor_patient_token_mobile_app/app/utils/app_connectivity.dart';
import 'package:get/get.dart';
import '../../app/config/app_config.dart';
import '../../app/config/app_routes.dart';
import '../../di/client_module.dart';

class SplashController extends GetxController with ClientModule {
  var lnProgressValue = 0.0.obs;

  late String? accessToken;

  final isConnected = true.obs;
  final isCheckingConnection = false.obs;

  @override
  void onInit() {
    super.onInit();
    accessToken = AppConfig.shared.accessToken;
    // startProgress();
    updateConnectionStatus();
    print("Access Token: $accessToken");
  }

  void startProgress() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (lnProgressValue.value < 1.0) {
        lnProgressValue.value += 0.02; // Increment progress
      } else {
        timer.cancel();
        Future.delayed(Duration.zero, () {
          if (accessToken != null) {
            goToDashboard();
          } else {
            navigateToStartPage();
          }
        });
      }
    });
  }

  void updateConnectionStatus() async {
    try {
      isCheckingConnection.value = true;

      // Add small delay for better UX feedback
      await Future.delayed(const Duration(milliseconds: 500));

      bool connected = await AppConnectivity.instance.isInternetAvailable();

      if (connected) {
        isConnected.value = true;
        // Reset progress before starting
        lnProgressValue.value = 0.0;
        startProgress();
      } else {
        isConnected.value = false;
      }
    } catch (e) {
      print('Error checking connectivity: $e');
      isConnected.value = false;
    } finally {
      isCheckingConnection.value = false;
    }
  }

  void retryConnection() {
    updateConnectionStatus();
  }

  void navigateToStartPage() {
    Get.offNamed(AppRoutes.start); // Navigate to Start Page
  }

  void goToDashboard() {
    Get.offNamed(AppRoutes.navScreen); // Navigate to Nav Page
  }

  void goToSplash() {
    Get.offNamed(AppRoutes.splash); // Navigate to Splash Page
  }
}
