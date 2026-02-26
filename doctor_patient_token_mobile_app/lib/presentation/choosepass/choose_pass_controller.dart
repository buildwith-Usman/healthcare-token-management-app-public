import 'package:doctor_patient_token_mobile_app/data/api/request/create_password_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/create_password_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../app/config/app_constant.dart';
import '../../app/config/app_enum.dart';
import '../../app/config/app_routes.dart';
import '../../app/utils/input_validator.dart';
import '../../app/utils/util.dart';
import '../../di/client_module.dart';

class ChoosePassController extends GetxController with ClientModule {
  ChoosePassController({
    required this.createPasswordUseCase,
  });

  final CreatePasswordUseCase createPasswordUseCase;

  final TextEditingController passwordTextEditingController =
      TextEditingController();

  String get password => passwordTextEditingController.text;

  var isEmailEmpty = true.obs;
  late final String verificationToken;

  var screenType = ScreenName.password;

  final RxString screenOpenedFrom = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    verificationToken = args[Arguments.token];
    screenOpenedFrom.value = args[Arguments.openedFrom].toString();
  }

  bool validatePassword(BuildContext context) {
    final password = passwordTextEditingController.text;

    final passwordValidation = InputValidator.validatePassword(password);
    if (passwordValidation != null) {
      Util.showErrorToast(message: passwordValidation, context: context);
      return false;
    }
    return true;
  }

  Future<void> createPassword() async {
    try {
      Util.showLoadingIndicator();
      final params = CreatePasswordRequest(
        verificationToken: verificationToken,
        password: password,
      );

      final result = await createPasswordUseCase.execute(params);

      if (result != null) {
        Util.hideLoadingIndicator();
        goToCongratulationsScreen();
      } else {
        Util.hideLoadingIndicator();
        Util.showErrorToast(
          message: "Server Error Occurred",
          context: Get.context!,
        );
      }
    } catch (e) {
      Util.hideLoadingIndicator();
      if (kDebugMode) {
        print('Create Password Error: $e');
      }
    }
  }


  void goToCongratulationsScreen() {
    Get.offAllNamed(AppRoutes.congoPage,
        arguments: {Arguments.openedFrom: screenOpenedFrom.value});
  }

  void goToPreviousScreen() {
    Get.back();
  }
}
