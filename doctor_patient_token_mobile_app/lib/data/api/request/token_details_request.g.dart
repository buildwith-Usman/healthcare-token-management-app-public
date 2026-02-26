// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_details_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenDetailsRequest _$TokenDetailsRequestFromJson(Map<String, dynamic> json) =>
    TokenDetailsRequest(
      tokenId: (json['token_id'] as num).toInt(),
    );

Map<String, dynamic> _$TokenDetailsRequestToJson(
        TokenDetailsRequest instance) =>
    <String, dynamic>{
      'token_id': instance.tokenId,
    };
