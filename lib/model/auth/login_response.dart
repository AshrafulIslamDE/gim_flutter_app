import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';
@JsonSerializable()
class LoginResponse {
  String logInAs;
  int roleId;
  bool otpVerified;
  bool smartphonePromptRequired;
  String pic;
  String nationalIdFrontPhoto;
  String token;
  int roleStatus;
  List<UserRolesItem>userRoles ;
  bool popUp;
  bool driver;
  String nationalId;
  int dob;
  String name;
  int smartphoneStatus;
  String nationalIdBackPhoto;
  int lastModified;
  int id;
  String email;
  bool twoStep;
  String referrelCode;
  String district;
  String mobileNumber;
  int tradeLicenseExpiryDate;
  bool approvedDistributor;
  String passportNumber;
  String passportImage;
  String distributorCompanyName;


  String  getUserStatus(){
    if(userRoles==null || userRoles.isEmpty) return " ";
    else {
      var filteredItem=  userRoles.where((item) => item.id == 5).toList();
      return filteredItem[0].applicationStatus;
    }
  }
  bool isApprovedRoles(){
    return getUserStatus()=='APPROVED';
  }
  bool isEnterpriseUser()=>userRoles.where((item) => item.id == 5).toList()[0].enterprise;
  LoginResponse();
  factory LoginResponse.fromJson(Map<String,dynamic>json)=>_$LoginResponseFromJson(json);

}

@JsonSerializable()
class UserRolesItem {
  String applicationStatus;
  bool enterprise=false;
  Object enterpriseStatus;
  String name;
  int id;
  bool agent;
  UserRolesItem();
  factory UserRolesItem.fromJson(Map<String,dynamic>json)=>_$UserRolesItemFromJson(json);

}
