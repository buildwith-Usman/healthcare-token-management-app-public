import 'dart:convert';
import 'dart:io';

import 'package:doctor_patient_token_mobile_app/data/api/request/add_prescription_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/token_details_request.dart';
import 'package:doctor_patient_token_mobile_app/di/client_module.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/get_appointment_details_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/upload_prescription_use_case.dart';
import 'package:get/get.dart';

import '../../app/config/app_constant.dart';
import '../../app/config/app_enum.dart';
import '../../app/services/app_storage.dart';
import '../../app/utils/util.dart';
import '../../domain/entity/token_details_entity.dart';

class DetailAppointmentController extends GetxController with ClientModule {
  DetailAppointmentController(
      {required this.getAppointmentDetailsUseCase,
      required this.uploadPrescriptionUseCase});

  final GetAppointmentDetailsUseCase getAppointmentDetailsUseCase;
  final UploadPrescriptionUseCase uploadPrescriptionUseCase;

  late final int tokenId;
  late var tokenDetailsEntity = TokenDetailsEntity().obs;
  late final String appointmentId;

  final userRole = AppStorage.instance.userRole.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    tokenId = args[Arguments.tokenId];
  }

  @override
  void onReady() {

    super.onReady();
    getAppointmentDetail();
  }

  Future<void> getAppointmentDetail() async {
    try {
      Util.showLoadingIndicator();
      final params = TokenDetailsRequest(
        tokenId: tokenId,
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
        appointmentId = result.appointmentId ?? '';
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



  Future<void> uploadPrescription({
    required String imagePath,
    required void Function(String resultPath) onSuccess,
  }) async {
    print("Appointment ID: $appointmentId");

    try {
      Util.showLoadingIndicator();

      // Convert image file to base64
      final File imageFile = File(imagePath);
      final List<int> imageBytes = await imageFile.readAsBytes();
      final String base64Image = base64Encode(imageBytes);
      final String formattedImage = 'data:image/png;base64,$base64Image';

      // Prepare request parameters
      final params = AddPrescriptionRequest(
        appointmentId: appointmentId,
        prescriptionImage: base64Image,
      );

      final result = await uploadPrescriptionUseCase.execute(params);

      Util.hideLoadingIndicator();

      if (result != null) {
        print("Upload Prescription Success ${result.path}");
        onSuccess(result.path.toString()); // Call the higher-order function with result
      } else {
        print("Upload Prescription Error");
        Util.showErrorToast(
          message: "Server Error Occurred",
          context: Get.context!,
        );
      }
    } catch (e) {
      print("Upload Prescription Error: ${e.toString()}");
      Util.hideLoadingIndicator();
      Util.showErrorToast(
        message: "Something went wrong. Please try again.",
        context: Get.context!,
      );
    }
  }


  void goToPreviousScreen() {
    Get.back();
  }
}
