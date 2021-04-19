// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationStatus _$ApplicationStatusFromJson(Map<String, dynamic> json) {
  return ApplicationStatus(
    id: json['id'] as int,
  )..value = json['value'] as String;
}

Map<String, dynamic> _$ApplicationStatusToJson(ApplicationStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };
