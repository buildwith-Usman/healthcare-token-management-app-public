// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OPTVerificationRequest _$OPTVerificationRequestFromJson(
        Map<String, dynamic> json) =>
    OPTVerificationRequest(
      verificationToken: json['verification_token'] as String? ?? '',
      code: json['code'] as String? ?? '',
    );

Map<String, dynamic> _$OPTVerificationRequestToJson(
        OPTVerificationRequest instance) =>
    <String, dynamic>{
      'verification_token': instance.verificationToken,
      'code': instance.code,
    };
