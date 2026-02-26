import 'package:json_annotation/json_annotation.dart';

part 'reserve_token_response.g.dart';

@JsonSerializable()
class ReserveTokenResponse {
  @JsonKey(name: 'shift')
  final String? shift;

  @JsonKey(name: 'date')
  final String? date;

  @JsonKey(name: 'token_id')
  final int tokenId;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'payment_link')
  final String? paymentLink;

  ReserveTokenResponse({
    required this.shift,
    required this.date,
    required this.tokenId,
    required this.status,
    required this.paymentLink,
  });

  factory ReserveTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$ReserveTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReserveTokenResponseToJson(this);
}
