import 'package:doctor_patient_token_mobile_app/data/api/request/update_time_setting_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/update_setting_use_case.dart';
import 'package:flutter/cupertino.dart';

import '../../app/utils/util.dart';
import '../../di/client_module.dart';
import 'package:get/get.dart';

class TimeUpdateBottomSheetController extends GetxController with ClientModule {
  final UpdateSettingUseCase updateSettingUseCase;

  TimeUpdateBottomSheetController({
    required this.updateSettingUseCase,
  });

  final TextEditingController shiftDisableController =
      TextEditingController();

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString selectedShift = 'morning'.obs;
  RxString morningShiftStartTime = ''.obs;
  RxString morningShiftEndTime = ''.obs;
  RxString eveningShiftStartTime = ''.obs;
  RxString eveningShiftEndTime = ''.obs;

  String get shiftDisable => shiftDisableController.text;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getGeneralSettings(onSuccess: (bool success) {
      if (success) {
        print("Settings fetched successfully");
      } else {
        print("Failed to fetch settings");
      }
    });
  }

  Future<void> getGeneralSettings(
      {required Function(bool success) onSuccess}) async {
    try {
      Util.showLoadingIndicator();

      final updateTimeSettingRequest = UpdateTimeSettingRequest();
      final result =
          await updateSettingUseCase.execute(updateTimeSettingRequest);
      if (result != null) {
        Util.hideLoadingIndicator();
        morningShiftStartTime.value = result.morningShiftStartTime.toString();
        morningShiftEndTime.value = result.morningShiftEndTime.toString();
        eveningShiftStartTime.value = result.eveningShiftStartTime.toString();
        eveningShiftEndTime.value = result.eveningShiftEndTime.toString();
        shiftDisableController.text = result.shiftDisablePattern.toString();
        onSuccess(true);
      } else {
        Util.hideLoadingIndicator();
        onSuccess(false);
      }
    } catch (e) {
      Util.hideLoadingIndicator();
      onSuccess(false);
    }
  }

  Future<void> updateGeneralSettings(
      {required Function(bool success) onSuccess}) async {
    try {
      Util.showLoadingIndicator();
      final updateTimeSettingRequest = UpdateTimeSettingRequest(
          morningShiftStartTime: morningShiftStartTime.value,
          morningShiftEndTime: morningShiftEndTime.value,
          eveningShiftStartTime: eveningShiftStartTime.value,
          eveningShiftEndTime: eveningShiftEndTime.value,
          shiftDisablePattern: shiftDisable
      );

      final result =
          await updateSettingUseCase.execute(updateTimeSettingRequest);
      if (result != null) {
        Util.hideLoadingIndicator();
        onSuccess(true);
      } else {
        Util.hideLoadingIndicator();
        onSuccess(false);
      }
    } catch (e) {
      Util.hideLoadingIndicator();
      onSuccess(false);
    }
  }

  void toggleShift(String shift) {
    selectedShift.value = selectedShift.value == shift ? '' : shift;
  }

  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }
}
