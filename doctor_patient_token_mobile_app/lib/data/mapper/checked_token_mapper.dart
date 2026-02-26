import 'package:doctor_patient_token_mobile_app/domain/entity/checked_token_entity.dart';

class CheckedTokenMapper {
  static CheckedTokenEntity toCheckedTokenEntity(String checkPatientResponse) {
    return CheckedTokenEntity(
      status: checkPatientResponse,
    );
  }
}