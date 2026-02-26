import 'package:json_annotation/json_annotation.dart';

part 'sign_up_response.g.dart';

@JsonSerializable()
class SignUpResponse {

  @JsonKey(name: 'verification_token')
  final String verificationToken;

  SignUpResponse({
    required this.verificationToken
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

}
