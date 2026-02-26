import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final int id;
  final String name;
  final String email;
  final String status;
  final String level;
  final String phone;

  UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.level,
    required this.phone,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
