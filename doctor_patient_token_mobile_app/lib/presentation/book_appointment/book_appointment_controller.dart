import 'package:doctor_patient_token_mobile_app/app/config/app_colors.dart';
import 'package:doctor_patient_token_mobile_app/app/config/app_config.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/reserve_token_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/error_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/token_status_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/fetch_all_token_statuses_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/reserve_token_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../app/services/app_storage.dart';
import '../../app/utils/util.dart';
import '../../di/client_module.dart';
import '../../domain/entity/current_shift_entity.dart';
import '../../domain/usecase/current_shift_use_case.dart';

class BookAppointmentController extends GetxController with ClientModule {
  BookAppointmentController(
      {required this.fetchAllTokenStatusesUseCase,
      required this.currentShiftUseCase,
      required this.reserveTokenUseCase});

  final FetchAllTokenStatusesUseCase fetchAllTokenStatusesUseCase;
  final CurrentShiftUseCase currentShiftUseCase;
  final ReserveTokenUseCase reserveTokenUseCase;

  RxList<TokenStatus?> allTokenStatusList = <TokenStatus?>[].obs;
  final selectedTokenNumber = RxnInt();

  final RxInt selectedNumberOfPatients = 1.obs;
  final TextEditingController numberOfPatients = TextEditingController();

  List<TextEditingController> nameControllers = [];
  List<TextEditingController> ageControllers = [];
  RxList<String?> genderList = <String?>[].obs;

  final userRole = AppStorage.instance.userRole.obs;

  late var currentShiftEntity = CurrentShiftEntity().obs;

  RxBool selectedTab = true.obs;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = RxString('');

  String paymentLink = '';

  @override
  void onInit() async {
    super.onInit();
    numberOfPatients.text = selectedNumberOfPatients.value.toString();
    initializeControllers(selectedNumberOfPatients.value);
    print("FCM Token in Book Appointment: ${AppConfig.shared.fcmToken}");
  }

  @override
  void onReady() {
    super.onReady();
    fetchAllTokenStatuses();
    getCurrentShift();
  }

  void initializeControllers(int count) {
    nameControllers = List.generate(count, (_) => TextEditingController());
    ageControllers = List.generate(count, (_) => TextEditingController());
    genderList.value =
        List.generate(count, (_) => TextEditingController().text);
  }

