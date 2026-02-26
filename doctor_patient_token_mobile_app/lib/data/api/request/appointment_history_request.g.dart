// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_history_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentHistoryRequest _$AppointmentHistoryRequestFromJson(
        Map<String, dynamic> json) =>
    AppointmentHistoryRequest(
      search: json['search'] as String?,
      date: json['date'] as String?,
      shift: json['shift'] as String?,
      bookType: json['book_type'] as String?,
      patientId: json['patient_id'] as String?,
      pageNumber: (json['page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AppointmentHistoryRequestToJson(
        AppointmentHistoryRequest instance) =>
    <String, dynamic>{
      if (instance.search case final value?) 'search': value,
      if (instance.date case final value?) 'date': value,
      if (instance.shift case final value?) 'shift': value,
      if (instance.bookType case final value?) 'book_type': value,
      if (instance.patientId case final value?) 'patient_id': value,
      if (instance.pageNumber case final value?) 'page': value,
    };
