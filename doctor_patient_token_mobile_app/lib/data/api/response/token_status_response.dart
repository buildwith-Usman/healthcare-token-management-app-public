import 'package:json_annotation/json_annotation.dart';

part 'token_status_response.g.dart';

@JsonSerializable()
class TokenStatusResponse {
  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'statusArr')
  final List<String>? statusArr;

  TokenStatusResponse({
    required this.status,
    required this.statusArr,
  });

  factory TokenStatusResponse.fromJson(Map<String, dynamic> json) => _$TokenStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenStatusResponseToJson(this);
}
