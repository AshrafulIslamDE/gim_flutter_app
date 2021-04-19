// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referral_invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReferralInvitationRequest _$ReferralInvitationRequestFromJson(
    Map<String, dynamic> json) {
  return ReferralInvitationRequest(
    json['mobileNumber'] as String,
    json['roleId'] as int,
    json['shortUrl'] as String,
  );
}

Map<String, dynamic> _$ReferralInvitationRequestToJson(
        ReferralInvitationRequest instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'roleId': instance.roleId,
      'shortUrl': instance.shortUrl,
    };
