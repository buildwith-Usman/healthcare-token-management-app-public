import 'package:doctor_patient_token_mobile_app/data/api/request/add_prescription_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/upload_prescription_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/appointment_repository.dart';

import 'base_usecase.dart';

class UploadPrescriptionUseCase implements ParamUseCase<UploadPrescriptionEntity?, AddPrescriptionRequest> {
  final AppointmentRepository appointmentRepository;

  UploadPrescriptionUseCase({required this.appointmentRepository});

  @override
  Future<UploadPrescriptionEntity?> execute(AddPrescriptionRequest params) async {
    final uploadPrescriptionEntity = await appointmentRepository.uploadPrescription(params);
    return uploadPrescriptionEntity;
  }

}
