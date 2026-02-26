import 'package:json_annotation/json_annotation.dart';

part 'token_details_response.g.dart';

@JsonSerializable()
class TokenDetailsResponse {

  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "shift")
  final String shift;

  @JsonKey(name: "date")
  final String date;

  @JsonKey(name: "token_number")
  final int tokenNumber;

  @JsonKey(name: "type")
  final String type;

  @JsonKey(name: "token_id")
  final int tokenId;

  @JsonKey(name: "number_of_patient")
  final int numberOfPatient;

  @JsonKey(name: "status")
  final String status;

  @JsonKey(name: "patients")
  final List<PatientDetailsResponse> patients;

  TokenDetailsResponse({
    required this.id,
    required this.shift,
    required this.date,
    required this.tokenNumber,
    required this.type,
    required this.tokenId,
    required this.numberOfPatient,
    required this.status,
    required this.patients,
  });

  factory TokenDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenDetailsResponseToJson(this);
}

@JsonSerializable()
class PatientDetailsResponse {

  @JsonKey(name: "patient_id")
  final int patientId;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "age")
  final String age;

  @JsonKey(name: "gender")
  final String gender;

  @JsonKey(name: "prescription")
  final String? prescription;

  PatientDetailsResponse({
    required this.patientId,
    required this.name,
    required this.age,
    required this.gender,
    required this.prescription,
  });

  factory PatientDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientDetailsResponseToJson(this);

}
