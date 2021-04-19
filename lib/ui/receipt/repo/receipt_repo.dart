import 'package:customer/networking/api_response.dart';

class ReceiptRepo {
  static var helper = ApiBaseHelper();

  static Future<ApiResponse> getCompletedTripDetail(int tripId) async {
    ApiResponse response =
        await helper.get("/v1/customer/completedtrip/$tripId");
    return response;
  }
}
