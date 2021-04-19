
import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/data/repository/auth_repository.dart';
import 'package:customer/utils/validationUtils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'model/otp_generation_request.dart';

class MobileVerificationBloc extends BaseBloc{

  var _isTermConditionAccepted=false;

  get isTermConditionAccepted => _isTermConditionAccepted;

  set isTermConditionAccepted(value) {
    _isTermConditionAccepted = value;
    notifyListeners();
  }

  var _mobileNumber="";

  get mobileNumber => _mobileNumber;

  set mobileNumber(value) {
    _mobileNumber = value;
    notifyListeners();
  }

  shouldActivateButton(){
    return _isTermConditionAccepted && isValidField(MOBILE_NUMBER_REGEX, mobileNumber);
  }
  verifyMobileNumber(String mobileNumber)async{
    var request= OtpGenerationRequest(mobileNumber);
    var response=await AuthRepository.generateOtp(request);
    return response;
  }
}