  Future<void> fetchAllTokenStatuses() async {
    try {
      isLoading.value = true;

      final result = await fetchAllTokenStatusesUseCase.execute();
      if (result != null) {
        allTokenStatusList.value = result.tokens;
        print("Fetch All Token Status ${result.tokens}");
      } else {
        errorMessage.value = "Server Error Occurred";
        print("Fetch All Token Status ${errorMessage.value}");
      }
    } catch (e) {
      errorMessage.value = "An unexpected error occurred";
      print("Fetch All Token Status Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCurrentShift() async {
    try {
      Util.showLoadingIndicator();

      final result = await currentShiftUseCase.execute();
      if (result != null) {
        print(
            "Success Result Booking ${result.bookingEnable} ---- Current Shift ${result.shift}");
        currentShiftEntity.value = CurrentShiftEntity(
          shift: result.shift,
          date: result.date,
          bookingEnable: result.bookingEnable,
          message: result.message,
          userTokenNumber: result.userTokenNumber,
          userTokenStatus: result.userTokenStatus,
        );
        if (result.shift == 'morning') {
          selectedTab.value = true;
        } else if (result.shift == 'evening') {
          selectedTab.value = false;
        }
      } else {
        print("Current Shift Log Error");
        // do something else
      }
    } catch (e) {
      print("Current Shift Catch Log Error $e");
      // do something else
    } finally {
      Util.hideLoadingIndicator();
    }
  }

  void updatePatientCount(int count) {
    int oldCount = selectedNumberOfPatients.value;
    selectedNumberOfPatients.value = count;
    numberOfPatients.text = selectedNumberOfPatients.value.toString();
    if (count > oldCount) {
      for (int i = oldCount; i < count; i++) {
        nameControllers.add(TextEditingController());
        ageControllers.add(TextEditingController());
        genderList.add(TextEditingController().text);
      }
    } else if (count < oldCount) {
      nameControllers.removeRange(count, oldCount);
      ageControllers.removeRange(count, oldCount);
      genderList.removeRange(count, oldCount);
    }
  }

  bool validatePatients(BuildContext context) {
    if (selectedTokenNumber.value == null ||
        selectedTokenNumber.toString().trim().isEmpty) {
      Util.showErrorToast(
        message: "Token number is required.",
        context: context,
      );
      return false;
    }

    if (selectedNumberOfPatients.value <= 0) {
      Util.showErrorToast(
        message: "At least one patient must be selected.",
        context: context,
      );
      return false;
    }

    for (int i = 0; i < selectedNumberOfPatients.value; i++) {
      final name = nameControllers[i].text.trim();
      final age = ageControllers[i].text.trim();
      final gender = genderList[i]?.trim();

      if (name.isEmpty) {
        Util.showErrorToast(
          message: "Name is required for Patient ${i + 1}",
          context: context,
        );
        return false;
      }

      if (age.isEmpty) {
        Util.showErrorToast(
          message: "Age is required for Patient ${i + 1}",
          context: context,
        );
        return false;
      }

      // final parsedAge = int.tryParse(age);
      // if (parsedAge == null || parsedAge <= 0) {
      //   Util.showErrorToast(
      //     message: "Age must be a valid positive number for Patient ${i + 1}",
      //     context: context,
      //   );
      //   return false;
      // }

      if (gender == null || gender.isEmpty) {
        Util.showErrorToast(
          message: "Gender is required for Patient ${i + 1}",
          context: context,
        );
        return false;
      }
    }
    return true;
  }

  Future<void> submitPatientsData({
    required Function(String paymentLink) onSuccess,
  }) async {
    List<PatientInfoRequest> patients = [];

    for (int i = 0; i < selectedNumberOfPatients.value; i++) {
      final name = nameControllers[i].text.trim();
      final age = ageControllers[i].text.trim();
      final gender = genderList[i]!.trim();

      final patient = PatientInfoRequest(
        name: name,
        age: age,
        gender: gender,
      );

      patients.add(patient);
    }

    try {
      Util.showLoadingIndicator();

      final params = ReserveTokenRequest(
        numberOfPatient: selectedNumberOfPatients.value.toString(),
        patient: patients,
        tokenNumber: selectedTokenNumber.value.toString(),
        mfcToken: AppConfig.shared.fcmToken ?? '',
      );

      final result = await reserveTokenUseCase.execute(params);
      if (result != null) {
        Util.hideLoadingIndicator();
        if (result.paymentLink != null) {
          paymentLink = result.paymentLink!;
          onSuccess(result.paymentLink!);
        }
      } else {
        Util.hideLoadingIndicator();
        Get.snackbar(
          'Error',
          'Something went wrong, book another token',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.red513,
          colorText: AppColors.white,
          icon: const Icon(CupertinoIcons.info, color: AppColors.white),
        );
        fetchAllTokenStatuses();
      }
    } catch (e) {
      Util.hideLoadingIndicator();
      if (e is BaseErrorEntity) {
        Get.snackbar(
          'Error',
          '${e.message} , book another token',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.red513,
          colorText: AppColors.white,
          icon: const Icon(CupertinoIcons.info, color: AppColors.white),
        );
        fetchAllTokenStatuses();
      }
    }
  }

  /// Reset controllers to defaults (dispose old controllers and re-create)
  void resetControllers({int count = 1}) {
    // dispose current controllers
    for (var c in nameControllers) {
      c.dispose();
    }
    for (var c in ageControllers) {
      c.dispose();
    }

    // clear lists and reinitialize
    nameControllers = [];
    ageControllers = [];
    // Explicitly reset gender list with empty values
    genderList.value = List.generate(1, (_) => '');

    selectedNumberOfPatients.value = count;
    numberOfPatients.text = count.toString();

    initializeControllers(count);
    // notify listeners if using GetBuilder; Obx will react to Rx changes
    update();
  }

  @override
  void onClose() {
    for (var controller in nameControllers) {
      controller.dispose();
    }
    for (var controller in ageControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
