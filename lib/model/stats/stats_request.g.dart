// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTimeSpentRequestList _$UserTimeSpentRequestListFromJson(
    Map<String, dynamic> json) {
  return UserTimeSpentRequestList(
    roleId: json['roleId'] as int,
    userAppTimeBatchs: (json['userAppTimeBatchs'] as List)
        ?.map((e) => e == null
            ? null
            : UserTimeSpent.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserTimeSpentRequestListToJson(
        UserTimeSpentRequestList instance) =>
    <String, dynamic>{
      'roleId': instance.roleId,
      'userAppTimeBatchs': instance.userAppTimeBatchs,
    };

UserTimeSpentRequest _$UserTimeSpentRequestFromJson(Map<String, dynamic> json) {
  return UserTimeSpentRequest(
    date: json['date'] as String,
    timeIn: json['timeIn'] as String,
    timeOut: json['timeOut'] as String,
  );
}

Map<String, dynamic> _$UserTimeSpentRequestToJson(
        UserTimeSpentRequest instance) =>
    <String, dynamic>{
      'date': instance.date,
      'timeIn': instance.timeIn,
      'timeOut': instance.timeOut,
    };
