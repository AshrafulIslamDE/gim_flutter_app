import 'package:json_annotation/json_annotation.dart';

part 'cancel_reason_id.g.dart';

@JsonSerializable()
class CancelReasonId{
  int cancelReasonId;

  CancelReasonId({this.cancelReasonId});

  factory CancelReasonId.fromJson(Map<String, dynamic> json) => _$CancelReasonIdFromJson(json);
  Map<String, dynamic> toJson() => _$CancelReasonIdToJson(this);
}