import 'package:doctor_patient_token_mobile_app/presentation/congratulation/congo_controller.dart';

import 'package:get/get.dart';

class CongoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CongoController());
  }
}
