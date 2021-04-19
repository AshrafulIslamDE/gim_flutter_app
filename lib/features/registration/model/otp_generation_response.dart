import 'package:json_annotation/json_annotation.dart';
part 'otp_generation_response.g.dart';

@JsonSerializable()
class OtpGenerationResponse {

  OtpGenerationResponse();
  bool popUp;
  bool driver;
  int roleId;
  bool otpVerified;
  bool smartphonePromptRequired;
  int smartphoneStatus;
  bool partnerAndDriver;
  int id;
  bool twoStep;
  int roleStatus;
  factory OtpGenerationResponse.fromJson(Map<String,dynamic>json)=>_$OtpGenerationResponseFromJson(json);
}
