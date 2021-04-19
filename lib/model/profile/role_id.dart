import 'package:json_annotation/json_annotation.dart';

part 'role_id.g.dart';

@JsonSerializable()
class RoleId {
  int id;

  RoleId({this.id});

  factory RoleId.fromJson(Map<String, dynamic> json) => _$RoleIdFromJson(json);
  Map<String, dynamic> toJson() => _$RoleIdToJson(this);
}