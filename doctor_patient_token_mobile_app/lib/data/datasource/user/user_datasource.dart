import 'package:doctor_patient_token_mobile_app/data/api/request/change_phone_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/update_time_setting_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/change_email_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/change_phone_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/update_time_setting_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/user_response.dart';

import '../../api/request/change_email_request.dart';

abstract class UserDatasource {

  Future<UserResponse?> getLoginUserDetails();

  Future<ChangeEmailResponse?> changeEmail(ChangeEmailRequest request);

  Future<ChangePhoneResponse?> changePhone(ChangePhoneRequest request);

  Future<UpdateTimeSettingResponse?> updateSettings(UpdateTimeSettingRequest request);

}