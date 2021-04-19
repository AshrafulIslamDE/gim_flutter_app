import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/data/repository/auth_repository.dart';
import 'package:customer/features/registration/model/sign_up_request.dart';
import 'package:customer/model/auth/login_response.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/networking/network_common.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/ui_constant.dart';
import 'model/otp_generation_request.dart';
import 'model/otp_verification_response.dart';

class OtpVerificationBloc extends BaseBloc {
  String _otp;

  String get otp => _otp;

  set otp(String value) {
    _otp = value;
    if (otp.length == 4)
      hasOTPEntered = true;
    else
      hasOTPEntered = false;
  }

  var _hasOTPEntered = false;

  get hasOTPEntered => _hasOTPEntered;

  set hasOTPEntered(value) {
    var previousValue = hasOTPEntered;
    _hasOTPEntered = value;
    if (previousValue != value) notifyListeners();
  }

  get buttonBgColor => _hasOTPEntered
      ? ColorResource.colorMariGold
      : ColorResource.marigold_alpha;

  get buttonTextColor => _hasOTPEntered
      ? ColorResource.colorMarineBlue
      : ColorResource.colorMarineBlueAlpha;

  verifyOtp({String mobile}) async {
    var request = OtpVerificationRequest(
        mobile ?? RegistrationSingleton.instance.request.mobileNumber,
        int.parse(otp));
    var response = await AuthRepository.verifyOtp(request);
    return response;
  }
  saveUserInfo(LoginResponse loginResponse)async{
    await Prefs.setString(Prefs.token, loginResponse.token);
    await Prefs.setString(Prefs.PREF_USER_MOBILE, loginResponse.mobileNumber);
    await Prefs.setInt(Prefs.ROLE_ID, loginResponse.roleId);
    await Prefs.setInt(Prefs.USER_ID, loginResponse.id);
    await Prefs.setBoolean(Prefs.IS_APPROVED_USER, false);
    await Prefs.setBoolean(Prefs.PREF_IS_ENTERPRISE_USER, loginResponse?.userRoles[0]?.enterprise);
    NetworkCommon.instance.initConfig();

  }
  verifyOtpApp({String mobile}) async {
    var request = OtpVerificationRequest(
        mobile ?? RegistrationSingleton.instance.request.mobileNumber,
        int.parse(otp),
        signUp: false);
    print("request:"+request.toJson().toString());
    var response = await AuthRepository.verifyOtpApp(request);
    if (response.status == Status.COMPLETED) {
      if (response.data is int) Prefs.setInt(Prefs.USER_ID, response.data);
    }
    return response;
  }

  resendOtp({String mobile, bool signUp=true}) async {
    var request = OtpGenerationRequest(
        mobile ?? RegistrationSingleton.instance.request.mobileNumber,
        signUp: signUp);
    print(request.mobileNumber);
    var response = await AuthRepository.generateOtp(request);
    return response;
  }
}
