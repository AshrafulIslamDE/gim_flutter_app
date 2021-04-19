import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/model/auth/login_response.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/profile/repo/profile_repo.dart';
import 'package:customer/utils/prefs.dart';

class ProfileBloc extends BaseBloc {
  LoginResponse _userProfile=LoginResponse();


  LoginResponse get userProfile => _userProfile;


  set usrProfile(LoginResponse profile) {
    _userProfile = profile;
  }

  getProfile(int roleId) async {
    isLoading=true;
    ApiResponse  apiResponse = await ProfileRepo.getProfile(roleId.toString());
     checkResponse(apiResponse,successCallback: () async {
       usrProfile = LoginResponse.fromJson(apiResponse.data);
       await Prefs.setBoolean(Prefs.PREF_IS_ENTERPRISE_USER, userProfile.isEnterpriseUser());
     });
     takeDecisionShowingError(apiResponse);
     return apiResponse;
  }
  bool isNormalUser()=> !Prefs.getBoolean(Prefs.PREF_IS_ENTERPRISE_USER);

  bool isDistributor() => Prefs.getBoolean(Prefs.IS_DISTRIBUTOR);

}
