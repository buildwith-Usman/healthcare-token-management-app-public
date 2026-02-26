import 'package:doctor_patient_token_mobile_app/domain/entity/token_details_entity.dart';
import 'package:get/get.dart';

import '../../app/config/app_constant.dart';
import '../../app/config/app_routes.dart';
import '../../di/client_module.dart';

class AppointmentConfirmController extends GetxController  with ClientModule {

  late var tokenDetailsEntity = TokenDetailsEntity().obs;

  @override
  void onInit() async {
    super.onInit();
    tokenDetailsEntity.value = Get.arguments?[Arguments.tokenDetails];
  }

  void goToDashboard() {
    Get.offAllNamed(AppRoutes.navScreen); // Navigate to Nav Page
  }

}