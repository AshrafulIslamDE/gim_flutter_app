// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTimeSpent _$UserTimeSpentFromJson(Map<String, dynamic> json) {
  return UserTimeSpent(
    json['timeIn'] as String,
    json['timeOut'] as String,
    json['date'] as String,
  );
}

Map<String, dynamic> _$UserTimeSpentToJson(UserTimeSpent instance) =>
    <String, dynamic>{
      'timeIn': instance.timeIn,
      'timeOut': instance.timeOut,
      'date': instance.date,
    };
