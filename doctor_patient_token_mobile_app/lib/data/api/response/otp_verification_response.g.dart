// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPVerificationResponse _$OTPVerificationResponseFromJson(
        Map<String, dynamic> json) =>
    OTPVerificationResponse(
      verificationToken: json['verification_token'] as String?,
    );

Map<String, dynamic> _$OTPVerificationResponseToJson(
        OTPVerificationResponse instance) =>
    <String, dynamic>{
      'verification_token': instance.verificationToken,
    };
