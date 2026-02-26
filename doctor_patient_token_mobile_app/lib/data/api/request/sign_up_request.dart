import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request.g.dart';

@JsonSerializable()
class SignUpRequest {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'phone')
  final String phone;

  SignUpRequest({
    this.name = '',
    this.email = '',
    this.phone = '',
  });

  // Factory method for JSON deserialization
  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);

}
