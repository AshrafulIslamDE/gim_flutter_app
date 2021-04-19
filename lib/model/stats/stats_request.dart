import 'package:customer/data/local/db/stats.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stats_request.g.dart';

@JsonSerializable()
class UserTimeSpentRequestList {
  final int roleId;
  final List<UserTimeSpent> userAppTimeBatchs;

  UserTimeSpentRequestList({this.roleId = 5, this.userAppTimeBatchs});

  factory UserTimeSpentRequestList.fromJson(Map<String, dynamic> json) =>
      _$UserTimeSpentRequestListFromJson(json);

  Map<String, dynamic> toJson() => _$UserTimeSpentRequestListToJson(this);
}

@JsonSerializable()
class UserTimeSpentRequest {
  String date;
  String timeIn;
  String timeOut;

  UserTimeSpentRequest({this.date, this.timeIn, this.timeOut});

  factory UserTimeSpentRequest.fromJson(Map<String, dynamic> json) =>
      _$UserTimeSpentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserTimeSpentRequestToJson(this);
}
