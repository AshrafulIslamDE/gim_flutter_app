// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_generation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpGenerationResponse _$OtpGenerationResponseFromJson(
    Map<String, dynamic> json) {
  return OtpGenerationResponse()
    ..popUp = json['popUp'] as bool
    ..driver = json['driver'] as bool
    ..roleId = json['roleId'] as int
    ..otpVerified = json['otpVerified'] as bool
    ..smartphonePromptRequired = json['smartphonePromptRequired'] as bool
    ..smartphoneStatus = json['smartphoneStatus'] as int
    ..partnerAndDriver = json['partnerAndDriver'] as bool
    ..id = json['id'] as int
    ..twoStep = json['twoStep'] as bool
    ..roleStatus = json['roleStatus'] as int;
}

Map<String, dynamic> _$OtpGenerationResponseToJson(
        OtpGenerationResponse instance) =>
    <String, dynamic>{
      'popUp': instance.popUp,
      'driver': instance.driver,
      'roleId': instance.roleId,
      'otpVerified': instance.otpVerified,
      'smartphonePromptRequired': instance.smartphonePromptRequired,
      'smartphoneStatus': instance.smartphoneStatus,
      'partnerAndDriver': instance.partnerAndDriver,
      'id': instance.id,
      'twoStep': instance.twoStep,
      'roleStatus': instance.roleStatus,
    };
