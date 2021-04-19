
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
part 'sign_up_request.g.dart';

@JsonSerializable()
class SignUpRequest{
  @JsonKey(name:"deviceToken")
  String deviceToken ;
 @JsonKey(name:"deviceType")
 String deviceType  = Platform.isIOS?"IOS":"ANDROID";
 @JsonKey(name:"dob")
 String dob ;
 @JsonKey(name:"password")
 String password ;
 @JsonKey(name:"email")
 String email ;
 @JsonKey(name:"name")
 String name ;
 @JsonKey(name:"mobileNumber")
 String mobileNumber ;
 @JsonKey(name:"location")
 String location  = "";
 @JsonKey(name:"nationalId")
 String nationalId ;
 @JsonKey(name:"referrelCode")
 String referrelCode ;
 @JsonKey(name:"masterDistrictId")
  int masterDistrictId ;
 @JsonKey(name:"roleId")
  int roleId  = 5;
 @JsonKey(name:"driverBackPhoto")
 String driverBackPhoto  ;
 @JsonKey(name:"driverFrontPhoto")
 String driverFrontPhoto  ;
 @JsonKey(name:"driverLicenseNumber")
 String driverLicenseNumber  ;
 @JsonKey(name:"driverLicenseExpiryDate")
 String driverLicenseExpiryDate  ;
 @JsonKey(name:"partnerAndDriver")
 bool partnerAndDriver  = false;
 @JsonKey(name:"bothPartnerDriver")
  bool bothPartnerDriver  = false;
 @JsonKey(name:'profilePhoto')
 String profilePhoto  = "";
  @JsonKey(name:"nationalIdBackPhoto")
  String nationalIdBackPhoto ;
  @JsonKey(name:"nationalIdFrontPhoto")
  String nationalIdFrontPhoto ;

  SignUpRequest();
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);

}

@JsonSerializable()
class SignUpResponse{
SignUpResponse();
factory SignUpResponse.fromJson(Map<String, dynamic> json) => _$SignUpResponseFromJson(json);
}

class RegistrationSingleton {

  RegistrationSingleton._privateConstructor(){
    if(this.request==null)
      request=SignUpRequest();
  }
  static final RegistrationSingleton instance = RegistrationSingleton._privateConstructor();
  SignUpRequest request;

}