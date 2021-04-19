import 'dart:io';

import 'package:customer/model/auth/login_response.dart';
import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/model/password/dob_nid_request.dart';
import 'package:customer/networking/network_common.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/validationUtils.dart';
import 'package:flutter/foundation.dart';

import 'package:customer/data/local/db/district.dart';
import 'package:customer/data/repository/auth_repository.dart';
import 'package:customer/features/master/master_repository.dart';
import 'package:customer/features/registration/model/sign_up_request.dart';
import 'package:customer/networking/api_response.dart';

class NationalIdBloc extends BaseBloc{
   int _roleId;
   int _userId;
   String nidFrontSide;
   String nidBackSide;
   String dob;
   String name;
   String nidNumber;
   int districtId;
   bool isValidated = false;
   List<DistrictCode>_districts;//=[DistrictCode(0,"Please Select",null,null)];

   List<DistrictCode> get districts => _districts;

   NationalIdBloc(){
     Prefs.getInt(Prefs.ROLE_ID).then((roleId) {
       _roleId = roleId;
     });
     Prefs.getInt(Prefs.USER_ID).then((roleId) {
       _userId = roleId;
     });
   }

   set districts(List<DistrictCode> value) {
     _districts = value;
     notifyListeners();
   }

   loadDistrictData()async{
     districts=await MasterRepository.getAllDistrict();
   //  print("districtsize"+districts.length.toString());
   }

  DistrictCode findDistrictByName(String name){
     try {
       var code= districts.singleWhere((item) => item.text == name);
       return code;
     }catch(ex){print(ex.toString());}
     return null;
   }
   bool validateForm(Function(String) errorCallback){
     print(districtId);
     String validatedMessage="";
     if(dob==null||dob.isEmpty){
       validatedMessage='Date of Birth is required';
       errorCallback(validatedMessage);
       return false;
     }
    else if(nidFrontSide==null||nidFrontSide.isEmpty){
       validatedMessage='NID Front Side Photo is required';
       errorCallback(validatedMessage);
       return false;
     }

    else if(nidBackSide==null||nidBackSide.isEmpty){
       validatedMessage='NID Back Side Photo is required';
       errorCallback(validatedMessage);
       return false;
     }
     else if(districtId==null||districtId==0){
       validatedMessage='Select District';
       errorCallback(validatedMessage);
       return false;
     }
      return true;

    }

    signUp() async {
     ApiResponse  response= await AuthRepository.signUp( await buildSignUpRequest());
      switch(response.status){

        case Status.LOADING:
          break;
        case Status.COMPLETED:
          var loginResponse = LoginResponse.fromJson(response.data);
          print(loginResponse.name);
          await Prefs.setString(Prefs.token, loginResponse.token);
          await Prefs.setInt(Prefs.ROLE_ID, loginResponse.roleId);
          await Prefs.setBoolean(Prefs.IS_LOGGED_IN, true);
          await Prefs.setBoolean(Prefs.IS_APPROVED_USER, false);
          NetworkCommon.instance.initConfig();
          isNullOrEmpty(RegistrationSingleton.instance.request.referrelCode)?
          FireBaseAnalytics().logEvent(AnalyticsEvents.SIGN_UP_COMPLETE, null) : FireBaseAnalytics().logEvent(AnalyticsEvents.SIGN_UP_COMPLETE_WITH_REFERRAL, null);
          RegistrationSingleton.instance.request=SignUpRequest();
          break;
        case Status.ERROR:
          break;
      }
      return response;
    }

    buildSignUpRequest() async{
     var request=RegistrationSingleton.instance.request;
     request.nationalIdFrontPhoto=nidFrontSide;
     request.nationalIdBackPhoto=nidBackSide;
     request.name=name;
     request.dob=dob;
     request.nationalId=nidNumber;
     request.masterDistrictId=districtId;
     request.deviceToken= await Prefs.getFcmToken();
     print(request.masterDistrictId);
     print(request.nationalId);
     print("front"+request.nationalIdBackPhoto);
     print("back"+request.nationalIdBackPhoto);

     debugPrint('signuprequest:'+request.toJson().toString());
     return request;
    }

   get buttonBgColor => isValidated ? ColorResource.colorMariGold : ColorResource.marigold_alpha;
   get buttonTextColor => isValidated ? ColorResource.colorMarineBlue : ColorResource.colorMarineBlueAlpha;

   validate(String values) {
     RegExp regexNid = RegExp(NID_PASSPORT_REGEX);
     RegExp regexDob = RegExp(NOT_EMPTY_REGEX);
     if (!regexNid.hasMatch(values) || !regexDob.hasMatch(values)) {
       isValidated = false;
       notifyListeners();
       return;
     }
     isValidated = true;
     notifyListeners();
   }

   verifyDobNid() async {
     isLoading = true;
     ApiResponse response = await AuthRepository.verifyDobNid(DobNidRequest(deviceToken : Prefs.getString(Prefs.PREF_DEVICE_TOKEN), deviceType : Platform.isIOS ? 'IOS' : 'ANDROID',roleId: _roleId, userId: _userId, dob: dob, nationalId: nidNumber));
     isLoading = false;
     return response;
   }
}