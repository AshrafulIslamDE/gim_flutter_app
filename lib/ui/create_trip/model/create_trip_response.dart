import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'create_trip_response.g.dart';

@JsonSerializable()
class CreateTripResponse {
  CreateTripResponse();

  int tripId;
  int tripNumber;

  factory CreateTripResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateTripResponseFromJson(json);
}
