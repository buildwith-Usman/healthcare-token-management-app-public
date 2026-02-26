import 'package:json_annotation/json_annotation.dart';

part 'resend_otp_response.g.dart';

@JsonSerializable()
class ResendOtpResponse {
  @JsonKey(name: 'verification_token')
  final String? verificationToken;

  ResendOtpResponse({this.verificationToken});

  factory ResendOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$ResendOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResendOtpResponseToJson(this);
}
