import 'package:json_annotation/json_annotation.dart';

part 'dob_nid_request.g.dart';

@JsonSerializable()
class DobNidRequest {
  var deviceToken;
  var deviceType;
  var dob;
  var nationalId;
  var roleId = 5;
  var userId ;
  var newPassword;
  var confirmNewPassword;

  DobNidRequest({this.deviceToken, this.deviceType, this.roleId, this.userId = 0, this.dob, this.nationalId, this.newPassword, this.confirmNewPassword});

  Map<String, dynamic> toJson() => _$DobNidRequestToJson(this);
}
