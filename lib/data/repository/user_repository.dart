import 'package:customer/model/profile/role_id.dart';
import 'package:customer/networking/api_response.dart';

class UserRepository {
  static var helper = ApiBaseHelper();

  static Future<ApiResponse> getProfileInfo() async {
    ApiResponse response = await helper.get("/v1/user/profile/5");
    return response;
  }

  static Future<ApiResponse> getUserStatus(id) async {
    ApiResponse response =
        await helper.post("/v1/user/getApplicationStatus", RoleId(id: id).toJson());
    return response;
  }

  static Future<ApiResponse> invoiceActivated() async {
    ApiResponse response = await helper.get("/v1/customer/invoiceactivated");
    return response;
  }
  static Future<ApiResponse> updateFcmToken(request) async {
    ApiResponse response = await helper.post("/v1/user/updateDeviceToken",request,isPut: true);
    return response;
  }


}
