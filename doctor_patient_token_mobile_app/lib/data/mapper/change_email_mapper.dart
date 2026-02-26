import 'package:doctor_patient_token_mobile_app/data/api/response/change_email_response.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/change_email_entity.dart';


class ChangeEmailMapper {
  static ChangeEmailEntity toChangeEmailEntity(
      ChangeEmailResponse changeEmailResponse) {
    return ChangeEmailEntity(
      verificationToken: changeEmailResponse.verificationToken,
    );
  }
}
