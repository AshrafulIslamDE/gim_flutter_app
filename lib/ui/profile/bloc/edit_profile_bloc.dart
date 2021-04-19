import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/data/local/db/district.dart';
import 'package:customer/model/auth/login_response.dart';
import 'package:customer/features/master/master_repository.dart';
import 'package:customer/model/profile/profile_update_request.dart';
import 'package:customer/model/profile/referral_code_response.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/profile/repo/profile_repo.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/validationUtils.dart';
import 'package:flutter/foundation.dart';

class EditMyDetailsBloc extends BaseBloc {
  String image;
  String referralCode;
  int districtCode = 0;
  bool isEmailValid = true;
  bool isAlreadyValid = false;
  bool isReferralValid = true;

  LoginResponse userProfile;

  EditMyDetailsBloc({this.userProfile}) {
    isAlreadyValid = userProfile?.referrelCode?.length == 11;
    //loadDistricts();
  }

  set imageData(String img) {
    image = img;
  }

  _validateReferralCode(String refCode) async {
    isLoading = true;
    notifyListeners();
    ApiResponse apiResponse;

    try {
      apiResponse = await ProfileRepo.validateReferralCode({'code': refCode});
      if (apiResponse.status == Status.COMPLETED) {
        isReferralValid = IsReferralValid.fromJson(apiResponse.data).status;
        referralCode = isReferralValid ? refCode : null;
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      print(e.toString());
    }
    notifyListeners();
    return apiResponse;
  }

  updateProfile(String email) async {
    isLoading = true;
    notifyListeners();
    ApiResponse apiResponse;
    try {
      apiResponse = await ProfileRepo.updateProfile(getRequest(email));
      isLoading = false;
    } catch (e) {
      isLoading = false;
      print(e.toString());
    }
    notifyListeners();
    return apiResponse;
  }

  loadDistricts() async {
    await MasterRepository.getAllDistrict().then((districts) {
      for (DistrictCode dc in districts) {
        if (dc.text.compareTo(userProfile.district) == 0) {
          districtCode = dc.id;
        }
      }
    });
  }

  onReferralChange(String referral) {
    referralCode = null;
    isReferralValid = referral.isEmpty ? true : false;
    if (referral.isNotEmpty && referral.length == 11) {
      return _validateReferralCode(referral);
    }
    notifyListeners();
  }

  validateEmail(value) {
    RegExp regex = RegExp(EMAIL_REGEX);
    isEmailValid = value.isEmpty ? true : regex.hasMatch(value);
    notifyListeners();
  }

  EditProfileRequest getRequest(String email) {
    var epr = EditProfileRequest();
    epr.roleId = userProfile.roleId;
    epr.dob = userProfile.dob == null ? null : convertTimestampToDateTime(
        dateFormat: "yyyy-MM-dd", timestamp: userProfile.dob);
    epr.email = (email == null || email.isEmpty) ? null : email;
    epr.name = userProfile.name;
    epr.profilePhoto = image ?? "";
    epr.district = districtCode;
    epr.location = "";
    epr.nationalId = userProfile.nationalId;
    epr.nationalIdBackPhoto = "";
    epr.nationalIdFrontPhoto = "";
    epr.smartphoneStatus = 3;
    epr.referralCode = referralCode;
    epr.bkashNumber = null;
    return epr;
  }
}
