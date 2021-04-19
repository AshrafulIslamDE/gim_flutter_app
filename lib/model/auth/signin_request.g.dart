// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInRequest _$SignInRequestFromJson(Map<String, dynamic> json) {
  return SignInRequest(
    deviceToken: json['deviceToken'] as String,
    mobileNum: json['mobileNum'] as String,
    password: json['password'] as String,
  )
    ..deviceType = json['deviceType'] as String
    ..roleId = json['roleId'] as int;
}

Map<String, dynamic> _$SignInRequestToJson(SignInRequest instance) =>
    <String, dynamic>{
      'deviceToken': instance.deviceToken,
      'deviceType': instance.deviceType,
      'mobileNum': instance.mobileNum,
      'password': instance.password,
      'roleId': instance.roleId,
    };
