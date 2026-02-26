import 'package:doctor_patient_token_mobile_app/domain/entity/patient_detail_entity.dart';

class TokenDetailsEntity {
  final List<PatientDetailsEntity>? patientsList;
  final int? numberOfPatients;
  final int? tokenNumber;
  final String? tokenShift;
  final String? tokenBookedDate;
  final String? status;
  final String? appointmentId;

  TokenDetailsEntity({
    this.patientsList,
    this.numberOfPatients,
    this.tokenNumber,
    this.tokenShift,
    this.tokenBookedDate,
    this.status,
    this.appointmentId,
  });
}
