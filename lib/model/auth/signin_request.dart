import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
part 'signin_request.g.dart';

@JsonSerializable()
class SignInRequest{
  String deviceToken;
  String deviceType = Platform.isAndroid?'ANDROID':'IOS';
  String mobileNum;
  String password;
  int roleId=5;
  SignInRequest({this.deviceToken,this.mobileNum,this.password});
  SignInRequest.internal();
  factory SignInRequest.fromJson(Map<String,dynamic>json)=>_$SignInRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);

}