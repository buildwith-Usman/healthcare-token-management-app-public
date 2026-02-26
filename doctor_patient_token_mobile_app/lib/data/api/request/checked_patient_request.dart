import 'package:json_annotation/json_annotation.dart';

part 'checked_patient_request.g.dart';

@JsonSerializable()
class CheckedPatientRequest {
  @JsonKey(name: "token_id")
  final String tokenId;

  @JsonKey(name: "status")
  final String status;

  CheckedPatientRequest({
    required this.tokenId,
    required this.status,
  });

  // Factory method for JSON deserialization
  factory CheckedPatientRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckedPatientRequestFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$CheckedPatientRequestToJson(this);
}
