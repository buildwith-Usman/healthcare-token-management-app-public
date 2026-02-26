import 'package:doctor_patient_token_mobile_app/data/api/request/add_prescription_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/token_details_request.dart';
import 'package:doctor_patient_token_mobile_app/data/datasource/appointment/appointment_datasource.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/appointment_details_mapper.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/appointment_history_mapper.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/current_shift_mapper.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/upload_prescription_mapper.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/appointment_history_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/current_shift_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/token_details_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/upload_prescription_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/appointment_repository.dart';

import '../../app/utils/app_connectivity.dart';
import '../../domain/entity/error_entity.dart';
import '../api/request/appointment_history_request.dart';
import '../api/response/error_response.dart';
import '../mapper/exception_mapper.dart';

class AppointmentRepositoryImpl extends AppointmentRepository {
  AppointmentRepositoryImpl({required this.appointmentDatasource});

  final AppointmentDatasource appointmentDatasource;

  @override
  Future<AppointmentHistoryPagingEntity> getAppointmentHistory(AppointmentHistoryRequest request) async {
    if (await AppConnectivity.instance.isInternetAvailable()) {
      try {
        final response =
            await appointmentDatasource.getAppointmentHistory(request);
        if (response?.data == null) {
          throw BaseErrorEntity.noData();
        } else {
          final appointmentHistoryEntity = response?.data
              ?.map(
                  (e) => AppointmentHistoryMapper.toAppointmentHistoryEntity(e))
              .toList();
          // Build pagination info from response if available
          PaginationEntity? pagination;
          if (response?.total != null && response?.pageSize != null) {
            final int total = response!.total!;
            final int perPage = response.pageSize!;
            final int lastPage = (total + perPage - 1) ~/ perPage;
            pagination = PaginationEntity(
              currentPage: response.currentPage,
              lastPage: lastPage,
              perPage: perPage,
              total: total,
            );
          } else if (response?.currentPage != null) {
            pagination = PaginationEntity(currentPage: response!.currentPage);
          }

          return AppointmentHistoryPagingEntity(
            appointmentHistoryEntity: appointmentHistoryEntity ?? [],
            totalAppointments: response?.total ?? 0,
            pagination: pagination,
          );
        }
      } on BaseErrorResponse catch (error) {
        throw ExceptionMapper.toBaseErrorEntity(error);
      }
    } else {
      throw BaseErrorEntity.noNetworkError();
    }
  }

  @override
  Future<TokenDetailsEntity?> getAppointmentDetails(TokenDetailsRequest request) async {
    if (await AppConnectivity.instance.isInternetAvailable()) {
      try {
        final response = await appointmentDatasource.getAppointmentDetails(request);
        if (response == null) {
          throw BaseErrorEntity.noData();
        } else {
          final appointmentTokenDetailsEntity =
          AppointmentDetailsMapper.toAppointmentDetailsEntity(response);
          return appointmentTokenDetailsEntity;
        }
      } on BaseErrorResponse catch (error) {
        throw ExceptionMapper.toBaseErrorEntity(error);
      }
    }else {
      throw BaseErrorEntity.noNetworkError();
    }
  }

  @override
  Future<UploadPrescriptionEntity?> uploadPrescription(AddPrescriptionRequest request) async {
    if (await AppConnectivity.instance.isInternetAvailable()) {
      try {
        final response = await appointmentDatasource.uploadPrescription(request);
        if (response == null) {
          throw BaseErrorEntity.noData();
        } else {
          final uploadPrescriptionEntity =
          UploadPrescriptionMapper.toUploadPrescriptionEntity(response);
          return uploadPrescriptionEntity;
        }
      } on BaseErrorResponse catch (error) {
        throw ExceptionMapper.toBaseErrorEntity(error);
      }
    } else {
      throw BaseErrorEntity.noNetworkError();
    }
  }

  @override
  Future<CurrentShiftEntity?> currentShift() async {
    if (await AppConnectivity.instance.isInternetAvailable()) {
      try {
        final response = await appointmentDatasource.currentShift();
        if (response == null) {
          throw BaseErrorEntity.noData();
        } else {
          final currentShiftEntity =
          CurrentShiftMapper.toCurrentShiftEntity(response);
          return currentShiftEntity;
        }
      } on BaseErrorResponse catch (error) {
        throw ExceptionMapper.toBaseErrorEntity(error);
      }
    } else {
      throw BaseErrorEntity.noNetworkError();
    }
  }
}
