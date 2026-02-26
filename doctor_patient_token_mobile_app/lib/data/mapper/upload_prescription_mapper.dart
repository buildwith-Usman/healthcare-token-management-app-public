import 'package:doctor_patient_token_mobile_app/data/api/response/add_prescription_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/token_details_response.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/patient_detail_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/token_details_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/upload_prescription_entity.dart';


class UploadPrescriptionMapper {
  static UploadPrescriptionEntity toUploadPrescriptionEntity(AddPrescriptionResponse tokenDetailsResponse) {
    return UploadPrescriptionEntity(
      path: tokenDetailsResponse.path,
    );
  }
}
