import 'package:doctor_patient_token_mobile_app/data/api/request/create_password_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/login_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/otp_verification_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/sign_up_request.dart';
import 'package:doctor_patient_token_mobile_app/data/datasource/auth/auth_datasource.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/login_mapper.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/create_password_mapper.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/otp_verification_mapper.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/sign_up_mapper.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/create_password_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/login_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/otp_verification_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/sign_up_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/auth_repository.dart';

import '../../domain/entity/error_entity.dart';
import '../../domain/entity/forgot_password_entity.dart';
import '../../domain/entity/resend_otp_entity.dart';
import '../api/request/forgot_password_request.dart';
import '../api/request/resend_otp_request.dart';
import '../api/response/error_response.dart';
import '../mapper/exception_mapper.dart';
import '../mapper/forgot_password_mapper.dart';
import '../mapper/resend_otp_mapper.dart';


class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required this.authDatasource});

  final AuthDatasource authDatasource;

  @override
  Future<SignUpEntity> signUp(SignUpRequest signUpRequest) async {
    try {
      final response = await authDatasource.signUp(signUpRequest);
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final signUpEntity = SignUpMapper.toSignUpEntity(response);
        return signUpEntity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

  @override
  Future<OtpVerificationEntity> otpVerification(OPTVerificationRequest otpVerificationRequest) async {
    try {
      final response = await authDatasource.otpVerification(otpVerificationRequest);
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final otpVerificationEntity = OtpVerificationMapper.toOtpVerificationMapper(response);
        return otpVerificationEntity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

  @override
  Future<CreatePasswordEntity> createPassword(CreatePasswordRequest createPasswordRequest) async {
    try {
      final response = await authDatasource.createPassword(createPasswordRequest);
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final createPasswordEntity = CreatePasswordMapper.toCreateNewPasswordEntity(response);
        return createPasswordEntity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

  @override
  Future<LoginEntity> login(LoginRequest loginRequest) async {
    try {
      final response = await authDatasource.login(loginRequest);
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final loginEntity = LoginMapper.toLoginEntity(response);
        return loginEntity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

  @override
  Future<ForgotPasswordEntity> forgotPassword(ForgotPasswordRequest forgotPasswordRequest) async {
    try {
      final response = await authDatasource.forgotPassword(forgotPasswordRequest);
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final forgotPasswordEntity = ForgotPasswordMapper.toForgotPasswordEntity(response);
        return forgotPasswordEntity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

  @override
  Future<ResendOtpEntity> resendOtp(ResendOtpRequest resendOtpRequest) async {
    try {
      final response = await authDatasource.resendOtp(resendOtpRequest);
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final entity = ResendOtpMapper.toResendOtpEntity(response);
        return entity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

  @override
  Future<LoginEntity> loginWithGoogle() async {
    try {
      final response = await authDatasource.loginWithGoogle();
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final entity = LoginMapper.toLoginEntity(response);
        return entity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

}
