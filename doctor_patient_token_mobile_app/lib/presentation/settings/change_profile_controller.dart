import 'package:doctor_patient_token_mobile_app/data/api/request/change_phone_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/change_email_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/change_phone_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../app/config/app_constant.dart';
import '../../app/config/app_enum.dart';
import '../../app/config/app_routes.dart';
import '../../app/utils/input_validator.dart';
import '../../app/utils/util.dart';
import '../../data/api/request/change_email_request.dart';
import '../../di/client_module.dart';

class ChangeProfileController extends GetxController with ClientModule {
  BottomSheetType? type;

  ChangeProfileController({
    required this.changeEmailUseCase,
    required this.changePhoneUseCase,
  });

  final TextEditingController textFieldTextEditingController =
      TextEditingController();

  String get fieldText => textFieldTextEditingController.text;

  final ChangeEmailUseCase changeEmailUseCase;
  final ChangePhoneUseCase changePhoneUseCase;

  var screenType = ScreenName.setting;


  Future<void> submitData(BuildContext context,
      {required Function(bool success, String? token) onSucces}) async {
    if (type == BottomSheetType.changeEmail) {
      final emailValidation = InputValidator.validateEmail(fieldText);
      if (emailValidation != null) {
        Util.showErrorToast(message: emailValidation, context: context);
        return;
      }
    } else {
      final phoneValidation = InputValidator.validatePhone(fieldText);
      if (phoneValidation != null) {
        Util.showErrorToast(message: phoneValidation, context: context);
        return;
      }
    }
    if (type == BottomSheetType.changeEmail) {
      await changeEmail(onSuccess: onSucces);
    } else {
      await changePhone(onSuccess: onSucces);
    }
  }

  Future<void> changeEmail(
      {required Function(bool success, String? token) onSuccess}) async {
    try {
      Util.showLoadingIndicator();

      final changeEmailRequest = ChangeEmailRequest(
        email: fieldText,
      );
      final result = await changeEmailUseCase.execute(changeEmailRequest);
      if (result != null) {
        debugPrint("Email changed successfully ${result.verificationToken}");
        Util.hideLoadingIndicator();
        onSuccess(true, result.verificationToken);
      } else {
        Util.hideLoadingIndicator();
        Util.showErrorToast(
          message: "Server Error Occurred",
          context: Get.context!,
        );
        onSuccess(false, null);
      }
    } catch (e) {
      Util.hideLoadingIndicator();
      Util.showErrorToast(
        message: "An unexpected error occurred",
        context: Get.context!,
      );
      onSuccess(false, null);
    }
  }

  Future<void> changePhone({required Function(bool success, String? token) onSuccess}) async {
    try {
      Util.showLoadingIndicator();

      final changePhoneRequest = ChangePhoneRequest(
        phone: fieldText,
      );
      final result = await changePhoneUseCase.execute(changePhoneRequest);
      if (result != null) {
        debugPrint("Phone changed successfully ${result.updated}");
        Util.hideLoadingIndicator();
        onSuccess(true, null);
      } else {
        Util.hideLoadingIndicator();
        Util.showErrorToast(
          message: "Server Error Occurred",
          context: Get.context!,
        );
        onSuccess(false, null);
      }
    } catch (e) {
      Util.hideLoadingIndicator();
      Util.showErrorToast(
        message: "An unexpected error occurred",
        context: Get.context!,
      );
      onSuccess(false, null);
    }
  }

  void goToOtpScreen(String? verificationToken) {
    Get.toNamed(AppRoutes.otp, arguments: {
      Arguments.token: verificationToken,
      Arguments.openedFrom: screenType,
      Arguments.updateProfileType: type,
    });
  }

  @override
  void dispose() {
    textFieldTextEditingController.dispose();
    super.dispose();
  }

}
