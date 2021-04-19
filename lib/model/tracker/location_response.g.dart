// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationResponse _$LocationResponseFromJson(Map<String, dynamic> json) {
  return LocationResponse()
    ..totalLiveTruck = json['totalLiveTruck'] as int
    ..totalTrackableTruck = json['totalTrackableTruck'] as int
    ..locations = (json['locations'] as List)
        ?.map((e) => e == null
            ? null
            : TruckLocations.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$LocationResponseToJson(LocationResponse instance) =>
    <String, dynamic>{
      'totalLiveTruck': instance.totalLiveTruck,
      'totalTrackableTruck': instance.totalTrackableTruck,
      'locations': instance.locations,
    };

TruckLocations _$TruckLocationsFromJson(Map<String, dynamic> json) {
  return TruckLocations()
    ..tripId = json['tripId'] as int
    ..truckId = json['truckId'] as int
    ..speed = (json['speed'] as num)?.toDouble()
    ..tripNo = json['tripNo'] as int
    ..updateTime = json['updateTime'] as int
    ..latitude = (json['latitude'] as num)?.toDouble()
    ..longitude = (json['longitude'] as num)?.toDouble()
    ..pickUplat = (json['pickUplat'] as num)?.toDouble()
    ..pickUplon = (json['pickUplon'] as num)?.toDouble()
    ..dropOfflat = (json['dropOfflat'] as num)?.toDouble()
    ..dropOfflon = (json['dropOfflon'] as num)?.toDouble()
    ..isAuthorized = json['isAuthorized'] as bool
    ..isTruckOnDuty = json['isTruckOnDuty'] as bool
    ..pickUpAddress = json['pickUpAddress'] as String
    ..dropOffAddress = json['dropOffAddress'] as String
    ..isTrackerAvailable = json['isTrackerAvailable'] as bool
    ..hasProblemInResponse = json['hasProblemInResponse'] as bool
    ..truckRegistrationNumber = json['truckRegistrationNumber'] as String;
}

Map<String, dynamic> _$TruckLocationsToJson(TruckLocations instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'truckId': instance.truckId,
      'speed': instance.speed,
      'tripNo': instance.tripNo,
      'updateTime': instance.updateTime,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'pickUplat': instance.pickUplat,
      'pickUplon': instance.pickUplon,
      'dropOfflat': instance.dropOfflat,
      'dropOfflon': instance.dropOfflon,
      'isAuthorized': instance.isAuthorized,
      'isTruckOnDuty': instance.isTruckOnDuty,
      'pickUpAddress': instance.pickUpAddress,
      'dropOffAddress': instance.dropOffAddress,
      'isTrackerAvailable': instance.isTrackerAvailable,
      'hasProblemInResponse': instance.hasProblemInResponse,
      'truckRegistrationNumber': instance.truckRegistrationNumber,
    };
