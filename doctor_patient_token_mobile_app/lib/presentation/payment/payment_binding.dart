import 'package:doctor_patient_token_mobile_app/domain/usecase/get_appointment_details_use_case.dart';
import 'package:doctor_patient_token_mobile_app/presentation/payment/payment_controller.dart';
import 'package:get/get.dart';

import '../../di/client_module.dart';
import '../../di/config_module.dart';
import '../../di/datasource_module.dart';
import '../../di/repository_module.dart';

class PaymentBinding extends Bindings with ClientModule, DatasourceModule, RepositoryModule, ConfigModule {
  @override
  void dependencies() {
    Get.lazyPut(() =>  PaymentController(getAppointmentDetailsUseCase: GetAppointmentDetailsUseCase(appointmentRepository: appointmentRepository)));
  }
}
