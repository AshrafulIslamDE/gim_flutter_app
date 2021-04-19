import 'package:customer/networking/api_response.dart';
import 'package:customer/utils/prefs.dart';

class NotificationRepository {

  static var helper = ApiBaseHelper();

  static Future<ApiResponse> getUnReadCount() async {
    ApiResponse response = await helper.get("/v1/notification/getUnReadCount/5");
    return response;
  }

  static Future<ApiResponse> markRead(request) async {
    ApiResponse response = await helper.post("/v1/notification/markRead",request);
    return response;
  }

  static Future<ApiResponse> getNotificationList(queryParam) async {
    ApiResponse response =
    await helper.get("/v1/notification/notifications",queryParameters: queryParam);
    return response;
  }

  static Future<ApiResponse> changeNotificationSound(request) async {
    ApiResponse response =
    await helper.post("/v1/notification/sound",request);
    return response;
  }

  static Future<ApiResponse> resetBadgeCount() async {
    ApiResponse response =
    await helper.post("/v1/notification/resetbadge",'{"roleId":${await Prefs.getInt(Prefs.ROLE_ID)}}', isPut: true);
    return response;
  }

}