// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResendOtpRequest _$ResendOtpRequestFromJson(Map<String, dynamic> json) =>
    ResendOtpRequest(
      verificationToken: json['verification_token'] as String? ?? '',
    );

Map<String, dynamic> _$ResendOtpRequestToJson(ResendOtpRequest instance) =>
    <String, dynamic>{
      'verification_token': instance.verificationToken,
    };
