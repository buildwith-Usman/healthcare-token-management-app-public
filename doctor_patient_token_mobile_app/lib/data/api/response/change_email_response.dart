import 'package:json_annotation/json_annotation.dart';

part 'change_email_response.g.dart';

@JsonSerializable()
class ChangeEmailResponse {
  @JsonKey(name: "verification_token")
  final String verificationToken;

  ChangeEmailResponse({
    required this.verificationToken,
  });

  // Factory method for JSON deserialization
  factory ChangeEmailResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangeEmailResponseFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$ChangeEmailResponseToJson(this);
}
