// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResendOtpResponse _$ResendOtpResponseFromJson(Map<String, dynamic> json) =>
    ResendOtpResponse(
      verificationToken: json['verification_token'] as String?,
    );

Map<String, dynamic> _$ResendOtpResponseToJson(ResendOtpResponse instance) =>
    <String, dynamic>{
      'verification_token': instance.verificationToken,
    };
