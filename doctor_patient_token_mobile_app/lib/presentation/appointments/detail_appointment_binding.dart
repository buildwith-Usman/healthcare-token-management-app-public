import 'package:doctor_patient_token_mobile_app/domain/usecase/get_appointment_details_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/upload_prescription_use_case.dart';
import 'package:doctor_patient_token_mobile_app/presentation/appointments/detail_appointment_controller.dart';
import 'package:get/get.dart';

import '../../di/client_module.dart';
import '../../di/config_module.dart';
import '../../di/datasource_module.dart';
import '../../di/repository_module.dart';

class DetailAppointmentBinding extends Bindings with ClientModule, DatasourceModule, RepositoryModule, ConfigModule {
  @override
  void dependencies() {
    Get.lazyPut(()=> DetailAppointmentController(getAppointmentDetailsUseCase: GetAppointmentDetailsUseCase(appointmentRepository: appointmentRepository), uploadPrescriptionUseCase: UploadPrescriptionUseCase(appointmentRepository: appointmentRepository)));
  }

}