import 'package:json_annotation/json_annotation.dart';

part 'otp_verification_response.g.dart';

@JsonSerializable()
class OtpVerificationRequest{
  OtpVerificationRequest(this.mobileNumber,this.otp,{this.signUp = true});
  var deviceToken="";
  var deviceType = "ANDROID";
  var mobileNumber="";
  var roleId = 5;
  int otp ;
  var signUp;
  Map<String, dynamic> toJson() => _$OtpVerificationRequestToJson(this);

}

@JsonSerializable()
class OtpVerificationResponse{
  var deviceToken="";
  var deviceType = "ANDROID";
  var mobileNumber="";
  var roleId = 5;
  var signUp = true;
  OtpVerificationResponse(this.mobileNumber);
  factory OtpVerificationResponse.fromJson(Map<String,dynamic>json)=>_$OtpVerificationResponseFromJson(json);
}