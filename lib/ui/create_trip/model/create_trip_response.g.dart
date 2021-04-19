// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_trip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTripResponse _$CreateTripResponseFromJson(Map<String, dynamic> json) {
  return CreateTripResponse()
    ..tripId = json['tripId'] as int
    ..tripNumber = json['tripNumber'] as int;
}

Map<String, dynamic> _$CreateTripResponseToJson(CreateTripResponse instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'tripNumber': instance.tripNumber,
    };
