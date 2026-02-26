import 'package:json_annotation/json_annotation.dart';

part 'add_prescription_request.g.dart';

@JsonSerializable()
class AddPrescriptionRequest {

  @JsonKey(name: "appointment_id")
  final String appointmentId;

  @JsonKey(name: "prescription_image")
  final String prescriptionImage;

  AddPrescriptionRequest({
    required this.appointmentId,
    required this.prescriptionImage,
  });

  // Factory method for JSON deserialization
  factory AddPrescriptionRequest.fromJson(Map<String, dynamic> json) =>
      _$AddPrescriptionRequestFromJson(json);

  // Method for JSON serialization
  Map<String, dynamic> toJson() => _$AddPrescriptionRequestToJson(this);
}
