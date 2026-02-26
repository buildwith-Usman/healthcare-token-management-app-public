import 'package:doctor_patient_token_mobile_app/data/api/request/add_prescription_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/appointment_history_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/token_details_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/add_prescription_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/appointment_history_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/current_shift_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/token_details_response.dart';

import '../../api/response/base_response.dart';

abstract class AppointmentDatasource {
  Future<BasePagingResponse<AppointmentHistoryResponse>?> getAppointmentHistory(
    AppointmentHistoryRequest request,
  );

  Future<TokenDetailsResponse?> getAppointmentDetails(
    TokenDetailsRequest request,
  );

  Future<AddPrescriptionResponse?> uploadPrescription(
    AddPrescriptionRequest request,
  );

  Future<CurrentShiftResponse?> currentShift();
}
