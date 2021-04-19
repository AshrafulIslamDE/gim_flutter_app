import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/data/repository/auth_repository.dart';
import 'package:customer/features/registration/model/sign_up_request.dart';
import 'package:customer/model/base.dart';
import 'package:customer/networking/api_response.dart';
import 'package:flutter/foundation.dart';

class PersonalInfoBloc extends BaseBloc{
  String password;
  String referralNumber;
  String email;
  bool verifyStatus=false;
  String referralCodeVerificationMsg="";

  verifyReferralNumber()async{
     RegistrationSingleton.instance.request.email=email;
     RegistrationSingleton.instance.request.referrelCode=referralNumber;
     RegistrationSingleton.instance.request.password=password;
     print("request"+RegistrationSingleton.instance.request.toJson().toString());
     if(referralNumber==null || referralNumber.isEmpty) {
       verifyStatus = true;
       return null;
     }
      ApiResponse response=await AuthRepository.verifyReferralCode( {'code':referralNumber});
      if(response.status==Status.COMPLETED){
        var statusResponse=StatusResponse.fromJson(response.data);
        verifyStatus=statusResponse.status;
      }
      else {
        verifyStatus = false;
        referralCodeVerificationMsg=response?.message;
      }

      return response;
  }
}