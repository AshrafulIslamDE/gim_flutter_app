// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requested_trip_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestedTripStatusResponse _$RequestedTripStatusResponseFromJson(
    Map<String, dynamic> json) {
  return RequestedTripStatusResponse()
    ..biddedDisplayModel = json['biddedDisplayModel'] == null
        ? null
        : IdValuePair.fromJson(
            json['biddedDisplayModel'] as Map<String, dynamic>)
    ..unbiddedDisplayModel = json['unbiddedDisplayModel'] == null
        ? null
        : IdValuePair.fromJson(
            json['unbiddedDisplayModel'] as Map<String, dynamic>)
    ..bookedDisplayModel = json['bookedDisplayModel'] == null
        ? null
        : IdValuePair.fromJson(
            json['bookedDisplayModel'] as Map<String, dynamic>)
    ..liveDisplayModel = json['liveDisplayModel'] == null
        ? null
        : IdValuePair.fromJson(json['liveDisplayModel'] as Map<String, dynamic>)
    ..completedDisplayModel = json['completedDisplayModel'] == null
        ? null
        : IdValuePair.fromJson(
            json['completedDisplayModel'] as Map<String, dynamic>)
    ..requestedDisplayModel = json['requestedDisplayModel'] == null
        ? null
        : IdValuePair.fromJson(
            json['requestedDisplayModel'] as Map<String, dynamic>)
    ..serverTime = json['serverTime'] as int;
}

Map<String, dynamic> _$RequestedTripStatusResponseToJson(
        RequestedTripStatusResponse instance) =>
    <String, dynamic>{
      'biddedDisplayModel': instance.biddedDisplayModel,
      'unbiddedDisplayModel': instance.unbiddedDisplayModel,
      'bookedDisplayModel': instance.bookedDisplayModel,
      'liveDisplayModel': instance.liveDisplayModel,
      'completedDisplayModel': instance.completedDisplayModel,
      'requestedDisplayModel': instance.requestedDisplayModel,
      'serverTime': instance.serverTime,
    };
