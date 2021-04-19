import 'package:customer/networking/api_response.dart';

class TrackerRepo {
  static var helper = ApiBaseHelper();

  static Future<ApiResponse> getLocations() async {
    ApiResponse response =
    await helper.get('/v1/customer/truck/location');
    return response;
  }
}