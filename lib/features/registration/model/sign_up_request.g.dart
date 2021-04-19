// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) {
  return SignUpRequest()
    ..deviceToken = json['deviceToken'] as String
    ..deviceType = json['deviceType'] as String
    ..dob = json['dob'] as String
    ..password = json['password'] as String
    ..email = json['email'] as String
    ..name = json['name'] as String
    ..mobileNumber = json['mobileNumber'] as String
    ..location = json['location'] as String
    ..nationalId = json['nationalId'] as String
    ..referrelCode = json['referrelCode'] as String
    ..masterDistrictId = json['masterDistrictId'] as int
    ..roleId = json['roleId'] as int
    ..driverBackPhoto = json['driverBackPhoto'] as String
    ..driverFrontPhoto = json['driverFrontPhoto'] as String
    ..driverLicenseNumber = json['driverLicenseNumber'] as String
    ..driverLicenseExpiryDate = json['driverLicenseExpiryDate'] as String
    ..partnerAndDriver = json['partnerAndDriver'] as bool
    ..bothPartnerDriver = json['bothPartnerDriver'] as bool
    ..profilePhoto = json['profilePhoto'] as String
    ..nationalIdBackPhoto = json['nationalIdBackPhoto'] as String
    ..nationalIdFrontPhoto = json['nationalIdFrontPhoto'] as String;
}

Map<String, dynamic> _$SignUpRequestToJson(SignUpRequest instance) =>
    <String, dynamic>{
      'deviceToken': instance.deviceToken,
      'deviceType': instance.deviceType,
      'dob': instance.dob,
      'password': instance.password,
      'email': instance.email,
      'name': instance.name,
      'mobileNumber': instance.mobileNumber,
      'location': instance.location,
      'nationalId': instance.nationalId,
      'referrelCode': instance.referrelCode,
      'masterDistrictId': instance.masterDistrictId,
      'roleId': instance.roleId,
      'driverBackPhoto': instance.driverBackPhoto,
      'driverFrontPhoto': instance.driverFrontPhoto,
      'driverLicenseNumber': instance.driverLicenseNumber,
      'driverLicenseExpiryDate': instance.driverLicenseExpiryDate,
      'partnerAndDriver': instance.partnerAndDriver,
      'bothPartnerDriver': instance.bothPartnerDriver,
      'profilePhoto': instance.profilePhoto,
      'nationalIdBackPhoto': instance.nationalIdBackPhoto,
      'nationalIdFrontPhoto': instance.nationalIdFrontPhoto,
    };

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) {
  return SignUpResponse();
}

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{};
