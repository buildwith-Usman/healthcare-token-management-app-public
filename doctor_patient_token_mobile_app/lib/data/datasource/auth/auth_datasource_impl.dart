import 'package:dio/dio.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/create_password_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/login_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/otp_verification_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/sign_up_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/create_password_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/login_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/otp_verification_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/sign_up_response.dart';
import 'package:doctor_patient_token_mobile_app/data/datasource/auth/auth_datasource.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../api/api_client/api_client_type.dart';
import '../../api/request/forgot_password_request.dart';
import '../../api/request/resend_otp_request.dart';
import '../../api/response/error_response.dart';
import '../../api/response/forgot_password_response.dart';
import '../../api/response/resend_otp_response.dart';

class AuthDatasourceImpl implements AuthDatasource {
  AuthDatasourceImpl({
    required this.unauthenticatedClient,
  });

  final APIClientType unauthenticatedClient;
  final googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: '713375574238-m2alhakotv8k9ie56jlf5b77cmqs6c53.apps.googleusercontent.com',
  );

  @override
  Future<SignUpResponse?> signUp(SignUpRequest signUpRequest) async {
    try {
      final response = await unauthenticatedClient.signUp(signUpRequest);
      final signUpResponse = response.data;
      return signUpResponse;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<OTPVerificationResponse?> otpVerification(
      OPTVerificationRequest otpVerificationRequest) async {
    try {
      final response =
          await unauthenticatedClient.otpVerification(otpVerificationRequest);
      final otpVerificationResponse = response.data;
      return otpVerificationResponse;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<CreatePasswordResponse?> createPassword(
      CreatePasswordRequest createPassword) async {
    try {
      final response =
          await unauthenticatedClient.createPassword(createPassword);
      final createPasswordResponse = response.data;
      return createPasswordResponse;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<LoginResponse?> login(
      LoginRequest loginRequest) async {
    try {
      final response =
      await unauthenticatedClient.login(loginRequest);
      final loginResponse = response.data;
      return loginResponse;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<ForgotPasswordResponse?> forgotPassword(ForgotPasswordRequest request) async {
    try {
      final response = await unauthenticatedClient.forgotPassword(request);
      final forgotPasswordResponse = response.data;
      return forgotPasswordResponse;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<ResendOtpResponse?> resendOtp(ResendOtpRequest resendOtpRequest) async {
    try {
      final response = await unauthenticatedClient.resendOtp(resendOtpRequest);
      return response.data;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<LoginResponse?> loginWithGoogle() async {
    print('Sign-in Google DataSource');
    try {
      final account = await googleSignIn.signIn();
      final auth = await account?.authentication;

      print('ID Token: ${auth?.idToken}');
      print('Access Token: ${auth?.accessToken}');
    } catch (error) {
      print('Sign-in error: $error');
    }
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

}
