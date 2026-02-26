import 'package:doctor_patient_token_mobile_app/app/config/app_enum.dart';
import 'package:doctor_patient_token_mobile_app/app/config/app_routes.dart';
import 'package:doctor_patient_token_mobile_app/di/client_module.dart';
import 'package:doctor_patient_token_mobile_app/presentation/navigation/nav_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../app/config/app_constant.dart';
import '../../app/services/app_storage.dart';
import '../../app/utils/util.dart';
import '../../data/api/request/appointment_history_request.dart';
import '../../domain/entity/appointment_history_entity.dart';
import '../../domain/entity/current_shift_entity.dart';
import '../../domain/usecase/current_shift_use_case.dart';
import '../../domain/usecase/current_token_use_case.dart';
import '../../domain/usecase/get_appointment_history_use_case.dart';
import '../../domain/usecase/login_user_details_use_case.dart';

class DoctorDashboardController extends GetxController
    with ClientModule, WidgetsBindingObserver {
  DoctorDashboardController({
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

  final errorMessage = ''.obs;

  RxString search = ''.obs;
  RxString bookType = ''.obs;
  RxString patientId = ''.obs;
  RxString currentShiftDate = ''.obs;

  // Pagination variables
  var nextPage = 1.obs; // next page number to request
  var lastPage = 1.obs; // last page reported by API
  var isLoadingMore = false.obs;
  var loadingPage = 0.obs; // page number currently being requested

  final NavController navController = Get.find();

  @override
  void onInit() async {
    super.onInit();
    ever(navController.currentIndex, (index) {
      if (index == 0) {
        // assuming dashboard tab is at index 0
        getCurrentShift();
        getAppointmentHistory();
      }
    });
    WidgetsBinding.instance.addObserver(this);
    debounce(search, (_) {
      getAppointmentHistory();
    }, time: const Duration(milliseconds: 500));
  }

  @override
  void onReady() {
    super.onReady();
    getLoginDetails();
    getCurrentShift();
    getAppointmentHistory();
  }

  Future<void> getLoginDetails() async {
    try {
      Util.showLoadingIndicator();

      final result = await loginUserDetailsUseCase.execute();
      if (result != null) {
        currentUserName.value = result.name;
        AppStorage.instance.setUserName(result.name);
        AppStorage.instance.setUserEmail(result.email);
      } else {
        errorMessage.value = "Something Went Wrong Login API";
      }
    } catch (e) {
      errorMessage.value = "Exception Occurred Login API";
    } finally {
      Util.hideLoadingIndicator();
    }
  }

  Future<void> getCurrentShift() async {
    try {
      Util.showLoadingIndicator();

      final result = await currentShiftUseCase.execute();
      if (result != null) {
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
        currentShiftDate.value = result.date.toString();
      } else {
        errorMessage.value = "Something Went Current Shift API";
      }
    } catch (e) {
      errorMessage.value = "Exception Occurred Current Shift API";
    } finally {
      Util.hideLoadingIndicator();
    }
  }

  Future<void> getAppointmentHistory({bool loadMore = false}) async {
    try {
      // If loading more and already loading, return
      if (loadMore && isLoadingMore.value) return;

      // Stop when nextPage > last_page (already loaded all data)
      if (loadMore && nextPage.value > lastPage.value) return;

      // Set loading state
      if (loadMore) {
        // prevent requesting same page twice
        if (loadingPage.value == nextPage.value) return;
        loadingPage.value = nextPage.value;
        isLoadingMore.value = true;
      } else {
        // Start from page = 1 (fresh load)
        nextPage.value = 1;
        lastPage.value = 1;
        Util.showLoadingIndicator();
      }

      var appointmentHistoryRequest = AppointmentHistoryRequest(
        search: search.value,
        shift: currentShiftEntity.value.shift,
        date: currentShiftEntity.value.date,
        bookType: bookType.value,
        patientId: patientId.value,
        pageNumber: nextPage.value,
      );

      final result =
          await appointmentHistoryUseCase.execute(appointmentHistoryRequest);
      if (result != null) {
        // Use API-provided pagination when available
        final apiCurrent = result.pagination?.currentPage ?? nextPage.value;
        final apiLast = result.pagination?.lastPage ?? ((result.totalAppointments ?? 0 + 19) ~/ 20);
        lastPage.value = (apiLast ?? 0) <= 0 ? 1 : apiLast!;

        if (loadMore) {
          // Append to existing list with defensive dedupe (by tokenId or id)
          final existingIds = appointmentsHistory
              .map((e) => e.tokenId ?? e.id)
              .where((v) => v != null)
              .toSet();
          final newItems = result.appointmentHistoryEntity
              .where((e) => (e.tokenId ?? e.id) == null || !existingIds.contains(e.tokenId ?? e.id))
              .toList();
          if (newItems.isNotEmpty) appointmentsHistory.addAll(newItems);
        } else {
          // Replace list with new data on fresh load
          appointmentsHistory.value = result.appointmentHistoryEntity;
        }

        totalAppointments.value = result.totalAppointments.toString();

        // Decide next page to request: if apiCurrent < apiLast, request next; otherwise mark beyond last
        if (apiCurrent < lastPage.value) {
          nextPage.value = apiCurrent + 1;
        } else {
          // set nextPage beyond last to stop further requests
          nextPage.value = lastPage.value + 1;
        }
        // clear loadingPage when finished
        loadingPage.value = 0;
      } else {
        errorMessage.value = "Something Went Appointment History API";
      }
    } catch (e) {
      errorMessage.value = "Exception Occurred Appointment History API";
    } finally {
      if (loadMore) {
        isLoadingMore.value = false;
      } else {
        Util.hideLoadingIndicator();
      }
    }
  }

  void loadMoreAppointments() {
    getAppointmentHistory(loadMore: true);
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
    if (index == 0) {
      bookType.value = '';
    } else if (index == 1) {
      bookType.value = 'manual';
    } else {
      bookType.value = 'payment';
    }
    getAppointmentHistory();
  }

  void navigateToPatientDetails() {
    Get.toNamed(AppRoutes.patientDetails);
  }

  void navigateToTokenDetails(int tokenId) {
    Get.toNamed(AppRoutes.appointmentDetails,
        arguments: {Arguments.tokenId: tokenId});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      getAppointmentHistory();
      getCurrentShift();
    }
  }
}
