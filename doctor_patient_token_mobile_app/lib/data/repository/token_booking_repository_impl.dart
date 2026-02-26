import 'package:doctor_patient_token_mobile_app/data/api/request/checked_patient_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/reserve_token_request.dart';
import 'package:doctor_patient_token_mobile_app/data/datasource/tokenBooking/token_booking_datasource.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/checked_token_mapper.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/current_token_mapper.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/reserve_token_mapper.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/start_check_up_mapper.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/token_status_mapper.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/checked_token_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/current_token_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/reserve_token_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/start_check_up_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/token_status_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/token_booking_repository.dart';

import '../../domain/entity/error_entity.dart';
import '../api/response/error_response.dart';
import '../mapper/exception_mapper.dart';

class TokenBookingRepositoryImpl extends TokenBookingRepository {
  TokenBookingRepositoryImpl({required this.tokenBookingDatasource});

  final TokenBookingDatasource tokenBookingDatasource;

  @override
  Future<CurrentTokenEntity?> getCurrentToken() async {
    try {
      final response = await tokenBookingDatasource.getCurrentToken();
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final loginEntity = CurrentTokenMapper.toCurrentTokenEntity(response);
        return loginEntity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

  @override
  Future<TokenStatusEntity?> fetchAllTokenStatus() async {
    try {
      final response = await tokenBookingDatasource.fetchAllTokenStatus();
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final tokenStatusesEntity =
            TokenStatusMapper.toTokenStatusEntity(response);
        return tokenStatusesEntity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

  @override
  Future<ReserveTokenEntity?> reserveToken(ReserveTokenRequest request) async {
    try {
      final response = await tokenBookingDatasource.reserveToken(request);
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final reserveTokenEntity =
            ReserveTokenMapper.toReserveTokenEntity(response);
        return reserveTokenEntity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

  @override
  Future<CheckedTokenEntity?> checkedToken(CheckedPatientRequest request) async {
    try {
      final response = await tokenBookingDatasource.checkedToken(request);
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final checkedTokenEntity =
        CheckedTokenMapper.toCheckedTokenEntity(response);
        return checkedTokenEntity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

  @override
  Future<StartCheckUpEntity?> startCheckUp() async {
    try {
      final response = await tokenBookingDatasource.startCheckup();
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final checkedTokenEntity =
        StartCheckUpMapper.toStartCheckUpEntity(response);
        return checkedTokenEntity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

}
