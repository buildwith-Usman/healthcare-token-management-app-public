import 'package:json_annotation/json_annotation.dart';

part 'otp_verification_response.g.dart';

@JsonSerializable()
class OTPVerificationResponse {

  @JsonKey(name: 'verification_token')
  final String? verificationToken;

  OTPVerificationResponse({
    required this.verificationToken
  });

  factory OTPVerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$OTPVerificationResponseFromJson(json);

}
