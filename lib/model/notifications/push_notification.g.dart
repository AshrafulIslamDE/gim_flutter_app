// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationData _$PushNotificationDataFromJson(Map<String, dynamic> json) {
  return PushNotificationData()
    ..notificationId = json['notificationId'] as String
    ..objectId = json['objectId'] as String
    ..notificationType = json['notificationType'] as String
    ..tripId = json['tripId'] as String
    ..title = json['title'] as String
    ..body = json['body'] as String
    ..dateTime = json['dateTime'] as String
    ..senderId = json['senderId'] as String
    ..address = json['address'] as String;
}

Map<String, dynamic> _$PushNotificationDataToJson(
        PushNotificationData instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'objectId': instance.objectId,
      'notificationType': instance.notificationType,
      'tripId': instance.tripId,
      'title': instance.title,
      'body': instance.body,
      'dateTime': instance.dateTime,
      'senderId': instance.senderId,
      'address': instance.address,
    };

UpdateFcmTokenRequest _$UpdateFcmTokenRequestFromJson(
    Map<String, dynamic> json) {
  return UpdateFcmTokenRequest(
    json['deviceToken'] as String,
  )
    ..deviceType = json['deviceType'] as String
    ..roleId = json['roleId'] as int;
}

Map<String, dynamic> _$UpdateFcmTokenRequestToJson(
        UpdateFcmTokenRequest instance) =>
    <String, dynamic>{
      'deviceToken': instance.deviceToken,
      'deviceType': instance.deviceType,
      'roleId': instance.roleId,
    };
