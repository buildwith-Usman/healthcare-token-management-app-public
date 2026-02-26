

import 'package:doctor_patient_token_mobile_app/domain/usecase/current_shift_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/current_token_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/login_user_details_use_case.dart';
import 'package:doctor_patient_token_mobile_app/presentation/patient_dashboard/patient_dashboard_controller.dart';
import 'package:get/get.dart';

import '../../di/client_module.dart';
import '../../di/config_module.dart';
import '../../di/datasource_module.dart';
import '../../di/repository_module.dart';
import '../../domain/usecase/get_appointment_history_use_case.dart';

class PatientDashboardBinding  extends Bindings with ClientModule, DatasourceModule, RepositoryModule, ConfigModule {
  @override
  void dependencies() {
    Get.lazyPut(() =>  PatientDashboardController(loginUserDetailsUseCase: LoginUserDetailsUseCase(userRepository: userRepository), currentTokenUseCase: CurrentTokenUseCase(tokenBookingRepository: tokenBookingRepository), appointmentHistoryUseCase: GetAppointmentHistoryUseCase(appointmentRepository: appointmentRepository), currentShiftUseCase: CurrentShiftUseCase(appointmentRepository: appointmentRepository)));
  }
}
