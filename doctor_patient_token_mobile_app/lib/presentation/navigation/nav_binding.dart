import 'package:doctor_patient_token_mobile_app/domain/usecase/checked_token_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/current_shift_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/current_token_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/reserve_token_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/start_check_up_use_case.dart';
import 'package:doctor_patient_token_mobile_app/presentation/checking_process/checking_process_controller.dart';
import 'package:doctor_patient_token_mobile_app/presentation/doctor_dashboard/doctor_dashboard_controller.dart';
import 'package:doctor_patient_token_mobile_app/presentation/navigation/nav_controller.dart';
import 'package:doctor_patient_token_mobile_app/presentation/patient_dashboard/patient_dashboard_controller.dart';
import 'package:doctor_patient_token_mobile_app/presentation/settings/setting_controller.dart';
import 'package:get/get.dart';

import '../../di/client_module.dart';
import '../../di/config_module.dart';
import '../../di/datasource_module.dart';
import '../../di/repository_module.dart';
import '../../domain/usecase/fetch_all_token_statuses_use_case.dart';
import '../../domain/usecase/get_appointment_history_use_case.dart';
import '../../domain/usecase/login_user_details_use_case.dart';
import '../book_appointment/book_appointment_controller.dart';

class NavBinding extends Bindings
    with ClientModule, DatasourceModule, RepositoryModule, ConfigModule {
  @override
  void dependencies() {
    Get.lazyPut(
      () => NavController(
          currentShiftUseCase: CurrentShiftUseCase(
              appointmentRepository: appointmentRepository),
              startCheckUpUseCase: StartCheckUpUseCase(
              tokenBookingRepository: tokenBookingRepository)
              ),
    );
    Get.lazyPut(
      () => PatientDashboardController(
          loginUserDetailsUseCase:
              LoginUserDetailsUseCase(userRepository: userRepository),
          currentTokenUseCase: CurrentTokenUseCase(
              tokenBookingRepository: tokenBookingRepository),
          appointmentHistoryUseCase: GetAppointmentHistoryUseCase(
              appointmentRepository: appointmentRepository),
          currentShiftUseCase: CurrentShiftUseCase(
              appointmentRepository: appointmentRepository)),
    );
    Get.lazyPut(
      () => BookAppointmentController(
          fetchAllTokenStatusesUseCase: FetchAllTokenStatusesUseCase(
              tokenBookingRepository: tokenBookingRepository),
          reserveTokenUseCase: ReserveTokenUseCase(
              tokenBookingRepository: tokenBookingRepository), currentShiftUseCase: CurrentShiftUseCase(appointmentRepository: appointmentRepository)),
    );
    Get.lazyPut(() => DoctorDashboardController(
        loginUserDetailsUseCase:
            LoginUserDetailsUseCase(userRepository: userRepository),
        currentTokenUseCase:
            CurrentTokenUseCase(tokenBookingRepository: tokenBookingRepository),
        appointmentHistoryUseCase: GetAppointmentHistoryUseCase(
            appointmentRepository: appointmentRepository),
        currentShiftUseCase:
            CurrentShiftUseCase(appointmentRepository: appointmentRepository)));
    Get.lazyPut(() => CheckingProcessController(fetchAllTokenStatusesUseCase: FetchAllTokenStatusesUseCase(tokenBookingRepository: tokenBookingRepository), checkedTokenUseCase: CheckedTokenUseCase(tokenBookingRepository: tokenBookingRepository)));
    Get.lazyPut(() => SettingController());
  }
}
