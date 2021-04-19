// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referral_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Referral _$ReferralFromJson(Map<String, dynamic> json) {
  return Referral()
    ..invitationDate = json['invitationDate'] as int
    ..mobileNumber = json['mobileNumber'] as String
    ..registrationDate = json['registrationDate'] as int
    ..userRole = json['userRole'] as int;
}

Map<String, dynamic> _$ReferralToJson(Referral instance) => <String, dynamic>{
      'invitationDate': instance.invitationDate,
      'mobileNumber': instance.mobileNumber,
      'registrationDate': instance.registrationDate,
      'userRole': instance.userRole,
    };

ReferralResponse _$ReferralResponseFromJson(Map<String, dynamic> json) {
  return ReferralResponse()
    ..totalRegisteredUserWithReferral =
        json['totalRegisteredUserWithReferral'] as int
    ..totalUnregisteredUserWithReferral =
        json['totalUnregisteredUserWithReferral'] as int
    ..totalRegisteredUserWithoutReferral =
        json['totalRegisteredUserWithoutReferral'] as int
    ..filteredReferrals = json['filteredReferrals'] == null
        ? null
        : BasePagination.fromJson(
            json['filteredReferrals'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ReferralResponseToJson(ReferralResponse instance) =>
    <String, dynamic>{
      'totalRegisteredUserWithReferral':
          instance.totalRegisteredUserWithReferral,
      'totalUnregisteredUserWithReferral':
          instance.totalUnregisteredUserWithReferral,
      'totalRegisteredUserWithoutReferral':
          instance.totalRegisteredUserWithoutReferral,
      'filteredReferrals': instance.filteredReferrals,
    };
