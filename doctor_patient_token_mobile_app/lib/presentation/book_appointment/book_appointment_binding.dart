import 'package:doctor_patient_token_mobile_app/presentation/book_appointment/book_appointment_page.dart';
import 'package:get/get.dart';

class BookAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => const BookAppointmentPage());
  }
}
