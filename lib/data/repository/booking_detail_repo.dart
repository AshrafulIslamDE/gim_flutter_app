import 'package:customer/model/trip/trip_id.dart';
import 'package:customer/networking/api_response.dart';

class TripDetailRepository{

  static var helper = ApiBaseHelper();

  static Future<ApiResponse> getBookedTripDetail(query) async {
    ApiResponse response =
    await helper.get("/v1/trip/getBookedTripDetails", queryParameters: query);
    return response;
  }

  static Future<ApiResponse> getRunningTripDetail(int tripId) async {
    ApiResponse response =
    await helper.get("/v1/customer/livetrip/$tripId");
    return response;
  }

  static Future<ApiResponse> getCompletedTripDetail(int tripId) async {
    ApiResponse response =
    await helper.get("/v1/customer/completedtrip/$tripId");
    return response;
  }

  static Future<ApiResponse> startTrip(int tripId) async {
    ApiResponse response =
    await helper.post("/v1/customer/startTrip", TripId(id: tripId).toJson());
    return response;
  }

  static Future<ApiResponse> cancelTrip(int cancelReasonId, int tripId) async {
    ApiResponse response =
    await helper.post("/v1/customer/cancelTrip/$cancelReasonId", TripId(id: tripId).toJson());
    return response;
  }

  static Future<ApiResponse> endTrip(int tripId) async {
    ApiResponse response =
    await helper.post("/v1/customer/endtrip",TripId(id: tripId).toJson());
    return response;
  }

}
