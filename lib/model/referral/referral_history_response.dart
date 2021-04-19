import 'package:customer/model/base.dart';
import 'package:json_annotation/json_annotation.dart';
part 'referral_history_response.g.dart';
@JsonSerializable()
class ReferralHistoryItem{
  double paidAmount;
  double rewardAmount;
  String transactionId;
  int rewardDate;
  String rewardReason;
  int paymentDate;
  String rewardMessage;
  ReferralHistoryItem();
  ReferralHistoryItem.instance({this.paidAmount,this.rewardAmount,this.transactionId,this.rewardDate,this.paymentDate,this.rewardReason,this.rewardMessage});
  factory ReferralHistoryItem.fromJson(Map<String,dynamic>json)=>_$ReferralHistoryItemFromJson(json);
  Map<String, dynamic> toJson() => _$ReferralHistoryItemToJson(this);

}

@JsonSerializable()
class ReferralHistoryResponse{
  ReferralHistoryResponse();
  double totalOutstandingAmount;
  double totalEarnedAmount;
  double totalPaidAmount;
  String selectedUserEarningFilter;
  ReferralHistoryResponse.counter(this.totalEarnedAmount,this.totalPaidAmount,this.totalOutstandingAmount);
  BasePagination<ReferralHistoryItem>filteredUserEarnings;
  factory ReferralHistoryResponse.fromJson(Map<String,dynamic>json)=>_$ReferralHistoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReferralHistoryResponseToJson(this);
}