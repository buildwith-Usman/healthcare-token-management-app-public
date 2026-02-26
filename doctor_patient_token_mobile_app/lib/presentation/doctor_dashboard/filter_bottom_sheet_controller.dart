import 'package:doctor_patient_token_mobile_app/di/client_module.dart';
import 'package:get/get.dart';

class FilterBottomSheetController extends GetxController with ClientModule {

  Rx<DateTime> selectedDate = DateTime.now().obs;

  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  RxString selectedShift = ''.obs;

  void toggleShift(String shift) {
    selectedShift.value = selectedShift.value == shift ? '' : shift;
  }
}
