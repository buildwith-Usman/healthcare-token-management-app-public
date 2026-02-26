import 'package:json_annotation/json_annotation.dart';

part 'change_email_request.g.dart';

@JsonSerializable()
class ChangeEmailRequest {
  @JsonKey(name: "email")
  final String email;

  ChangeEmailRequest({
    required this.email,
  });

  // Factory method for JSON deserialization
  factory ChangeEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangeEmailRequestFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$ChangeEmailRequestToJson(this);
}
