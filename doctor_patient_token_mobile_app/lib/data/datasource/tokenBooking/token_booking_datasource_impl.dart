import 'package:dio/dio.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/checked_patient_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/reserve_token_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/current_token_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/fetch_token_status_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/reserve_token_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/start_check_up_response.dart';
import 'package:doctor_patient_token_mobile_app/data/datasource/tokenBooking/token_booking_datasource.dart';
import '../../api/api_client/api_client_type.dart';
import '../../api/response/error_response.dart';

class TokenBookingDatasourceImpl implements TokenBookingDatasource {
  TokenBookingDatasourceImpl({
    required this.apiClient,
  });

  final APIClientType apiClient;

  @override
  Future<CurrentTokenResponse?> getCurrentToken() async {
    try {
      final response = await apiClient.getCurrentToken();
      final currentTokenResponse = response.data;
      return currentTokenResponse;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<FetchTokenStatusResponse?> fetchAllTokenStatus() async {
    try {
      final response = await apiClient.getAllTokenStatuses();
      final allTokenStatuses = response.data;
      return allTokenStatuses;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<ReserveTokenResponse?> reserveToken(ReserveTokenRequest request) async {
    try {
      final response = await apiClient.reserveToken(request);
      final reserveToken = response.data;
      return reserveToken;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<String?> checkedToken(CheckedPatientRequest request) async {
    try {
      final response = await apiClient.checkedPatient(request);
      final checkedPatient = response.message;
      return checkedPatient;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<StartCheckUpResponse?> startCheckup() async {
    try {
      final startCheckUpResponse = await apiClient.startCheckup();
      return startCheckUpResponse.data;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

}
