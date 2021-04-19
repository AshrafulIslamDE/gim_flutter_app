import 'package:json_annotation/json_annotation.dart';
part 'referral_invitation.g.dart';
@JsonSerializable()
class ReferralInvitationRequest{
  String mobileNumber;
  int roleId;
  String shortUrl;
  ReferralInvitationRequest(this.mobileNumber,this.roleId,this.shortUrl);
  Map<String, dynamic> toJson() => _$ReferralInvitationRequestToJson(this);

}