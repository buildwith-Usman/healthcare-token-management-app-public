import 'package:doctor_patient_token_mobile_app/data/api/request/change_phone_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/update_time_setting_request.dart';
import 'package:doctor_patient_token_mobile_app/data/datasource/user/user_datasource.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/change_email_mapper.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/change_phone_mapper.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/login_user_details_mapper.dart';
import 'package:doctor_patient_token_mobile_app/data/mapper/update_settings_mapper.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/change_email_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/change_phone_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/update_setting_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/user_repository.dart';

import '../../domain/entity/error_entity.dart';
import '../../domain/entity/user_entity.dart';
import '../api/request/change_email_request.dart';
import '../api/response/error_response.dart';
import '../mapper/exception_mapper.dart';


class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({required this.userDatasource});

  final UserDatasource userDatasource;

  @override
  Future<UserEntity> getLoginUserDetails() async {
    try {
      final response = await userDatasource.getLoginUserDetails();
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final loginUserEntity = LoginUserDetailsMapper.toUserLoginEntity(response);
        return loginUserEntity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

  @override
  Future<ChangeEmailEntity> changeEmail(ChangeEmailRequest request) async {
    try {
      final response = await userDatasource.changeEmail(request);
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final changeEmailEntity = ChangeEmailMapper.toChangeEmailEntity(response);
        return changeEmailEntity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

  @override
  Future<ChangePhoneEntity> changePhone(ChangePhoneRequest request) async {
    try {
      final response = await userDatasource.changePhone(request);
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final changePhoneEntity = ChangePhoneMapper.toChangePhoneEntity(response);
        return changePhoneEntity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

  @override
  Future<UpdateSettingEntity> updateSetting(UpdateTimeSettingRequest request) async {
    try {
      final response = await userDatasource.updateSettings(request);
      if (response == null) {
        throw BaseErrorEntity.noData();
      } else {
        final updateSettingsEntity = UpdateSettingsMapper.toUpdateSettingsEntity(response);
        return updateSettingsEntity;
      }
    } on BaseErrorResponse catch (error) {
      throw ExceptionMapper.toBaseErrorEntity(error);
    }
  }

}
