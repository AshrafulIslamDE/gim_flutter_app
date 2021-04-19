import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/data/repository/auth_repository.dart';
import 'package:customer/model/auth/signin_request.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/networking/network_common.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/remote_config.dart';
import 'package:flutter/foundation.dart';

import '../../model/auth/login_response.dart';

class LoginScreenBloc extends BaseBloc {
  ApiResponse _loginResponse;

  ApiResponse get loginResponse => _loginResponse;

  set loginResponse(ApiResponse value) {
    _loginResponse = value;
  }

  var mobileNumber="";
  var password="";

  signIn() async {
    isLoading = true;
    var deviceToken= await Prefs.getFcmToken();
    var response = await AuthRepository.signIn(SignInRequest(deviceToken: deviceToken,mobileNum: mobileNumber,password: password));
    loginResponse = response;
    isLoading = false;
    switch (response.status) {
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        var loginResponse = LoginResponse.fromJson(response.data);
        print(loginResponse.name);
        await Prefs.setString(Prefs.token, loginResponse.token);
        await Prefs.setString(Prefs.PREF_USER_MOBILE, mobileNumber);
        await Prefs.setInt(Prefs.ROLE_ID, loginResponse.roleId);
        await Prefs.setInt(Prefs.USER_ID, loginResponse.id);
        await Prefs.setBoolean(Prefs.IS_APPROVED_USER, isNullOrEmpty(loginResponse.getUserStatus() )|| loginResponse.isApprovedRoles());
        await Prefs.setBoolean(Prefs.PREF_IS_ENTERPRISE_USER, isEnterprise(loginResponse.userRoles));
        await Prefs.setBoolean(Prefs.IS_DISTRIBUTOR, loginResponse?.approvedDistributor);
        await FireBaseRemoteConfig.instance.setPaymentId(mobileNumber);
        NetworkCommon.instance.initConfig();
        break;
      case Status.ERROR:
        break;
    }
    return response;
  }
}
