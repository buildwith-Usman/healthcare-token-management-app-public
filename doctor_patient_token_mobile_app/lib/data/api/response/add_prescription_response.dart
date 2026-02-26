import 'package:json_annotation/json_annotation.dart';

part 'add_prescription_response.g.dart';

@JsonSerializable()
class AddPrescriptionResponse {

  @JsonKey(name: "path")
  final String path;

  AddPrescriptionResponse({
    required this.path,
  });

  factory AddPrescriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$AddPrescriptionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddPrescriptionResponseToJson(this);
}
