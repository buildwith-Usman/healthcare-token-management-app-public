import 'package:json_annotation/json_annotation.dart';

part 'checked_patient_response.g.dart';

@JsonSerializable()
class CheckedPatientResponse {

  @JsonKey(name: "message")
  final String message;

  CheckedPatientResponse({
    required this.message,
  });

  factory CheckedPatientResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckedPatientResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckedPatientResponseToJson(this);
}
