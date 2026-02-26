import 'package:dio/dio.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/add_prescription_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/appointment_history_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/token_details_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/add_prescription_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/appointment_history_response.dart';

import 'package:doctor_patient_token_mobile_app/data/api/response/base_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/current_shift_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/token_details_response.dart';

import '../../api/api_client/api_client_type.dart';
import '../../api/response/error_response.dart';
import 'appointment_datasource.dart';

class AppointmentDatasourceImpl implements AppointmentDatasource {
  AppointmentDatasourceImpl({
    required this.apiClient,
  });

  final APIClientType apiClient;

  @override
  Future<BasePagingResponse<AppointmentHistoryResponse>?> getAppointmentHistory(AppointmentHistoryRequest request) async {
    try {
      final response =
          await apiClient.getAppointmentHistory(request);
      return response;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<TokenDetailsResponse?> getAppointmentDetails(TokenDetailsRequest request) async {
    try {
      final response = await apiClient.getTokenDetails(request);
      final appointmentDetailsResponse = response.data;
      return appointmentDetailsResponse;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<AddPrescriptionResponse?> uploadPrescription(AddPrescriptionRequest request) async {
    try {
      final response = await apiClient.uploadPrescription(request);
      final addPrescriptionResponse = response.data;
      return addPrescriptionResponse;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }

  @override
  Future<CurrentShiftResponse?> currentShift() async {
    try {
      final response = await apiClient.currentShift();
      final currentShiftResponse = response.data;
      return currentShiftResponse;
    } on DioException catch (error) {
      throw BaseErrorResponse.handleErrorResponse(error);
    }
  }


}
