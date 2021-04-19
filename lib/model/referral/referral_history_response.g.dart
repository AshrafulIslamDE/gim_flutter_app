// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referral_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReferralHistoryItem _$ReferralHistoryItemFromJson(Map<String, dynamic> json) {
  return ReferralHistoryItem()
    ..paidAmount = (json['paidAmount'] as num)?.toDouble()
    ..rewardAmount = (json['rewardAmount'] as num)?.toDouble()
    ..transactionId = json['transactionId'] as String
    ..rewardDate = json['rewardDate'] as int
    ..rewardReason = json['rewardReason'] as String
    ..paymentDate = json['paymentDate'] as int
    ..rewardMessage = json['rewardMessage'] as String;
}

Map<String, dynamic> _$ReferralHistoryItemToJson(
        ReferralHistoryItem instance) =>
    <String, dynamic>{
      'paidAmount': instance.paidAmount,
      'rewardAmount': instance.rewardAmount,
      'transactionId': instance.transactionId,
      'rewardDate': instance.rewardDate,
      'rewardReason': instance.rewardReason,
      'paymentDate': instance.paymentDate,
      'rewardMessage': instance.rewardMessage,
    };

ReferralHistoryResponse _$ReferralHistoryResponseFromJson(
    Map<String, dynamic> json) {
  return ReferralHistoryResponse()
    ..totalOutstandingAmount =
        (json['totalOutstandingAmount'] as num)?.toDouble()
    ..totalEarnedAmount = (json['totalEarnedAmount'] as num)?.toDouble()
    ..totalPaidAmount = (json['totalPaidAmount'] as num)?.toDouble()
    ..selectedUserEarningFilter = json['selectedUserEarningFilter'] as String
    ..filteredUserEarnings = json['filteredUserEarnings'] == null
        ? null
        : BasePagination.fromJson(
            json['filteredUserEarnings'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ReferralHistoryResponseToJson(
        ReferralHistoryResponse instance) =>
    <String, dynamic>{
      'totalOutstandingAmount': instance.totalOutstandingAmount,
      'totalEarnedAmount': instance.totalEarnedAmount,
      'totalPaidAmount': instance.totalPaidAmount,
      'selectedUserEarningFilter': instance.selectedUserEarningFilter,
      'filteredUserEarnings': instance.filteredUserEarnings,
    };
