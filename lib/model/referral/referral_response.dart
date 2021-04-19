import 'package:customer/model/base.dart';
import 'package:json_annotation/json_annotation.dart';
part 'referral_response.g.dart';
@JsonSerializable()
class Referral{
@JsonKey(name:"invitationDate")
int invitationDate;
@JsonKey(name:"mobileNumber")
String mobileNumber;
@JsonKey(name:"registrationDate")
int registrationDate;
@JsonKey(name:"userRole")
int userRole;
Referral();
Referral.instance(this.invitationDate,this.mobileNumber,this.registrationDate,this.userRole);
factory Referral.fromJson(Map<String,dynamic>json)=>_$ReferralFromJson(json);
Map<String, dynamic> toJson() => _$ReferralToJson(this);

formattedUserRole(){
  if (userRole!= null && userRole == 5) return "CUSTOMER";
  else if(userRole!= null && userRole == 3) return "PARTNER";
  else if(userRole!= null && userRole == 2) return "Driver"; else return "";
}
}


@JsonSerializable()
class ReferralResponse{
  int totalRegisteredUserWithReferral;
  int totalUnregisteredUserWithReferral;
  int totalRegisteredUserWithoutReferral;
  ReferralResponse.counter(this.totalRegisteredUserWithoutReferral,this.totalUnregisteredUserWithReferral,this.totalRegisteredUserWithReferral);
  BasePagination<Referral> filteredReferrals;
  ReferralResponse();
  factory ReferralResponse.fromJson(Map<String,dynamic>json)=>_$ReferralResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReferralResponseToJson(this);

}