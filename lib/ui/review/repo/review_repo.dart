import 'package:customer/networking/api_response.dart';

class ReviewRepo{
  static var helper = ApiBaseHelper();

  static Future<ApiResponse> getCompletedTripDetail(int tripId) async {
    ApiResponse response =
    await helper.get("/v1/customer/completedtrip/$tripId");
    return response;
  }

  static Future<ApiResponse> submitRating(request) async {
    ApiResponse response =
    await helper.post("/v1/customer/rate",request);
    return response;
  }

  static Future<ApiResponse> getDriverReviews({queryParam}) async {
    ApiResponse response=await helper.get("/v1/customer/driverrating",queryParameters: queryParam);
    return response;
  }

  static Future<ApiResponse> getTruckReviews({queryParam}) async {
    ApiResponse response=await helper.get("/v1/customer/truckrating",queryParameters: queryParam);
    return response;
  }
}