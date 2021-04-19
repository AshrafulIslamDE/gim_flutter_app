// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileRequest _$EditProfileRequestFromJson(Map<String, dynamic> json) {
  return EditProfileRequest()
    ..roleId = json['roleId'] as int
    ..dob = json['dob'] as String
    ..email = json['email'] as String
    ..name = json['name'] as String
    ..profilePhoto = json['profilePhoto'] as String
    ..location = json['location'] as String
    ..nationalId = json['nationalId'] as String
    ..nationalIdBackPhoto = json['nationalIdBackPhoto'] as String
    ..nationalIdFrontPhoto = json['nationalIdFrontPhoto'] as String
    ..smartphoneStatus = json['smartphoneStatus'] as int
    ..district = json['district'] as int
    ..bkashNumber = json['bkashNumber'] as String
    ..referralCode = json['referralCode'] as String;
}

Map<String, dynamic> _$EditProfileRequestToJson(EditProfileRequest instance) =>
    <String, dynamic>{
      'roleId': instance.roleId,
      'dob': instance.dob,
      'email': instance.email,
      'name': instance.name,
      'profilePhoto': instance.profilePhoto,
      'location': instance.location,
      'nationalId': instance.nationalId,
      'nationalIdBackPhoto': instance.nationalIdBackPhoto,
      'nationalIdFrontPhoto': instance.nationalIdFrontPhoto,
      'smartphoneStatus': instance.smartphoneStatus,
      'district': instance.district,
      'bkashNumber': instance.bkashNumber,
      'referralCode': instance.referralCode,
    };
