// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenDetailsResponse _$TokenDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    TokenDetailsResponse(
      id: (json['id'] as num).toInt(),
      shift: json['shift'] as String,
      date: json['date'] as String,
      tokenNumber: (json['token_number'] as num).toInt(),
      type: json['type'] as String,
      tokenId: (json['token_id'] as num).toInt(),
      numberOfPatient: (json['number_of_patient'] as num).toInt(),
      status: json['status'] as String,
      patients: (json['patients'] as List<dynamic>)
          .map(
              (e) => PatientDetailsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TokenDetailsResponseToJson(
        TokenDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shift': instance.shift,
      'date': instance.date,
      'token_number': instance.tokenNumber,
      'type': instance.type,
      'token_id': instance.tokenId,
      'number_of_patient': instance.numberOfPatient,
      'status': instance.status,
      'patients': instance.patients,
    };

PatientDetailsResponse _$PatientDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    PatientDetailsResponse(
      patientId: (json['patient_id'] as num).toInt(),
      name: json['name'] as String,
      age: json['age'] as String,
      gender: json['gender'] as String,
      prescription: json['prescription'] as String?,
    );

Map<String, dynamic> _$PatientDetailsResponseToJson(
        PatientDetailsResponse instance) =>
    <String, dynamic>{
      'patient_id': instance.patientId,
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'prescription': instance.prescription,
    };
