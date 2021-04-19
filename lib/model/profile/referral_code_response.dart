
import 'package:json_annotation/json_annotation.dart';

part 'referral_code_response.g.dart';

@JsonSerializable()
class IsReferralValid{

  bool status;

  IsReferralValid();

  factory IsReferralValid.fromJson(Map<String, dynamic> json) => _$IsReferralValidFromJson(json);
  Map<String, dynamic> toJson() => _$IsReferralValidToJson(this);

}