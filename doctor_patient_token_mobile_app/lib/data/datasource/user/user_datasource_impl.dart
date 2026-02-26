import 'package:dio/dio.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/change_email_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/change_phone_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/update_time_setting_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/change_email_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/change_phone_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/update_time_setting_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/user_response.dart';
import 'package:doctor_patient_token_mobile_app/data/datasource/user/user_datasource.dart';

import '../../api/api_client/api_client_type.dart';
import '../../api/response/error_response.dart';

class UserDatasourceImpl implements UserDatasource {
  UserDatasourceImpl({
    required this.apiClient,
  });

  final APIClientType apiClient;

  @override
  Future<UserResponse?> getLoginUserDetails() async {
    try {
      final response = await apiClient.getLoginUserDetails();
      final userResponse = response.data;
      return userResponse;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<ChangeEmailResponse?> changeEmail(ChangeEmailRequest request) async {
    try {
      final response = await apiClient.changeEmail(request);
      final changeEmailResponse = response.data;
      return changeEmailResponse;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<ChangePhoneResponse?> changePhone(ChangePhoneRequest request) async {
    try {
      final response = await apiClient.changePhone(request);
      final changePhoneResponse = response.data;
      return changePhoneResponse;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<UpdateTimeSettingResponse?> updateSettings(UpdateTimeSettingRequest request) async {
    try {
      final response = await apiClient.updateTimeSettings(request);
      final updateTimeSettingResponse = response.data;
      return updateTimeSettingResponse;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }
}
