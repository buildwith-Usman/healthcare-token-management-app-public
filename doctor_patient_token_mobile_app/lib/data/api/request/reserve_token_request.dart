import 'package:json_annotation/json_annotation.dart';

part 'reserve_token_request.g.dart';

@JsonSerializable()
class ReserveTokenRequest {
  @JsonKey(name: 'number_of_patient')
  final String numberOfPatient;

  @JsonKey(name: 'patient')
  final List<PatientInfoRequest> patient;

  @JsonKey(name: 'token_number')
  final String tokenNumber;

  @JsonKey(name: 'mfc_token')
  final String mfcToken;

  ReserveTokenRequest({
    required this.numberOfPatient,
    required this.patient,
    required this.tokenNumber,
    required this.mfcToken,
  });

  factory ReserveTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$ReserveTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReserveTokenRequestToJson(this);
}

@JsonSerializable()
class PatientInfoRequest {
  final String name;
  final String gender;
  final String age;

  PatientInfoRequest({
    required this.name,
    required this.gender,
    required this.age,
  });

  factory PatientInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$PatientInfoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PatientInfoRequestToJson(this);
}
