import 'package:doctor_patient_token_mobile_app/app/config/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../app/config/app_config.dart';
import '../../app/config/app_constant.dart';
import '../../app/config/app_enum.dart';
import '../../app/config/app_routes.dart';
import '../../app/utils/input_validator.dart';
import '../../app/utils/util.dart';
import '../../data/api/request/forgot_password_request.dart';
import '../../di/client_module.dart';
import 'package:get/get.dart';

import '../../domain/usecase/forgot_password_use_case.dart';
import '../../domain/entity/error_entity.dart';

class ForgetPassController extends GetxController with ClientModule {
  ForgetPassController({
    required this.forgotPasswordUseCase,
  });

  final TextEditingController emailTextEditingController =
      TextEditingController();

  String get email => emailTextEditingController.text;

  var isEmailEmpty = true.obs;

  final ForgotPasswordUseCase forgotPasswordUseCase;

  final Rx<ScreenName> screenOpenedFrom = ScreenName.login.obs;

  @override
  void onInit() async {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      // Handle gracefully or log
      print('⚠️ No valid arguments passed to this screen');
      screenOpenedFrom.value = args[Arguments.openedFrom];
    }

    if (screenOpenedFrom.value == ScreenName.setting) {
      emailTextEditingController.text =
          AppConfig.shared.userEmail?.toString() ?? '';
    } else {
      emailTextEditingController.text = '';
    }
    if (email.isNotEmpty) {
      isEmailEmpty.value = false;
    }
  }

  bool validateEmailForm(BuildContext context) {
    final email = emailTextEditingController.text;

    final emailValidation = InputValidator.validateEmail(email);
    if (emailValidation != null) {
      Util.showErrorToast(message: emailValidation, context: context);
      return false;
    }

    return true;
  }

  Future<void> forgotPassword() async {
    try {
      Util.showLoadingIndicator();
      final request = ForgotPasswordRequest(email: email);
      final response = await forgotPasswordUseCase.execute(request);

      if (response != null) {
        Util.hideLoadingIndicator();
        goToOtpScreen(response.verificationToken);
      } else {
        Util.hideLoadingIndicator();
        Get.snackbar(
          'Error',
          'Something went wrong',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.red513,
          colorText: AppColors.white,
          icon: const Icon(CupertinoIcons.info, color: AppColors.white),
        );
      }
    } catch (e) {
      Util.hideLoadingIndicator();
      if (kDebugMode) {
        print('Forgot Password Error: $e');
      }
      if (e is BaseErrorEntity) {
        Get.snackbar(
          'Error',
          e.message ?? 'Unknown Error',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.red513,
          colorText: AppColors.white,
          icon: const Icon(CupertinoIcons.info, color: AppColors.white),
        );
      } else {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.red513,
          colorText: AppColors.white,
        );
      }
    }
  }

  void goToOtpScreen(String? verificationToken) {
    Get.toNamed(AppRoutes.otp, arguments: {
      Arguments.token: verificationToken,
      Arguments.openedFrom: screenOpenedFrom.value,
      Arguments.updateProfileType: BottomSheetType.changePassword,
    });
  }

  void goToPreviousScreen() {
    Get.back();
  }

  @override
  void onClose() {
    emailTextEditingController.dispose();
    Util.hideLoadingIndicator();
    super.onClose();
  }
}
