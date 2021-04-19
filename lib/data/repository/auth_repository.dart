import 'package:customer/model/auth/signin_request.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/networking/network_common.dart';

class AuthRepository {
  static var helper = ApiBaseHelper();

  static Future<ApiResponse> signIn(request) async {
    ApiResponse response = await helper.post("/v1/auth/signIn", request);
    return response;
  }

  static Future<ApiResponse> generateOtp(request) async {
    ApiResponse response =
        await helper.post("/v1/auth/generateOtpApp", request);
    return response;
  }

  static Future<ApiResponse> verifyOtp(request) async {
    ApiResponse response = await helper.post("/v1/auth/verifyOtp", request);
    return response;
  }

  static Future<ApiResponse> verifyOtpApp(request) async {
    ApiResponse response = await helper.post("/v1/auth/verifyOtpApp", request);
    return response;
  }

  static Future<ApiResponse> signUp(request) async {
    ApiResponse response = await helper.post("/v1/auth/signUp", request);
    return response;
  }

  static Future<ApiResponse> verifyReferralCode(queryparam) async {
    ApiResponse response =
        await helper.get("/v1/auth/referral", queryParameters: queryparam);
    return response;
  }

  static Future<ApiResponse> verifyDobNid(request) async {
    ApiResponse response =
        await helper.post("/v1/auth/verifyDobAndNid", request);
    return response;
  }

  static Future<ApiResponse> updatePassword(request) async {
    ApiResponse response =
        await helper.post("/v1/auth/updatePasswordApp?userId=${request.userId}", request);
    return response;
  }
}
