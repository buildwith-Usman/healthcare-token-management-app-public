import 'package:doctor_patient_token_mobile_app/data/api/response/token_details_response.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/patient_detail_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/token_details_entity.dart';


class AppointmentDetailsMapper {
  static TokenDetailsEntity toAppointmentDetailsEntity(TokenDetailsResponse tokenDetailsResponse) {
    return TokenDetailsEntity(
     patientsList: tokenDetailsResponse.patients
         .map((patient) => PatientDetailsEntity(
       patientId: patient.patientId,
        patientName: patient.name,
        patientAge: patient.age,
       patientGender: patient.gender,
       prescription: patient.prescription

     ))
         .toList(),
      numberOfPatients: tokenDetailsResponse.numberOfPatient,
      tokenNumber: tokenDetailsResponse.tokenNumber,
      tokenShift: tokenDetailsResponse.shift,
      tokenBookedDate: tokenDetailsResponse.date,
      status: tokenDetailsResponse.status,
      appointmentId: tokenDetailsResponse.id.toString(),
    );
  }
}
