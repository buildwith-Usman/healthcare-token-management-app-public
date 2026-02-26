import 'package:json_annotation/json_annotation.dart';

part 'token_details_request.g.dart';

@JsonSerializable()
class TokenDetailsRequest {
  @JsonKey(name: "token_id")
  final int tokenId;

  TokenDetailsRequest({
    required this.tokenId,
  });

  // Factory method for JSON deserialization
  factory TokenDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenDetailsRequestFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$TokenDetailsRequestToJson(this);
}
