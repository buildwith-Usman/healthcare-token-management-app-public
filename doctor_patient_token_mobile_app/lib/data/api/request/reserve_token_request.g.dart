// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserve_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReserveTokenRequest _$ReserveTokenRequestFromJson(Map<String, dynamic> json) =>
    ReserveTokenRequest(
      numberOfPatient: json['number_of_patient'] as String,
      patient: (json['patient'] as List<dynamic>)
          .map((e) => PatientInfoRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      tokenNumber: json['token_number'] as String,
      mfcToken: json['mfc_token'] as String,
    );

Map<String, dynamic> _$ReserveTokenRequestToJson(
        ReserveTokenRequest instance) =>
    <String, dynamic>{
      'number_of_patient': instance.numberOfPatient,
      'patient': instance.patient,
      'token_number': instance.tokenNumber,
      'mfc_token': instance.mfcToken,
    };

PatientInfoRequest _$PatientInfoRequestFromJson(Map<String, dynamic> json) =>
    PatientInfoRequest(
      name: json['name'] as String,
      gender: json['gender'] as String,
      age: json['age'] as String,
    );

Map<String, dynamic> _$PatientInfoRequestToJson(PatientInfoRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'gender': instance.gender,
      'age': instance.age,
    };
