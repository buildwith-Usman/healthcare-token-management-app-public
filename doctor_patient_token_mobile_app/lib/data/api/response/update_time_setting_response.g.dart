// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_time_setting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTimeSettingResponse _$UpdateTimeSettingResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateTimeSettingResponse(
      settings: Settings.fromJson(json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateTimeSettingResponseToJson(
        UpdateTimeSettingResponse instance) =>
    <String, dynamic>{
      'settings': instance.settings,
    };

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      morningShiftStartTime: json['morning_shift_start_time'] as String,
      morningShiftEndTime: json['morning_shift_end_time'] as String,
      eveningShiftStartTime: json['evening_shift_start_time'] as String,
      eveningShiftEndTime: json['evening_shift_end_time'] as String,
      maxTokens: json['max_tokens'] as String,
      patientFee: json['patient_fee'] as String,
      tokenId: json['token_id'] as String?,
      shiftDisablePattern: json['shift_disable_pattern'] as String?,
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'morning_shift_start_time': instance.morningShiftStartTime,
      'morning_shift_end_time': instance.morningShiftEndTime,
      'evening_shift_start_time': instance.eveningShiftStartTime,
      'evening_shift_end_time': instance.eveningShiftEndTime,
      'max_tokens': instance.maxTokens,
      'patient_fee': instance.patientFee,
      'token_id': instance.tokenId,
      'shift_disable_pattern': instance.shiftDisablePattern,
    };
