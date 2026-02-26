import 'package:doctor_patient_token_mobile_app/data/api/request/create_password_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/login_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/sign_up_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/create_password_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/otp_verification_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/sign_up_entity.dart';

import '../../data/api/request/forgot_password_request.dart';
import '../../data/api/request/otp_verification_request.dart';
import '../../data/api/request/resend_otp_request.dart';
import '../entity/forgot_password_entity.dart';
import '../entity/login_entity.dart';
import '../entity/resend_otp_entity.dart';

abstract class AuthRepository {

  Future<SignUpEntity> signUp(SignUpRequest signUpRequest);

  Future<OtpVerificationEntity> otpVerification(OPTVerificationRequest otpVerificationRequest);

  Future<CreatePasswordEntity> createPassword(CreatePasswordRequest createNewPasswordRequest);

  Future<LoginEntity> login(LoginRequest loginRequest);

  Future<ForgotPasswordEntity> forgotPassword(ForgotPasswordRequest request);

  Future<ResendOtpEntity> resendOtp(ResendOtpRequest resendOtpRequest);

  Future<LoginEntity> loginWithGoogle();

}
