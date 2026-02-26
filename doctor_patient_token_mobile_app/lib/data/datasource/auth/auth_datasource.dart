import 'package:doctor_patient_token_mobile_app/data/api/request/create_password_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/login_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/sign_up_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/create_password_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/login_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/otp_verification_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/sign_up_response.dart';

import '../../api/request/forgot_password_request.dart';
import '../../api/request/otp_verification_request.dart';
import '../../api/request/resend_otp_request.dart';
import '../../api/response/forgot_password_response.dart';
import '../../api/response/resend_otp_response.dart';

abstract class AuthDatasource {

  Future<SignUpResponse?> signUp(SignUpRequest signUpRequest);

  Future<OTPVerificationResponse?> otpVerification(OPTVerificationRequest otpVerificationRequest);

  Future<CreatePasswordResponse?> createPassword(CreatePasswordRequest createPasswordRequest);

  Future<LoginResponse?> login(LoginRequest loginRequest);

  Future<ForgotPasswordResponse?> forgotPassword(ForgotPasswordRequest request);

  Future<ResendOtpResponse?> resendOtp(ResendOtpRequest resendOtpRequest);

  Future<LoginResponse?> loginWithGoogle();

}