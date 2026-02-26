import 'package:json_annotation/json_annotation.dart';

part 'change_phone_response.g.dart';

@JsonSerializable()
class ChangePhoneResponse {
  @JsonKey(name: "updated")
  final bool updated;

  ChangePhoneResponse({
    required this.updated,
  });

  // Factory method for JSON deserialization
  factory ChangePhoneResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePhoneResponseFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$ChangePhoneResponseToJson(this);
}
