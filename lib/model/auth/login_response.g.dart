// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse()
    ..logInAs = json['logInAs'] as String
    ..roleId = json['roleId'] as int
    ..otpVerified = json['otpVerified'] as bool
    ..smartphonePromptRequired = json['smartphonePromptRequired'] as bool
    ..pic = json['pic'] as String
    ..nationalIdFrontPhoto = json['nationalIdFrontPhoto'] as String
    ..token = json['token'] as String
    ..roleStatus = json['roleStatus'] as int
    ..userRoles = (json['userRoles'] as List)
        ?.map((e) => e == null
            ? null
            : UserRolesItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..popUp = json['popUp'] as bool
    ..driver = json['driver'] as bool
    ..nationalId = json['nationalId'] as String
    ..dob = json['dob'] as int
    ..name = json['name'] as String
    ..smartphoneStatus = json['smartphoneStatus'] as int
    ..nationalIdBackPhoto = json['nationalIdBackPhoto'] as String
    ..lastModified = json['lastModified'] as int
    ..id = json['id'] as int
    ..email = json['email'] as String
    ..twoStep = json['twoStep'] as bool
    ..referrelCode = json['referrelCode'] as String
    ..district = json['district'] as String
    ..mobileNumber = json['mobileNumber'] as String
    ..tradeLicenseExpiryDate = json['tradeLicenseExpiryDate'] as int
    ..approvedDistributor = json['approvedDistributor'] as bool
    ..passportNumber = json['passportNumber'] as String
    ..passportImage = json['passportImage'] as String
    ..distributorCompanyName = json['distributorCompanyName'] as String;
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'logInAs': instance.logInAs,
      'roleId': instance.roleId,
      'otpVerified': instance.otpVerified,
      'smartphonePromptRequired': instance.smartphonePromptRequired,
      'pic': instance.pic,
      'nationalIdFrontPhoto': instance.nationalIdFrontPhoto,
      'token': instance.token,
      'roleStatus': instance.roleStatus,
      'userRoles': instance.userRoles,
      'popUp': instance.popUp,
      'driver': instance.driver,
      'nationalId': instance.nationalId,
      'dob': instance.dob,
      'name': instance.name,
      'smartphoneStatus': instance.smartphoneStatus,
      'nationalIdBackPhoto': instance.nationalIdBackPhoto,
      'lastModified': instance.lastModified,
      'id': instance.id,
      'email': instance.email,
      'twoStep': instance.twoStep,
      'referrelCode': instance.referrelCode,
      'district': instance.district,
      'mobileNumber': instance.mobileNumber,
      'tradeLicenseExpiryDate': instance.tradeLicenseExpiryDate,
      'approvedDistributor': instance.approvedDistributor,
      'passportNumber': instance.passportNumber,
      'passportImage': instance.passportImage,
      'distributorCompanyName': instance.distributorCompanyName,
    };

UserRolesItem _$UserRolesItemFromJson(Map<String, dynamic> json) {
  return UserRolesItem()
    ..applicationStatus = json['applicationStatus'] as String
    ..enterprise = json['enterprise'] as bool
    ..enterpriseStatus = json['enterpriseStatus']
    ..name = json['name'] as String
    ..id = json['id'] as int
    ..agent = json['agent'] as bool;
}

Map<String, dynamic> _$UserRolesItemToJson(UserRolesItem instance) =>
    <String, dynamic>{
      'applicationStatus': instance.applicationStatus,
      'enterprise': instance.enterprise,
      'enterpriseStatus': instance.enterpriseStatus,
      'name': instance.name,
      'id': instance.id,
      'agent': instance.agent,
    };
