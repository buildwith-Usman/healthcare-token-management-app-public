// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_token_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchTokenStatusResponse _$FetchTokenStatusResponseFromJson(
        Map<String, dynamic> json) =>
    FetchTokenStatusResponse(
      tokens: (json['tokens'] as List<dynamic>)
          .map((e) => TokenStatusResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      shift: json['shift'] as String,
      date: json['date'] as String,
      day: json['day'] as String,
    );

Map<String, dynamic> _$FetchTokenStatusResponseToJson(
        FetchTokenStatusResponse instance) =>
    <String, dynamic>{
      'tokens': instance.tokens,
      'shift': instance.shift,
      'date': instance.date,
      'day': instance.day,
    };

TokenStatusResponse _$TokenStatusResponseFromJson(Map<String, dynamic> json) =>
    TokenStatusResponse(
      number: (json['number'] as num).toInt(),
      tokenId: (json['token_id'] as num).toInt(),
      status: json['status'] as String,
      numberOfPatients: (json['number_of_patient'] as num).toInt(),
      ownToken: json['own_token'] as bool,
    );

Map<String, dynamic> _$TokenStatusResponseToJson(
        TokenStatusResponse instance) =>
    <String, dynamic>{
      'token_id': instance.tokenId,
      'number': instance.number,
      'own_token': instance.ownToken,
      'status': instance.status,
      'number_of_patient': instance.numberOfPatients,
    };
