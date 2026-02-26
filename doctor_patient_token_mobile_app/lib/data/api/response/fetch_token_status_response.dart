import 'package:json_annotation/json_annotation.dart';

part 'fetch_token_status_response.g.dart';

@JsonSerializable()
class FetchTokenStatusResponse {
  final List<TokenStatusResponse> tokens;
  final String shift;
  final String date;
  final String day;

  FetchTokenStatusResponse(
      {required this.tokens,
      required this.shift,
      required this.date,
      required this.day});

  factory FetchTokenStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$FetchTokenStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FetchTokenStatusResponseToJson(this);
}

@JsonSerializable()
class TokenStatusResponse {
  @JsonKey(name: 'token_id')
  final int tokenId;

  @JsonKey(name: 'number')
  final int number;

  @JsonKey(name: 'own_token')
  final bool ownToken;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'number_of_patient')
  final int numberOfPatients;

  TokenStatusResponse(
      {required this.number,
      required this.tokenId,
      required this.status,
      required this.numberOfPatients,
      required this.ownToken});

  factory TokenStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenStatusResponseToJson(this);
}
