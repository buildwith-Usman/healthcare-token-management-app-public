import 'package:doctor_patient_token_mobile_app/app/config/app_constant.dart';
import 'package:doctor_patient_token_mobile_app/app/config/app_enum.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/input_validator.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/util.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/sign_up_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/error_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/sign_up_use_case.dart';

import 'package:flutter/material.dart';

import '../../app/config/app_routes.dart';
import '../../di/client_module.dart';
import 'package:get/get.dart';

class SignupController extends GetxController with ClientModule {
  final TextEditingController nameTextEditingController =
      TextEditingController();

  final TextEditingController emailTextEditingController =
      TextEditingController();

  final TextEditingController mobileTextEditingController =
      TextEditingController();

  String get name => nameTextEditingController.text;

  String get email => emailTextEditingController.text;

  String get mobile => mobileTextEditingController.text;

  var screenType = ScreenName.signUp;

  SignupController({
    required this.signUpUseCase,
  });

  final SignUpUseCase signUpUseCase;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> signUp() async {
    String? errorMessage;
    try {
      Util.showLoadingIndicator();

      final params = SignUpRequest(
        name: name,
        email: email,
        phone: mobile,
      );

      final result = await signUpUseCase.execute(params);
      if (result != null) {
        debugPrint("SignUp result: ${result.verificationToken}");
        Util.hideLoadingIndicator();
        goToOtpScreen(result.verificationToken);
      }
    } catch (e) {
      errorMessage = e is BaseErrorEntity
          ? (e.message ?? 'An unexpected error occurred')
          : 'An unexpected error occurred';
      debugPrint("SignUp error exception: $e");
    } finally {
      Util.hideLoadingIndicator();
      if (errorMessage != null) {
        Util.showErrorSnackBar(message: errorMessage);
      }
    }
  }


  bool validateSignUpForm(BuildContext context) {
    final name = nameTextEditingController.text;
    final email = emailTextEditingController.text;
    final phone = mobileTextEditingController.text;

    final nameValidation = InputValidator.validateName(name);
    if (nameValidation != null) {
      Util.showErrorToast(message: nameValidation, context: context);
      return false;
    }

    final emailValidation = InputValidator.validateEmail(email);
    if (emailValidation != null) {
      Util.showErrorToast(message: emailValidation, context: context);
      return false;
    }

    final phoneValidation = InputValidator.validatePhone(phone);
    if (phoneValidation != null) {
      Util.showErrorToast(message: phoneValidation, context: context);
      return false;
    }
    return true;
  }

  void goToOtpScreen(String? verificationToken) {
    Get.toNamed(AppRoutes.otp, arguments: {
      Arguments.token: verificationToken,
      Arguments.openedFrom: screenType
    });
  }



  void goToPreviousScreen() {
    Get.back();
  }
}
