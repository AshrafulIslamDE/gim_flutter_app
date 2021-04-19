import 'package:json_annotation/json_annotation.dart';
part 'otp_generation_request.g.dart';

@JsonSerializable()
class OtpGenerationRequest{
  var deviceToken="";
  var deviceType = "ANDROID";
  var mobileNumber="";
  var roleId;
  var signUp;
  OtpGenerationRequest(this.mobileNumber,{this.signUp = true, this.roleId = 5});
  Map<String, dynamic> toJson() => _$OtpGenerationRequestToJson(this);
}