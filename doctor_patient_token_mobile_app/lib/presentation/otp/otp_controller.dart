import 'package:doctor_patient_token_mobile_app/app/config/app_colors.dart';
import 'package:doctor_patient_token_mobile_app/app/services/app_storage.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/resend_otp_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/error_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/otp_verification_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/resend_otp_use_case.dart';
import 'package:flutter/cupertino.dart';

import '../../app/config/app_constant.dart';
import '../../app/config/app_enum.dart';
import '../../app/config/app_routes.dart';
import '../../app/utils/util.dart';
import '../../data/api/request/otp_verification_request.dart';
import '../../di/client_module.dart';
import 'package:get/get.dart';

class OtpController extends GetxController with ClientModule {
  OtpController(
      {required this.otpVerificationUseCase, required this.resendOtpUseCase});

  final OtpVerificationUseCase otpVerificationUseCase;
  final ResendOtpUseCase resendOtpUseCase;

  final TextEditingController verificationCodeController =
      TextEditingController();

  String get verificationCode => verificationCodeController.text;

  String? verificationToken;

  final Rx<ScreenName> screenOpenedFrom = ScreenName.signUp.obs;

  BottomSheetType bottomSheetType = BottomSheetType.changeEmail;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      verificationToken = args[Arguments.token] as String?;
      screenOpenedFrom.value =
          args[Arguments.openedFrom] as ScreenName? ?? ScreenName.signUp;
      bottomSheetType = args[Arguments.updateProfileType] as BottomSheetType? ??
          BottomSheetType.changeEmail;
    } else {
      debugPrint('OtpController: No valid arguments passed');
    }
  }

  Future<void> otpVerification() async {
    debugPrint("Verification Token: $verificationToken");
    try {
      if (verificationToken == null) {
        Get.snackbar(
          'Error',
          'Empty Verification Token',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.red513,
          colorText: AppColors.white,
          icon: const Icon(CupertinoIcons.check_mark, color: AppColors.white),
        );
        return;
      }
      Util.showLoadingIndicator();
      final params = OPTVerificationRequest(
        verificationToken: verificationToken!,
        code: verificationCode,
      );

      final result = await otpVerificationUseCase.execute(params);

      if (result != null) {
        Util.hideLoadingIndicator();
        debugPrint("Success");
        if (result.verificationToken != null) {
          verificationToken = result.verificationToken!;
          if (screenOpenedFrom.value == ScreenName.setting &&
              bottomSheetType == BottomSheetType.changeEmail) {
            Get.snackbar(
              'Success',
              'Email Updated Successfully',
              snackPosition: SnackPosition.TOP,
              backgroundColor: AppColors.checkedColor,
              colorText: AppColors.white,
              icon:
                  const Icon(CupertinoIcons.check_mark, color: AppColors.white),
            );
            Future.delayed(const Duration(milliseconds: 300), () {
              goToDashboard();
            });
          } else {
            goToChoosePassScreen(verificationToken);
          }
        }
      } else {
        Util.hideLoadingIndicator();
        Get.snackbar(
          'Error',
          'No OTP Data',
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
    } finally {
      Util.hideLoadingIndicator();
    }
  }

  Future<void> resendOTP() async {
    try {
      Util.showLoadingIndicator();
      final params = ResendOtpRequest(
        verificationToken: verificationToken!,
      );

      final result = await resendOtpUseCase.execute(params);

      if (result != null) {
        Util.hideLoadingIndicator();
      } else {
        Util.hideLoadingIndicator();
      }
    } catch (e) {
      Util.hideLoadingIndicator();
    }
  }

  void goToChoosePassScreen(String? verificationToken) {
    Get.offNamed(AppRoutes.chosePass, arguments: {
      Arguments.token: verificationToken,
      Arguments.openedFrom: screenOpenedFrom.value
    });
  }

  void goToPreviousScreen() {
    Get.back();
  }

  void goToDashboard() {
    Get.offAllNamed(AppRoutes.navScreen); // Navigate to Nav Page
  }
}
