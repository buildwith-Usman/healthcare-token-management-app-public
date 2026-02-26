import 'package:doctor_patient_token_mobile_app/data/api/response/update_time_setting_response.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/update_setting_entity.dart';


class UpdateSettingsMapper {
  static UpdateSettingEntity toUpdateSettingsEntity(UpdateTimeSettingResponse updateTimeSettingsResponse) {
    return UpdateSettingEntity(
      shift:'',
      shiftDate: '',
      morningShiftStartTime: updateTimeSettingsResponse.settings.morningShiftStartTime,
      morningShiftEndTime: updateTimeSettingsResponse.settings.morningShiftEndTime,
      eveningShiftStartTime: updateTimeSettingsResponse.settings.eveningShiftStartTime,
      eveningShiftEndTime: updateTimeSettingsResponse.settings.eveningShiftEndTime,
      shiftDisablePattern: updateTimeSettingsResponse.settings.shiftDisablePattern
    );
  }
}