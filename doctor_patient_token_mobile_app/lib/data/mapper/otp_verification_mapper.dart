import 'package:doctor_patient_token_mobile_app/data/api/response/otp_verification_response.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/otp_verification_entity.dart';


class OtpVerificationMapper {
  static OtpVerificationEntity toOtpVerificationMapper(OTPVerificationResponse otpVerificationResponse) {
    return OtpVerificationEntity(
      verificationToken: otpVerificationResponse.verificationToken ?? '',
    );
  }
}
