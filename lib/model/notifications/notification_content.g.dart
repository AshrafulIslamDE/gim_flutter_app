// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationContent _$NotificationContentFromJson(Map<String, dynamic> json) {
  return NotificationContent(
    notificationId: json['notificationId'] as int,
    notificationType: json['notificationType'] as int,
    objectId: json['objectId'] as int,
  )
    ..data = json['data'] == null
        ? null
        : NotificationData.fromJson(json['data'] as Map<String, dynamic>)
    ..message = json['message'] as String
    ..userImage = json['userImage'] as String
    ..userName = json['userName'] as String
    ..modifiedAt = json['modifiedAt'] as int
    ..createdAt = json['createdAt'] as int
    ..read = json['read'] as bool
    ..description = json['description'] as String;
}

Map<String, dynamic> _$NotificationContentToJson(
        NotificationContent instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'objectId': instance.objectId,
      'notificationType': instance.notificationType,
      'data': instance.data,
      'message': instance.message,
      'userImage': instance.userImage,
      'userName': instance.userName,
      'modifiedAt': instance.modifiedAt,
      'createdAt': instance.createdAt,
      'read': instance.read,
      'description': instance.description,
    };

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) {
  return NotificationData()
    ..dateTime = json['dateTime'] as int
    ..senderId = json['senderId'] as int
    ..address = json['address'] as String
    ..notificationType = json['notificationType'] as int
    ..bidAmount = (json['bidAmount'] as num)?.toDouble();
}

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'dateTime': instance.dateTime,
      'senderId': instance.senderId,
      'address': instance.address,
      'notificationType': instance.notificationType,
      'bidAmount': instance.bidAmount,
    };
