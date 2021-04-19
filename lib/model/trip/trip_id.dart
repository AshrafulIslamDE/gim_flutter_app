import 'package:json_annotation/json_annotation.dart';

part 'trip_id.g.dart';

@JsonSerializable()
class TripId {
  int id;

  TripId({this.id});

  factory TripId.fromJson(Map<String, dynamic> json) => _$TripIdFromJson(json);
  Map<String, dynamic> toJson() => _$TripIdToJson(this);
}
