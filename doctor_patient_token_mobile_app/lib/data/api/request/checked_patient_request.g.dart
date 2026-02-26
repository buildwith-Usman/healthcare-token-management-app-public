// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checked_patient_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckedPatientRequest _$CheckedPatientRequestFromJson(
        Map<String, dynamic> json) =>
    CheckedPatientRequest(
      tokenId: json['token_id'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$CheckedPatientRequestToJson(
        CheckedPatientRequest instance) =>
    <String, dynamic>{
      'token_id': instance.tokenId,
      'status': instance.status,
    };
