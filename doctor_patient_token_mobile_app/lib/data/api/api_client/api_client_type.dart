import 'package:dio/dio.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/add_prescription_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/appointment_history_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/change_email_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/change_phone_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/checked_patient_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/create_password_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/login_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/reserve_token_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/sign_up_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/token_details_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/update_time_setting_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/add_prescription_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/appointment_history_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/change_email_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/change_phone_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/create_password_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/current_shift_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/current_token_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/login_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/resend_otp_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/reserve_token_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/sign_up_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/start_check_up_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/token_details_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/update_time_setting_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/user_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/retrofit.dart' as retrofit;

import '../request/forgot_password_request.dart';
import '../request/otp_verification_request.dart';
import '../request/resend_otp_request.dart';
import '../response/base_response.dart';
import '../response/fetch_token_status_response.dart';
import '../response/forgot_password_response.dart';
import '../response/otp_verification_response.dart';

part 'api_client_type.g.dart';

@retrofit.RestApi()
abstract class APIClientType {
  factory APIClientType(Dio dio, {String baseUrl}) = _APIClientType;

  @retrofit.POST('/api/signup')
  Future<BaseResponse<SignUpResponse>> signUp(
    @retrofit.Body() SignUpRequest request,
  );

  @retrofit.POST('/api/otp-verification')
  Future<BaseResponse<OTPVerificationResponse>> otpVerification(
    @retrofit.Body() OPTVerificationRequest request,
  );

  @retrofit.POST('/api/create-new-password')
  Future<BaseResponse<CreatePasswordResponse>> createPassword(
    @retrofit.Body() CreatePasswordRequest request,
  );

  @retrofit.POST('/api/login')
  Future<BaseResponse<LoginResponse>> login(
    @retrofit.Body() LoginRequest request,
  );

  @retrofit.POST('/api/forgot-password-request')
  Future<BaseResponse<ForgotPasswordResponse>> forgotPassword(
    @retrofit.Body() ForgotPasswordRequest request,
  );

  @retrofit.POST('/api/resend-otp')
  Future<BaseResponse<ResendOtpResponse>> resendOtp(
    @retrofit.Body() ResendOtpRequest request,
  );

  @retrofit.POST('/api/get-login-user')
  Future<BaseResponse<UserResponse>> getLoginUserDetails();

  @retrofit.POST('/api/current-token')
  Future<BaseResponse<CurrentTokenResponse>> getCurrentToken();

  @retrofit.POST('/api/get-appointments')
  Future<BasePagingResponse<AppointmentHistoryResponse>> getAppointmentHistory(
    @retrofit.Body() AppointmentHistoryRequest request,
  );

  @retrofit.POST('/api/fetch-all-token-status')
  Future<BaseResponse<FetchTokenStatusResponse>> getAllTokenStatuses();

  @retrofit.POST('/api/reserve-token')
  Future<BaseResponse<ReserveTokenResponse>> reserveToken(
      @retrofit.Body() ReserveTokenRequest request);

  @retrofit.POST('/api/change-email')
  Future<BaseResponse<ChangeEmailResponse>> changeEmail(
      @retrofit.Body() ChangeEmailRequest request);

  @retrofit.POST('/api/change-mobile-number')
  Future<BaseResponse<ChangePhoneResponse>> changePhone(
      @retrofit.Body() ChangePhoneRequest request);

  @retrofit.POST('/api/get-token-details')
  Future<BaseResponse<TokenDetailsResponse>> getTokenDetails(
      @retrofit.Body() TokenDetailsRequest request);

  @retrofit.POST('/api/add-prescription')
  Future<BaseResponse<AddPrescriptionResponse>> uploadPrescription(
      @retrofit.Body() AddPrescriptionRequest request);

  @retrofit.POST('/api/current-shift')
  Future<BaseResponse<CurrentShiftResponse>> currentShift();

  @retrofit.POST('/api/patient-checked-status')
  Future<BaseResponse> checkedPatient(
      @retrofit.Body() CheckedPatientRequest request);

  @retrofit.POST('/api/general-settings')
  Future<BaseResponse<UpdateTimeSettingResponse>> updateTimeSettings(
      @retrofit.Body() UpdateTimeSettingRequest request);

  @retrofit.POST('/api/checkup-start')
  Future<BaseResponse<StartCheckUpResponse>> startCheckup();

}
