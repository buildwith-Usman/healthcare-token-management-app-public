import 'package:doctor_patient_token_mobile_app/data/api/request/token_details_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/token_details_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/appointment_repository.dart';

import 'base_usecase.dart';

class GetAppointmentDetailsUseCase implements ParamUseCase<TokenDetailsEntity?, TokenDetailsRequest> {
  final AppointmentRepository appointmentRepository;

  GetAppointmentDetailsUseCase({required this.appointmentRepository});

  @override
  Future<TokenDetailsEntity?> execute(TokenDetailsRequest params) async {
    final appointmentDetailsEntity = await appointmentRepository.getAppointmentDetails(params);
    return appointmentDetailsEntity;
  }

}
