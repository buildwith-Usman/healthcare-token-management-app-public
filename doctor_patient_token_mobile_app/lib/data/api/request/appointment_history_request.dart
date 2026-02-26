import 'package:json_annotation/json_annotation.dart';

part 'appointment_history_request.g.dart';

@JsonSerializable(includeIfNull: false)
class AppointmentHistoryRequest {

  @JsonKey(name: "search")
  final String? search;

  @JsonKey(name: "date")
  final String? date;

  @JsonKey(name: "shift")
  final String? shift;

  @JsonKey(name: "book_type")
  final String? bookType;

  @JsonKey(name: "patient_id")
  final String? patientId;

  @JsonKey(name: "page")
  final int? pageNumber;

  AppointmentHistoryRequest({
    this.search,
    this.date,
    this.shift,
    this.bookType,
    this.patientId,
    this.pageNumber,
  });

  // Factory method for JSON deserialization
  factory AppointmentHistoryRequest.fromJson(Map<String, dynamic> json) =>
      _$AppointmentHistoryRequestFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$AppointmentHistoryRequestToJson(this);
}
