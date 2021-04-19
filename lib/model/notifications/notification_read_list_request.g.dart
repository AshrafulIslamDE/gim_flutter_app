// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_read_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationReadListRequest _$NotificationReadListRequestFromJson(
    Map<String, dynamic> json) {
  return NotificationReadListRequest(
    (json['notificationIds'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$NotificationReadListRequestToJson(
        NotificationReadListRequest instance) =>
    <String, dynamic>{
      'notificationIds': instance.notificationIds,
    };
