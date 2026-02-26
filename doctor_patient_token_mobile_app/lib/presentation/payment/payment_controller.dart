import 'package:doctor_patient_token_mobile_app/app/config/app_constant.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/token_details_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../app/config/app_routes.dart';
import '../../app/utils/input_validator.dart';
import '../../app/utils/util.dart';
import '../../data/api/request/token_details_request.dart';
import '../../di/client_module.dart';
import '../../domain/usecase/get_appointment_details_use_case.dart';

class PaymentController extends GetxController with ClientModule {
  PaymentController({
    required this.getAppointmentDetailsUseCase,
  });

  final GetAppointmentDetailsUseCase getAppointmentDetailsUseCase;

  RxString selectedPaymentMethod = 'JazzCash'.obs;

  final TextEditingController phoneTextEditingController =
      TextEditingController();

  String get phone => phoneTextEditingController.text;

  RxString totalAmountToBePaid = ''.obs;
  late var tokenDetailsEntity = TokenDetailsEntity().obs;

  int? tokenId;

  @override
  void onInit() async {
    super.onInit();
    getAppointmentDetail();
    updateTotalAmount(tokenDetailsEntity.value.numberOfPatients ?? 0);
  }

  void updatePaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void updateTotalAmount(int numberOfPatients) {
    int totalAmount = numberOfPatients * Token.amount;
    totalAmountToBePaid.value = totalAmount.toString();
  }

  void validatePayment(
    BuildContext context, {
    required Function(bool isSuccess) result,
  }) {
    final phoneValidation = InputValidator.validatePhone(phone);
    if (phoneValidation != null) {
      Util.showErrorToast(message: phoneValidation, context: context);
      result(false);
      return;
    }
    result(true);
  }

  void onPaymentSuccess() {
    Get.offAllNamed(AppRoutes.appointmentConfirm, arguments: {
      Arguments.tokenDetails: tokenDetailsEntity.value,
    });
  }

  Future<void> getAppointmentDetail() async {
    try {
      Util.showLoadingIndicator();
      final params = TokenDetailsRequest(
        tokenId: tokenId ?? 0,
      );

      final result = await getAppointmentDetailsUseCase.execute(params);

      if (result != null) {
        Util.hideLoadingIndicator();
        tokenDetailsEntity.value = TokenDetailsEntity(
            patientsList: result.patientsList,
            numberOfPatients: result.numberOfPatients,
            tokenNumber: result.tokenNumber,
            tokenShift: result.tokenShift,
            tokenBookedDate: result.tokenBookedDate,
            status: result.status);
      } else {
        Util.hideLoadingIndicator();
        Util.showErrorToast(
          message: "Server Error Occurred",
          context: Get.context!,
        );
      }
    } catch (e) {
      Util.hideLoadingIndicator();
    }
  }
}
