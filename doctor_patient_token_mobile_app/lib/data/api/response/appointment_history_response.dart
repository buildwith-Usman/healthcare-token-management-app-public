import 'package:json_annotation/json_annotation.dart';

part 'appointment_history_response.g.dart';

@JsonSerializable()
class AppointmentHistoryResponse {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'shift')
  final String? shift;

  @JsonKey(name: 'date')
  final String? date;

  @JsonKey(name: 'token_number')
  final int? tokenNumber;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'token_id')
  final int? tokenId;

  @JsonKey(name: 'number_of_patient')
  final int? numberOfPatient;

  @JsonKey(name: 'patient_id')
  final int? patientId;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'age')
  final String? age;

  @JsonKey(name: 'gender')
  final String? gender;

  @JsonKey(name: 'prescription')
  final String? prescription;

  @JsonKey(name: 'status')
  final String? status;

  AppointmentHistoryResponse({
    required this.id,
    required this.shift,
    required this.date,
    required this.tokenNumber,
    required this.type,
    required this.tokenId,
    required this.numberOfPatient,
    required this.patientId,
    required this.name,
    required this.age,
    required this.gender,
    required this.prescription,
    required this.status,
  });

  factory AppointmentHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentHistoryResponseToJson(this);
}