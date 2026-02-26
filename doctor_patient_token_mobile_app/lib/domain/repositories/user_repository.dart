import 'package:doctor_patient_token_mobile_app/data/api/request/change_phone_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/update_time_setting_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/change_email_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/change_phone_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/update_setting_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/user_entity.dart';

import '../../data/api/request/change_email_request.dart';

abstract class UserRepository {

  Future<UserEntity> getLoginUserDetails();

  Future<ChangeEmailEntity> changeEmail(ChangeEmailRequest request);

  Future<ChangePhoneEntity> changePhone(ChangePhoneRequest request);

  Future<UpdateSettingEntity> updateSetting(UpdateTimeSettingRequest request);

}
