import 'package:doctor_patient_token_mobile_app/presentation/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SplashController(),
    );
  }
}
