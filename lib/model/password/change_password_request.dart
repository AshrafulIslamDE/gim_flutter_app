
import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePassWordRequest{

  ChangePassWordRequest({this.oldPass, this.newPass});

  String oldPass;
  String newPass;

  factory ChangePassWordRequest.fromJson(Map<String, dynamic> json) => _$ChangePassWordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePassWordRequestToJson(this);


}