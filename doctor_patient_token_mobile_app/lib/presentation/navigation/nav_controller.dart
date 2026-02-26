import 'package:doctor_patient_token_mobile_app/app/config/app_colors.dart';
import 'package:doctor_patient_token_mobile_app/app/config/app_icon.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/start_check_up_use_case.dart';
import 'package:doctor_patient_token_mobile_app/presentation/checking_process/checking_process_page.dart';
import 'package:doctor_patient_token_mobile_app/presentation/doctor_dashboard/doctor_dashboard_page.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../app/config/app_enum.dart';
import '../../app/services/app_storage.dart';
import '../../app/utils/util.dart';
import '../../domain/entity/current_shift_entity.dart';
import '../../domain/usecase/current_shift_use_case.dart';
import '../book_appointment/book_appointment_page.dart';
import '../patient_dashboard/patient_dashboard_page.dart';
import '../settings/setting_page.dart';
import 'nav_items.dart';

class NavController extends GetxController {
  var currentIndex = 0.obs; // The current selected index (tab)
  final navItems = <NavItem>[].obs; // Observable list of navigation items
  var shouldShowNavBar = true.obs;

  NavController({
    required this.currentShiftUseCase,
    required this.startCheckUpUseCase,
  });

  final CurrentShiftUseCase currentShiftUseCase;
  final StartCheckUpUseCase startCheckUpUseCase;

  late var currentShiftEntity = CurrentShiftEntity().obs;

  var userRole = AppStorage.instance.userRole;

  @override
  void onInit() {
    super.onInit();
    setupNavItems();
  }

  @override
  void onReady() {
    super.onReady();
    getCurrentShift();
  }

  void setupNavItems() {
    navItems.clear();
    if (userRole == UserRole.doctor) {
      navItems.add(NavItem(
          label: 'Dashboard',
          unselectedIcon: AppIcon.navHome
              .widget(height: 24, width: 24, color: AppColors.navGrey),
          selectedIcon: AppIcon.navHome
              .widget(height: 24, width: 24, color: AppColors.primary),
          screenBuilder: () => const DoctorDashboardPage()));
      navItems.add(NavItem(
          label: 'Checking',
          unselectedIcon: AppIcon.unSelectedChecking
              .widget(height: 24, width: 24, color: AppColors.navGrey),
          selectedIcon: AppIcon.checking
              .widget(height: 24, width: 24, color: AppColors.primary),
          screenBuilder: () => const CheckingProcessPage()));
    } else {
      navItems.add(NavItem(
          label: 'Dashboard',
          unselectedIcon: AppIcon.navHome
              .widget(height: 24, width: 24, color: AppColors.navGrey),
          selectedIcon: AppIcon.navHome
              .widget(height: 24, width: 24, color: AppColors.primary),
          screenBuilder: () => const PatientDashboardPage()));
      navItems.add(NavItem(
          label: 'Book Appointment',
          unselectedIcon: AppIcon.navBookAppointment
              .widget(height: 24, width: 24, color: AppColors.navGrey),
          selectedIcon: AppIcon.navBookAppointment
              .widget(height: 24, width: 24, color: AppColors.primary),
          screenBuilder: () => const BookAppointmentPage()));
    }
    navItems.add(NavItem(
        label: 'Settings',
        unselectedIcon: AppIcon.navSetting
            .widget(height: 24, width: 24, color: AppColors.grey20),
        selectedIcon: AppIcon.navSetting
            .widget(height: 24, width: 24, color: AppColors.primary),
        screenBuilder: () => const SettingPage()));
  }

  void changeTab(int index, {bool startCheckingProcess = false}) {
    final shift = currentShiftEntity.value;
    final isBookingEnable = shift.bookingEnable ?? false;
    final isShiftDisabled = shift.currentShiftDisable ?? false;
    final hasNoToken = shift.userTokenNumber?.isNotEmpty ?? false;
    print('isBookingEnabled: $isBookingEnable');
    print('isShiftDisabled: $isShiftDisabled');
    print('hasNoToken: $hasNoToken');
    if (userRole != UserRole.doctor &&
        index == 1 &&
        (!isBookingEnable || isShiftDisabled || hasNoToken)) {
      return;
    }
    // For doctors trying to access checking tab
    if (userRole == UserRole.doctor && index == 1 && startCheckingProcess) {
      try {
        startChecking(onResult: (success) {
          if (success) {
            currentIndex.value = index;
          } else {
            Get.snackbar(
              'Error',
              'Somethinh went wrong while starting the checking process.',
              snackPosition: SnackPosition.TOP,
              backgroundColor: AppColors.red513,
              colorText: AppColors.white
            //   icon: const Icon(CupertinoIcons.info, color: AppColors.white),
            );
          }
        });
        return;
      } catch (e) {
        Get.snackbar(
              'Error',
              'Somethinh went wrong while starting the checking process.',
              snackPosition: SnackPosition.TOP,
              backgroundColor: AppColors.red513,
              colorText: AppColors.white
            //   icon: const Icon(CupertinoIcons.info, color: AppColors.white),
            );
        debugPrint('Error starting check: $e');
        return;
      }
    }
    currentIndex.value = index;
  }

  void hideNavBar() {
    shouldShowNavBar.value = false;
  }

  void showNavBar() {
    shouldShowNavBar.value = true;
  }

  Future<void> getCurrentShift() async {
    try {
      Util.showLoadingIndicator();

      final result = await currentShiftUseCase.execute();
      if (result != null) {
        print("Success Result ${result.userTokenStatus}");
        currentShiftEntity.value = CurrentShiftEntity(
          shift: result.shift,
          date: result.date,
          bookingEnable: result.bookingEnable,
          message: result.message,
          userTokenNumber: result.userTokenNumber,
          userTokenStatus: result.userTokenStatus,
        );
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

  Future<void> startChecking({
    required Function(bool success) onResult,
  }) async {
    try {
      Util.showLoadingIndicator();

      final result = await startCheckUpUseCase.execute();
      if (result != null) {
        Util.hideLoadingIndicator();
        onResult(true);
      } else {
        Util.hideLoadingIndicator();
        onResult(false);
      }
    } catch (e) {
      Util.hideLoadingIndicator();
      debugPrint("Start Checking Exception: ${e.toString()}");
      onResult(false);
    } finally {
      Util.hideLoadingIndicator();
    }
  }
}
