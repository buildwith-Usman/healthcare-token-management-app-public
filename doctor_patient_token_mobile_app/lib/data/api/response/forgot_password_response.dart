import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  @JsonKey(name: 'verification_token')
  final String? verificationToken;

  ForgotPasswordResponse({
    this.verificationToken,
  });

  // Factory method for JSON deserialization
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);

}
