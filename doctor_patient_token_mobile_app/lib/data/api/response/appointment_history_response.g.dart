// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentHistoryResponse _$AppointmentHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    AppointmentHistoryResponse(
      id: (json['id'] as num?)?.toInt(),
      shift: json['shift'] as String?,
      date: json['date'] as String?,
      tokenNumber: (json['token_number'] as num?)?.toInt(),
      type: json['type'] as String?,
      tokenId: (json['token_id'] as num?)?.toInt(),
      numberOfPatient: (json['number_of_patient'] as num?)?.toInt(),
      patientId: (json['patient_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      age: json['age'] as String?,
      gender: json['gender'] as String?,
      prescription: json['prescription'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AppointmentHistoryResponseToJson(
        AppointmentHistoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shift': instance.shift,
      'date': instance.date,
      'token_number': instance.tokenNumber,
      'type': instance.type,
      'token_id': instance.tokenId,
      'number_of_patient': instance.numberOfPatient,
      'patient_id': instance.patientId,
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'prescription': instance.prescription,
      'status': instance.status,
    };
