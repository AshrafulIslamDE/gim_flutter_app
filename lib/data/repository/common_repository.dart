import 'package:customer/networking/api_response.dart';

class CommonRepository {
  static var helper = ApiBaseHelper();

  static Future<ApiResponse> logout() async {
    ApiResponse response = await helper.get("/v1/common/logOut");
    return response;
  }

  // LogOut api that will also carry the user stats data to server when user
  // logs out
  static Future<ApiResponse> logoutWithStats(request) async {
    ApiResponse response = await helper.post("/v1/common/app/logOut", request);
    return response;
  }

  static Future<ApiResponse> serverTime() async {
    ApiResponse response =
        await helper.get("/v1/common/servertime");
    return response;
  }

  static Future<ApiResponse> appTime(request) async {
    ApiResponse response =
        await helper.post("/v1/common/user/apptime", request);
    return response;
  }
}