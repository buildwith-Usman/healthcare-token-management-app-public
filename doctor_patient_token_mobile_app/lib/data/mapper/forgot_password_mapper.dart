import 'package:doctor_patient_token_mobile_app/data/api/response/forgot_password_response.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/forgot_password_entity.dart';

class ForgotPasswordMapper {
  static ForgotPasswordEntity toForgotPasswordEntity(ForgotPasswordResponse response) {
    return ForgotPasswordEntity(
      verificationToken: response.verificationToken ?? '',
    );
  }
}
