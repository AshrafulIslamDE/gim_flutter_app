// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dob_nid_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DobNidRequest _$DobNidRequestFromJson(Map<String, dynamic> json) {
  return DobNidRequest(
    deviceToken: json['deviceToken'],
    deviceType: json['deviceType'],
    roleId: json['roleId'] as int,
    userId: json['userId'],
    dob: json['dob'],
    nationalId: json['nationalId'],
    newPassword: json['newPassword'],
    confirmNewPassword: json['confirmNewPassword'],
  );
}

Map<String, dynamic> _$DobNidRequestToJson(DobNidRequest instance) =>
    <String, dynamic>{
      'deviceToken': instance.deviceToken,
      'deviceType': instance.deviceType,
      'dob': instance.dob,
      'nationalId': instance.nationalId,
      'roleId': instance.roleId,
      'userId': instance.userId,
      'newPassword': instance.newPassword,
      'confirmNewPassword': instance.confirmNewPassword,
    };
