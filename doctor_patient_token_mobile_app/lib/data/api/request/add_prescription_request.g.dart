// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_prescription_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPrescriptionRequest _$AddPrescriptionRequestFromJson(
        Map<String, dynamic> json) =>
    AddPrescriptionRequest(
      appointmentId: json['appointment_id'] as String,
      prescriptionImage: json['prescription_image'] as String,
    );

Map<String, dynamic> _$AddPrescriptionRequestToJson(
        AddPrescriptionRequest instance) =>
    <String, dynamic>{
      'appointment_id': instance.appointmentId,
      'prescription_image': instance.prescriptionImage,
    };
