import 'package:json_annotation/json_annotation.dart';

part 'application_status_response.g.dart';

@JsonSerializable()
class ApplicationStatus {
  int id;
  String value;

  ApplicationStatus({this.id});

  factory ApplicationStatus.fromJson(Map<String, dynamic> json) => _$ApplicationStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationStatusToJson(this);
}