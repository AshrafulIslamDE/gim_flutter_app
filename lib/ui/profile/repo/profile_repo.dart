import 'package:customer/model/profile/profile_update_request.dart';
import 'package:customer/networking/api_response.dart';

class ProfileRepo{
  static var helper = ApiBaseHelper();

  static Future<ApiResponse> getProfile(String roleId) async {
    ApiResponse response =
    await helper.get("/v1/user/profile/$roleId");
    return response;
  }

  static Future<ApiResponse> validateReferralCode(referralCode) async {
    ApiResponse response =
    await helper.get("/v1/auth/referral", queryParameters: referralCode);
    return response;
  }

  static Future<ApiResponse> updateProfile(EditProfileRequest epr) async {
    ApiResponse response =
    await helper.post("/v1/user/update/personalInfo", epr.toJson());
    return response;
  }

}