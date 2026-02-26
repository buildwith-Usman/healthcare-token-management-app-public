import 'package:doctor_patient_token_mobile_app/data/api/response/appointment_history_response.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/appointment_history_entity.dart';

class AppointmentHistoryMapper {
  static AppointmentHistoryEntity toAppointmentHistoryEntity(
      AppointmentHistoryResponse appointmentHistoryResponse) {
    return AppointmentHistoryEntity(
      id: appointmentHistoryResponse.id,
      date: appointmentHistoryResponse.date,
      tokenNumber: appointmentHistoryResponse.tokenNumber,
      tokenId: appointmentHistoryResponse.tokenId,
      name: appointmentHistoryResponse.name,
      prescription: appointmentHistoryResponse.prescription,
      status: appointmentHistoryResponse.status,
      numberOfPatients: appointmentHistoryResponse.numberOfPatient,
      shift: appointmentHistoryResponse.shift,
      type: appointmentHistoryResponse.type
    );
  }
}
