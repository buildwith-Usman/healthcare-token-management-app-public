import 'package:doctor_patient_token_mobile_app/app/config/app_enum.dart';
import 'package:doctor_patient_token_mobile_app/di/client_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../app/config/app_constant.dart';
import '../../app/config/app_routes.dart';
import '../../app/services/app_storage.dart';
import '../../app/utils/util.dart';
import '../../data/api/request/appointment_history_request.dart';
import '../../domain/entity/appointment_history_entity.dart';
import '../../domain/entity/current_shift_entity.dart';
import '../../domain/usecase/current_shift_use_case.dart';
import '../../domain/usecase/current_token_use_case.dart';
import '../../domain/usecase/get_appointment_history_use_case.dart';
import '../../domain/usecase/login_user_details_use_case.dart';

class PatientDetailsController extends GetxController
    with ClientModule, WidgetsBindingObserver {
  PatientDetailsController({
    required this.loginUserDetailsUseCase,
    required this.currentTokenUseCase,
    required this.appointmentHistoryUseCase,
    required this.currentShiftUseCase,
  });

  final LoginUserDetailsUseCase loginUserDetailsUseCase;
  final CurrentTokenUseCase currentTokenUseCase;
  final GetAppointmentHistoryUseCase appointmentHistoryUseCase;
  final CurrentShiftUseCase currentShiftUseCase;

  var currentUserName = ''.obs;

  var isLoading = false.obs;
  var shiftTime = true.obs;

  var appointmentsHistory = RxList<AppointmentHistoryEntity>();
  late var currentShiftEntity = CurrentShiftEntity().obs;

  var shift = Shift.morning.obs;

  RxString totalAppointments = '0'.obs;

  RxBool viewAllPatients = true.obs;

  var selectedTabIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onReady() {
    super.onReady();
    getLoginDetails();
    getCurrentShift();
    getAppointmentHistory("");
  }

  Future<void> getLoginDetails() async {
    try {
      Util.showLoadingIndicator();

      final result = await loginUserDetailsUseCase.execute();
      if (result != null) {
        currentUserName.value = result.name;
        await AppStorage.instance.setUserName(result.name);
        await AppStorage.instance.setUserEmail(result.email);
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
    } finally {
      Util.hideLoadingIndicator();
    }
  }

  Future<void> getCurrentShift() async {
    try {
      Util.showLoadingIndicator();

      final result = await currentShiftUseCase.execute();
      if (result != null) {
        print(
            "Success Result ${result.bookingEnable} ---- Current Shift ${result.shift}");
        currentShiftEntity.value = CurrentShiftEntity(
          shift: result.shift,
          date: result.date,
          bookingEnable: result.bookingEnable,
          message: result.message,
          userTokenNumber: result.userTokenNumber,
          userTokenStatus: result.userTokenStatus,
          day: result.day,
        );
        if (result.shift == Shift.morning.name.toString()) {
          shift.value = Shift.morning;
        } else {
          shift.value = Shift.evening;
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

  Future<void> getAppointmentHistory(String search) async {
    try {
      var appointmentHistoryRequest= AppointmentHistoryRequest(
        search: '',
        shift: '',
        date: '',
        bookType: '',
        patientId: '',
      );
      Util.showLoadingIndicator();



      final result = await appointmentHistoryUseCase.execute(appointmentHistoryRequest);
      if (result != null) {
        print(
            "Success Result ${result.appointmentHistoryEntity} ---- total: ${result.totalAppointments}");
        appointmentsHistory.value = result.appointmentHistoryEntity;
        totalAppointments.value = result.totalAppointments.toString();
      } else {
        print("Else Log Error");
        // do something else
      }
    } catch (e) {
      print("Catch Log Error $e");
      // do something else
    } finally {
      Util.hideLoadingIndicator();
    }
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void navigateToPatientDetails(int tokenId) {
    Get.toNamed(AppRoutes.patientDetails,arguments: {Arguments.tokenId: tokenId});
  }

  void navigateToTokenDetails(int tokenId) {
    Get.toNamed(AppRoutes.appointmentDetails,arguments: {Arguments.tokenId: tokenId});
  }

}
