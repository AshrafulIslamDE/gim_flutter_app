import 'package:json_annotation/json_annotation.dart';

part 'profile_update_request.g.dart';

@JsonSerializable()
class EditProfileRequest {

  EditProfileRequest();

  int roleId = 0;
  String dob;
  String email;
  String name;
  String profilePhoto;
  String location;
  String nationalId;
  String nationalIdBackPhoto;
  String nationalIdFrontPhoto;
  int smartphoneStatus;
  int district;
  String bkashNumber;
  String referralCode;

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) => _$EditProfileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EditProfileRequestToJson(this);

}
