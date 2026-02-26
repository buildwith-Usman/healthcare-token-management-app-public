import 'package:doctor_patient_token_mobile_app/data/api/response/change_phone_response.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/change_phone_entity.dart';

class ChangePhoneMapper {
  static ChangePhoneEntity toChangePhoneEntity(
      ChangePhoneResponse changePhoneResponse) {
    return ChangePhoneEntity(
      updated: changePhoneResponse.updated,
    );
  }
}
