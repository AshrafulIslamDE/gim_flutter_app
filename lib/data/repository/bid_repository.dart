
import 'package:customer/networking/api_response.dart';

class BidRepository{
  static var  helper=ApiBaseHelper();
  static Future<ApiResponse> acceptBid(request) async{
    ApiResponse response=await helper.post("/v1/customer/acceptBid",request);
    return response;
  }

  static Future<ApiResponse>  getBidLisOfTrip(query) async{
    ApiResponse response=await helper.get("/v1/customer/getListOfBidsForTrip",queryParameters: query);
    return response;
  }

  static Future<ApiResponse>  getBidDetails(queryParams) async{
    ApiResponse response=await helper.get("/v1/user/getBidDetails",queryParameters: queryParams);
    return response;
  }
  static Future<ApiResponse>  getBidStatus(queryParams) async{
    ApiResponse response=await helper.get("/v1/bid",queryParameters: queryParams);
    return response;
  }
}


/*
@POST("${Constants.API_VERSION}/customer/acceptBid")
fun acceptBid(@Body sendBidRequest: AcceptBidRequest): Call<BaseResponse<AcceptBidResponse>>

@GET("${Constants.API_VERSION}/customer/getListOfBidsForTrip")
fun listOfTripBids(@Query("tripId") tripId: Int, @Query("page") page: Int,
@Query("size") size: Int): Call<BaseResponse<TripBidsResponse>>
*/
