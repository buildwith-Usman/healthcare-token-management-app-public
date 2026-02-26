import 'package:doctor_patient_token_mobile_app/data/api/request/appointment_history_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/appointment_history_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/appointment_repository.dart';

import 'base_usecase.dart';

class GetAppointmentHistoryUseCase implements ParamUseCase<AppointmentHistoryPagingEntity?, AppointmentHistoryRequest> {
  final AppointmentRepository appointmentRepository;

  GetAppointmentHistoryUseCase({required this.appointmentRepository});

  @override
  Future<AppointmentHistoryPagingEntity?> execute(AppointmentHistoryRequest params) async {
    final appointmentHistoryEntity = await appointmentRepository.getAppointmentHistory(params);
    return appointmentHistoryEntity;
  }

}
