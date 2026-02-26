// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserve_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReserveTokenResponse _$ReserveTokenResponseFromJson(
        Map<String, dynamic> json) =>
    ReserveTokenResponse(
      shift: json['shift'] as String?,
      date: json['date'] as String?,
      tokenId: (json['token_id'] as num).toInt(),
      status: json['status'] as String?,
      paymentLink: json['payment_link'] as String?,
    );

Map<String, dynamic> _$ReserveTokenResponseToJson(
        ReserveTokenResponse instance) =>
    <String, dynamic>{
      'shift': instance.shift,
      'date': instance.date,
      'token_id': instance.tokenId,
      'status': instance.status,
      'payment_link': instance.paymentLink,
    };
