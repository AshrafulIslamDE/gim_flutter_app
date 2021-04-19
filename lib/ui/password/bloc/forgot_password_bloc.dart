import 'dart:io';

import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/data/repository/auth_repository.dart';
import 'package:customer/features/registration/model/otp_generation_request.dart';
import 'package:customer/model/password/dob_nid_request.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/validationUtils.dart';

class ForgotPasswordBloc extends BaseBloc {
  bool isValidated = false;
  int _roleId;
  String password;

  ForgotPasswordBloc() {
    _roleId = Prefs.getIntWithDefValue(Prefs.ROLE_ID, defaultValue: AppConstants.customerRoleId);
  }

  get buttonBgColor =>
      isValidated ? ColorResource.colorMariGold : ColorResource.marigold_alpha;

  get buttonTextColor => isValidated
      ? ColorResource.colorMarineBlue
      : ColorResource.colorMarineBlueAlpha;

  validate(String values) {
    RegExp regex = RegExp(MOBILE_NUMBER_REGEX_0);
    if (!regex.hasMatch(values)) {
      isValidated = false;
      notifyListeners();
      return;
    }
    isValidated = true;
    notifyListeners();
  }

  requestOtpApp({String mobNum}) async {
    isLoading = true;
    ApiResponse response = await AuthRepository.generateOtp(
        OtpGenerationRequest(mobNum, signUp: false, roleId: _roleId));
    isLoading = false;
    return response;
  }

  updatePassword(uId) async {
    isLoading = true;
    ApiResponse response = await AuthRepository.updatePassword(DobNidRequest(deviceToken : Prefs.getString(Prefs.PREF_DEVICE_TOKEN), deviceType : Platform.isIOS ? 'IOS' : 'ANDROID',roleId: _roleId, userId: uId, newPassword: password, confirmNewPassword: password));
    isLoading = false;
    return response;
  }

  validatePassword(String values) {
    RegExp regex = RegExp(PASSWORD_REGEX);
    if (!regex.hasMatch(values)) {
      isValidated = false;
      notifyListeners();
      return;
    }
    isValidated = true;
    notifyListeners();
  }

}
