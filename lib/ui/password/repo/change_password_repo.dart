import 'package:customer/model/password/change_password_request.dart';
import 'package:customer/networking/api_response.dart';

class ChangePasswordRepo{
  static var helper = ApiBaseHelper();

  static Future<ApiResponse> changePassword(ChangePassWordRequest cpr) async {
    ApiResponse response =
    await helper.post("/v1/common/changePassword",cpr.toJson());
    return response;
  }

}