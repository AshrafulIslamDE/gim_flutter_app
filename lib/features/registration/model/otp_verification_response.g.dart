// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpVerificationRequest _$OtpVerificationRequestFromJson(
    Map<String, dynamic> json) {
  return OtpVerificationRequest(
    json['mobileNumber'] as String,
    json['otp'] as int,
    signUp: json['signUp'],
  )
    ..deviceToken = json['deviceToken'] as String
    ..deviceType = json['deviceType'] as String
    ..roleId = json['roleId'] as int;
}

Map<String, dynamic> _$OtpVerificationRequestToJson(
        OtpVerificationRequest instance) =>
    <String, dynamic>{
      'deviceToken': instance.deviceToken,
      'deviceType': instance.deviceType,
      'mobileNumber': instance.mobileNumber,
      'roleId': instance.roleId,
      'otp': instance.otp,
      'signUp': instance.signUp,
    };

OtpVerificationResponse _$OtpVerificationResponseFromJson(
    Map<String, dynamic> json) {
  return OtpVerificationResponse(
    json['mobileNumber'] as String,
  )
    ..deviceToken = json['deviceToken'] as String
    ..deviceType = json['deviceType'] as String
    ..roleId = json['roleId'] as int
    ..signUp = json['signUp'] as bool;
}

Map<String, dynamic> _$OtpVerificationResponseToJson(
        OtpVerificationResponse instance) =>
    <String, dynamic>{
      'deviceToken': instance.deviceToken,
      'deviceType': instance.deviceType,
      'mobileNumber': instance.mobileNumber,
      'roleId': instance.roleId,
      'signUp': instance.signUp,
    };
