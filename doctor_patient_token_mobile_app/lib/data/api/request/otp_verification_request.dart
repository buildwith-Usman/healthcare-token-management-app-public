import 'package:json_annotation/json_annotation.dart';

part 'otp_verification_request.g.dart';

@JsonSerializable()
class OPTVerificationRequest {

  @JsonKey(name: 'verification_token')
  final String verificationToken;

  @JsonKey(name: 'code')
  final String code;

  OPTVerificationRequest({
    this.verificationToken = '',
    this.code = '',
  });

  // Factory method for JSON deserialization
  factory OPTVerificationRequest.fromJson(Map<String, dynamic> json) =>
      _$OPTVerificationRequestFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$OPTVerificationRequestToJson(this);

}
