import 'package:json_annotation/json_annotation.dart';

part 'change_phone_request.g.dart';

@JsonSerializable()
class ChangePhoneRequest {
  @JsonKey(name: "phone")
  final String phone;

  ChangePhoneRequest({
    required this.phone,
  });

  // Factory method for JSON deserialization
  factory ChangePhoneRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePhoneRequestFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$ChangePhoneRequestToJson(this);
}
