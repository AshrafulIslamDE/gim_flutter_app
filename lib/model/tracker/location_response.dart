import 'package:json_annotation/json_annotation.dart';

part 'location_response.g.dart';

@JsonSerializable()
class LocationResponse {
  int totalLiveTruck;
  int totalTrackableTruck;
  List<TruckLocations> locations;

  LocationResponse();

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseFromJson(json);
}

@JsonSerializable()
class TruckLocations {
  int tripId;
  int truckId;
  double speed;
  int tripNo;
  int updateTime;
  double latitude;
  double longitude;
  double pickUplat;
  double pickUplon;
  double dropOfflat;
  double dropOfflon;
  bool isAuthorized;
  bool isTruckOnDuty;
  String pickUpAddress;
  String dropOffAddress;
  bool isTrackerAvailable;
  bool hasProblemInResponse;
  String truckRegistrationNumber;

  TruckLocations();

  factory TruckLocations.fromJson(Map<String, dynamic> json) =>
      _$TruckLocationsFromJson(json);

  @override
  String toString() {
    return truckRegistrationNumber;
  }
}
