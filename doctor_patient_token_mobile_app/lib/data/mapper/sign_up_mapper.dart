import 'package:doctor_patient_token_mobile_app/data/api/response/sign_up_response.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/sign_up_entity.dart';


class SignUpMapper {
  static SignUpEntity toSignUpEntity(SignUpResponse signUpResponse) {
    return SignUpEntity(
      verificationToken: signUpResponse.verificationToken ?? '',
    );
  }
}
