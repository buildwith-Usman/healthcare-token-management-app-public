
import 'package:doctor_patient_token_mobile_app/data/api/request/add_prescription_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/token_details_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/current_shift_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/token_details_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/upload_prescription_entity.dart';

import '../../data/api/request/appointment_history_request.dart';
import '../entity/appointment_history_entity.dart';

abstract class AppointmentRepository {

  Future<AppointmentHistoryPagingEntity> getAppointmentHistory(AppointmentHistoryRequest request);

  Future<TokenDetailsEntity?> getAppointmentDetails(TokenDetailsRequest request);

  Future<UploadPrescriptionEntity?> uploadPrescription(AddPrescriptionRequest request);

  Future<CurrentShiftEntity?> currentShift();


}
