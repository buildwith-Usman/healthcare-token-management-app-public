// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_time_setting_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTimeSettingRequest _$UpdateTimeSettingRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateTimeSettingRequest(
      morningShiftStartTime: json['morning_shift_start_time'] as String?,
      morningShiftEndTime: json['morning_shift_end_time'] as String?,
      eveningShiftStartTime: json['evening_shift_start_time'] as String?,
      eveningShiftEndTime: json['evening_shift_end_time'] as String?,
      shiftDisablePattern: json['shift_disable_pattern'] as String?,
    );

Map<String, dynamic> _$UpdateTimeSettingRequestToJson(
        UpdateTimeSettingRequest instance) =>
    <String, dynamic>{
      if (instance.morningShiftStartTime case final value?)
        'morning_shift_start_time': value,
      if (instance.morningShiftEndTime case final value?)
        'morning_shift_end_time': value,
      if (instance.eveningShiftStartTime case final value?)
        'evening_shift_start_time': value,
      if (instance.eveningShiftEndTime case final value?)
        'evening_shift_end_time': value,
      if (instance.shiftDisablePattern case final value?)
        'shift_disable_pattern': value,
    };
