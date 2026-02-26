import 'package:json_annotation/json_annotation.dart';

part 'update_time_setting_response.g.dart';

@JsonSerializable()
class UpdateTimeSettingResponse {
  @JsonKey(name: "settings")
  final Settings settings;

  UpdateTimeSettingResponse({
    required this.settings,
  });

  factory UpdateTimeSettingResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateTimeSettingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTimeSettingResponseToJson(this);
}

@JsonSerializable()
class Settings {
  @JsonKey(name: 'morning_shift_start_time')
  final String morningShiftStartTime;

  @JsonKey(name: 'morning_shift_end_time')
  final String morningShiftEndTime;

  @JsonKey(name: 'evening_shift_start_time')
  final String eveningShiftStartTime;

  @JsonKey(name: 'evening_shift_end_time')
  final String eveningShiftEndTime;

  @JsonKey(name: 'max_tokens')
  final String maxTokens;

  @JsonKey(name: 'patient_fee')
  final String patientFee;

  @JsonKey(name: 'token_id')
  final String? tokenId;

  @JsonKey(name: 'shift_disable_pattern')
  final String? shiftDisablePattern;


  Settings(
      {required this.morningShiftStartTime,
      required this.morningShiftEndTime,
      required this.eveningShiftStartTime,
      required this.eveningShiftEndTime,
      required this.maxTokens,
      required this.patientFee,
        this.tokenId,
      this.shiftDisablePattern
      });

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}
