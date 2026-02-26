import 'package:doctor_patient_token_mobile_app/app/config/app_colors.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/login_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/error_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/login_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/login_with_google_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../app/config/app_enum.dart';
import '../../app/config/app_routes.dart';
import '../../app/services/app_storage.dart';
import '../../app/utils/input_validator.dart';
import '../../app/utils/util.dart';
import '../../di/client_module.dart';

class LoginController extends GetxController with ClientModule {
  LoginController(
      {required this.loginUseCase, required this.loginWithGoogleUseCase});

  final TextEditingController emailTextEditingController =
      TextEditingController();

  final TextEditingController passwordTextEditingController =
      TextEditingController();

  String get email => emailTextEditingController.text;

  String get password => passwordTextEditingController.text;

  var isEmailEmpty = true.obs;

  final LoginUseCase loginUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;

  @override
  Future<void> onInit() async {
    super.onInit();
    emailTextEditingController.text = '';
    passwordTextEditingController.text = '';
  }

  bool validateLoginForm(BuildContext context) {
    final email = emailTextEditingController.text;
    final password = passwordTextEditingController.text;

    final emailValidation = InputValidator.validateEmail(email);
    if (emailValidation != null) {
      Util.showErrorToast(message: emailValidation, context: context);
      return false;
    }

    final passwordValidation = InputValidator.validatePassword(password);
    if (passwordValidation != null) {
      Util.showErrorToast(message: passwordValidation, context: context);
      return false;
    }

    return true;
  }

  Future<void> login() async {
    try {
      Util.showLoadingIndicator();

      final params = LoginRequest(
        email: email,
        password: password,
      );

      final result = await loginUseCase.execute(params);
      if (result != null) {
        Util.hideLoadingIndicator();
        final userRole = _mapLevelToUserRole(result.user.level);
        if (userRole == null) {
          Get.snackbar(
            'Error',
            'Something went wrong',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.red513,
            colorText: AppColors.white,
            icon: const Icon(CupertinoIcons.info, color: AppColors.white),
          );
          return;
        }
        await AppStorage.instance.setUserRole(userRole);
        await AppStorage.instance.setUserName(result.user.name);
        await AppStorage.instance.setUserEmail(result.user.email);
        goToDashboardScreen();
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
      if (e is BaseErrorEntity) {
        Get.snackbar(
          'Error',
          e.message ?? '',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.red513,
          colorText: AppColors.white,
          icon: const Icon(CupertinoIcons.info, color: AppColors.white),
        );
      }
      debugPrint("Login error: $e");
    } finally {
      Util.hideLoadingIndicator();
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      Util.showLoadingIndicator();

      final result = await loginWithGoogleUseCase.execute();
      if (result != null) {
        final userRole = _mapLevelToUserRole(result.user.level);
        if (userRole == null) {
          Get.snackbar('Error', 'Unknown user role: ${result.user.level}');
          return;
        }
        await AppStorage.instance.setUserRole(userRole);
        Util.hideLoadingIndicator();
        goToDashboardScreen();
      } else {
        Util.showErrorToast(
          message: "Server Error Occurred",
          context: Get.context!,
        );
      }
    } catch (e) {
      Util.showErrorToast(
        message: "An unexpected error occurred",
        context: Get.context!,
      );
      debugPrint("Login error: $e");
    } finally {
      Util.hideLoadingIndicator();
    }
  }

  UserRole? _mapLevelToUserRole(String level) {
    switch (level) {
      case 'receptionist':
        return UserRole.reception;
      case 'patient':
        return UserRole.patient;
      case 'doctor':
        return UserRole.doctor;
      default:
        return null;
    }
  }

  Future<void> reset() async {
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
  }

  void goToSignUpScreen() {
    Get.toNamed(AppRoutes.signup);
  }

  void goToDashboardScreen() {
    Get.offAllNamed(AppRoutes.navScreen);
  }

  void goToForgetPasswordScreen() {
    Get.toNamed(AppRoutes.forgetPass);
  }

  @override
  void onClose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }
}
