// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_shift_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentShiftResponse _$CurrentShiftResponseFromJson(
        Map<String, dynamic> json) =>
    CurrentShiftResponse(
      shift: json['shift'] as String?,
      date: json['date'] as String?,
      bookingEnable: json['booking_enable'] as bool?,
      userTokenNumber: json['user_token_number'] as String?,
      userTokenStatus: json['user_token_status'] as String?,
      day: json['day'] as String?,
      shiftStatus: json['shift_status'] as String?,
      currentShiftDisable: json['current_shift_disable'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CurrentShiftResponseToJson(
        CurrentShiftResponse instance) =>
    <String, dynamic>{
      'shift': instance.shift,
      'date': instance.date,
      'booking_enable': instance.bookingEnable,
      'user_token_number': instance.userTokenNumber,
      'user_token_status': instance.userTokenStatus,
      'day': instance.day,
      'shift_status': instance.shiftStatus,
      'current_shift_disable': instance.currentShiftDisable,
      'message': instance.message,
    };
