import 'package:json_annotation/json_annotation.dart';
import 'user_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'user')
  final UserResponse user;
  @JsonKey(name: 'token')
  final String token;
  @JsonKey(name: 'token_type')
  final String tokenType;

  LoginResponse({
    required this.user,
    required this.token,
    required this.tokenType,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
