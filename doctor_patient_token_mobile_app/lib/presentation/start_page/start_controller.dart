
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/config/app_routes.dart';
import '../../di/client_module.dart';

class StartController extends GetxController with ClientModule {

  void goToLoginScreen() {
    Get.toNamed(AppRoutes.logIn); // use Get.toNamed instead of Get.offNamed for navigate to next screen when you want to keep stack of screens
  }

  void goToSignUpScreen() {
    Get.toNamed(AppRoutes.signup);

  }
}
