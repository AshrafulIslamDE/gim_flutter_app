// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_generation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpGenerationRequest _$OtpGenerationRequestFromJson(Map<String, dynamic> json) {
  return OtpGenerationRequest(
    json['mobileNumber'] as String,
    signUp: json['signUp'],
    roleId: json['roleId'],
  )
    ..deviceToken = json['deviceToken'] as String
    ..deviceType = json['deviceType'] as String;
}

Map<String, dynamic> _$OtpGenerationRequestToJson(
        OtpGenerationRequest instance) =>
    <String, dynamic>{
      'deviceToken': instance.deviceToken,
      'deviceType': instance.deviceType,
      'mobileNumber': instance.mobileNumber,
      'roleId': instance.roleId,
      'signUp': instance.signUp,
    };
