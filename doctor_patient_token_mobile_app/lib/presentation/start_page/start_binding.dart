import 'package:doctor_patient_token_mobile_app/presentation/start_page/start_controller.dart';
import 'package:get/get.dart';

class StartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => StartController(),
    );
  }
}
