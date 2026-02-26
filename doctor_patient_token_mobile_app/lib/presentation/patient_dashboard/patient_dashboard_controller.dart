import 'dart:async';

import 'package:doctor_patient_token_mobile_app/app/config/app_constant.dart';
import 'package:doctor_patient_token_mobile_app/app/config/app_enum.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/app_extensions.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/appointment_history_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/appointment_history_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/current_shift_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/current_shift_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/current_token_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/get_appointment_history_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/login_user_details_use_case.dart';
import 'package:doctor_patient_token_mobile_app/presentation/navigation/nav_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../app/config/app_routes.dart';
import '../../app/services/app_storage.dart';
import '../../app/utils/util.dart';
import '../../di/client_module.dart';

class PatientDashboardController extends GetxController
    with ClientModule, WidgetsBindingObserver {
  PatientDashboardController({
    required this.loginUserDetailsUseCase,
    required this.currentTokenUseCase,
    required this.appointmentHistoryUseCase,
    required this.currentShiftUseCase,
  });

  final LoginUserDetailsUseCase loginUserDetailsUseCase;
  final CurrentTokenUseCase currentTokenUseCase;
  final GetAppointmentHistoryUseCase appointmentHistoryUseCase;
  final CurrentShiftUseCase currentShiftUseCase;

  var currentTokenNumber = '00'.obs;
  var currentUserName = ''.obs;

  Timer? _tokenFetchTimer;

  var isLoading = false.obs;

  int tokenFetchTimer = 30;

  var appointmentsHistory = RxList<AppointmentHistoryEntity>();
  late var currentShiftEntity = CurrentShiftEntity().obs;

  final userRole = AppStorage.instance.userRole.obs;
  RxString tokenNumberLabel = "Token Number".obs;
  RxString totalAppointments = '0'.obs;

  RxBool hideReceptionAppointmentDetailsLayout = true.obs;

  RxString search = ''.obs;
  RxString bookType = ''.obs;
  RxString patientId = ''.obs;

  final errorMessage = ''.obs;

  RxBool bookingEnabled = false.obs;

  // Pagination variables
  var currentPage = 1.obs;
  var hasMoreData = true.obs;
  var isLoadingMore = false.obs;

  final NavController navController = Get.find();

  @override
  void onInit() async {
    super.onInit();
    if (userRole.value == UserRole.reception) {
      tokenNumberLabel.value = "TN";
    }
    ever(navController.currentIndex, (index) {
      if (index == 0) { // assuming dashboard tab is at index 0
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
  Future<void> onReady() async {
    super.onReady();
    getLoginDetails();
    await getCurrentShift();
    if (currentShiftEntity.value.bookingEnable == false) {
      getCurrentToken(initialFetch: true);
    }
    await getAppointmentHistory();
    _startTokenFetchTimer();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
    _cancelTokenFetchTimer();
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
      errorMessage.value = "Exception Occurs Login API";
    } finally {
      Util.hideLoadingIndicator();
    }
  }

  Future<void> getCurrentToken({bool initialFetch = false}) async {
    if (isLoading.value) return;
    try {
      if (initialFetch) Util.showLoadingIndicator();

      isLoading.value = true;

      final result = await currentTokenUseCase.execute();
      if (result != null) {
        updateCurrentTokenNumber(result.token);
      } else {
        errorMessage.value = "Something Went Wrong Current Token API";
      }
    } catch (e) {
      errorMessage.value = "Exception Occurs Current Token API";
    } finally {
      isLoading.value = false;
      Util.hideLoadingIndicator();
    }
  }

  void updateCurrentTokenNumber(String updatedTokenNumber) {
    currentTokenNumber.value = updatedTokenNumber.toPaddedString();
  }

  Future<void> getAppointmentHistory({bool loadMore = false}) async {
    try {
      // If loading more and already loading, return
      if (loadMore && isLoadingMore.value) return;

      // If loading more but no more data, return
      if (loadMore && !hasMoreData.value) return;

      // Set loading state
      if (loadMore) {
        isLoadingMore.value = true;
      } else {
        // Reset pagination for fresh load
        currentPage.value = 1;
        hasMoreData.value = true;
        Util.showLoadingIndicator();
      }

      var appointmentHistoryRequest = AppointmentHistoryRequest(
        search: search.value,
        // shift: currentShiftEntity.value.shift,
        // date: currentShiftEntity.value.date,
        // bookType: bookType.value,
        // patientId: patientId.value,
        pageNumber: currentPage.value,
      );

      final result =
          await appointmentHistoryUseCase.execute(appointmentHistoryRequest);
      if (result != null) {
        if (loadMore) {
          // Append to existing list
          appointmentsHistory.addAll(result.appointmentHistoryEntity);
        } else {
          // Replace list with new data
          appointmentsHistory.value = result.appointmentHistoryEntity;
        }

        totalAppointments.value = result.totalAppointments.toString();

        // Calculate if there's more data
        // Assuming 20 items per page
        int totalItems = result.totalAppointments ?? 0;
        int loadedItems = appointmentsHistory.length;
        hasMoreData.value = loadedItems < totalItems;

        // Increment page for next load
        if (hasMoreData.value) {
          currentPage.value++;
        }
      } else {
        errorMessage.value = "Something Went Wrong Appointment History API";
      }
    } catch (e) {
      errorMessage.value = "Exception Occurs Appointment History API";
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
            day: result.day);
        bookingEnable(currentShiftEntity.value);
      } else {
        errorMessage.value = "Something Went Wrong Current Shift API";
      }
    } catch (e) {
      errorMessage.value = "Exception Occurs Current Shift API";
    } finally {
      Util.hideLoadingIndicator();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("AppLifecycleState: $state");
    if (state == AppLifecycleState.resumed) {
      if (currentShiftEntity.value.bookingEnable == false) {
        getCurrentToken();
      }
      getAppointmentHistory();
      getCurrentShift();
    }
  }

  void _startTokenFetchTimer() {
    _tokenFetchTimer =
        Timer.periodic(Duration(seconds: tokenFetchTimer), (timer) {
      if (currentShiftEntity.value.bookingEnable == false) {
        getCurrentToken();
      }
    });
  }

  /// Cancels the token fetch timer
  void _cancelTokenFetchTimer() {
    _tokenFetchTimer?.cancel();
  }

  void bookingEnable(CurrentShiftEntity currentShift) {
    final shift = currentShift;
    final isBookingEnable = shift.bookingEnable ?? false;
    final isShiftDisabled = shift.currentShiftDisable ?? false;
    final hasNoToken = shift.userTokenNumber?.isNotEmpty ?? false;
    if (!isBookingEnable || isShiftDisabled || hasNoToken) {
      bookingEnabled.value = false;
    } else {
      bookingEnabled.value = true;
    }
  }

  void navigateToTokenDetails(int tokenId) {
    Get.toNamed(AppRoutes.appointmentDetails,
        arguments: {Arguments.tokenId: tokenId});
  }
}
