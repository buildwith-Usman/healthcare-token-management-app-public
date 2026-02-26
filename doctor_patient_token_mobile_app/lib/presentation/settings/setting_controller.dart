import 'package:doctor_patient_token_mobile_app/app/config/app_routes.dart';
import 'package:doctor_patient_token_mobile_app/di/client_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../app/config/app_config.dart';
import '../../app/config/app_constant.dart';
import '../../app/config/app_enum.dart';
import '../../app/services/app_storage.dart';

class SettingController extends GetxController with ClientModule {
  RxString userName = ''.obs;
  RxString userEmail = ''.obs;

  var screenType = ScreenName.setting;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadProfileData();
    debugPrint(
        "User Name: ${userName.value} ----- User Email: ${userEmail.value}");
  }

  void goToChangePasswordScreen() {
    Get.toNamed(AppRoutes.forgetPass,
        arguments: {Arguments.openedFrom: screenType});
  }

  void clearStorageAndNavigateToStartScreen() {
    AppStorage.instance.clearGetStorage();
    Get.offAllNamed(AppRoutes.start);
  }

  void loadProfileData() {
    userName.value = AppConfig.shared.userName?.toString() ?? '';
    userEmail.value = AppConfig.shared.userEmail?.toString() ?? '';
  }
}
