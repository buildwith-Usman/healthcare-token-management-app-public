import 'package:doctor_patient_token_mobile_app/presentation/appointment_confirm/appointment_confirm_controller.dart';
import 'package:get/get.dart';

class AppointmentConfirmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppointmentConfirmController());
  }
}
