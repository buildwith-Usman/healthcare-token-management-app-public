import 'package:json_annotation/json_annotation.dart';

part 'current_token_response.g.dart';

@JsonSerializable()
class CurrentTokenResponse {
  final String token;

  CurrentTokenResponse({required this.token});

  factory CurrentTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrentTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentTokenResponseToJson(this);
}
