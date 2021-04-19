import 'package:customer/model/trip/trip_id.dart';
import 'package:customer/networking/api_response.dart';

class TripDetailRepo{
  static var helper = ApiBaseHelper();

  static Future<ApiResponse> getTripDetail(query) async {
    ApiResponse response =
    await helper.get("/v1/trip/getTrip", queryParameters: query);
    return response;
  }

  static Future<ApiResponse> cancelTrip(int cancelReasonId, int tripId) async {
    ApiResponse response =
    await helper.post("/v1/customer/cancelTrip/$cancelReasonId", TripId(id: tripId).toJson());
    return response;
  }

}