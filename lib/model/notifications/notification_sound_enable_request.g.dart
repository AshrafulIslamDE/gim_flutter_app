// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_sound_enable_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSoundEnableRequest _$NotificationSoundEnableRequestFromJson(
    Map<String, dynamic> json) {
  return NotificationSoundEnableRequest(
    sound: json['sound'] as bool,
  )
    ..roleId = json['roleId'] as int
    ..deviceType = json['deviceType'] as String;
}

Map<String, dynamic> _$NotificationSoundEnableRequestToJson(
        NotificationSoundEnableRequest instance) =>
    <String, dynamic>{
      'roleId': instance.roleId,
      'sound': instance.sound,
      'deviceType': instance.deviceType,
    };
