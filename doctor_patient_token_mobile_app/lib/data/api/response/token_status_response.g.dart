// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenStatusResponse _$TokenStatusResponseFromJson(Map<String, dynamic> json) =>
    TokenStatusResponse(
      status: (json['status'] as num?)?.toInt(),
      statusArr: (json['statusArr'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TokenStatusResponseToJson(
        TokenStatusResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'statusArr': instance.statusArr,
    };
