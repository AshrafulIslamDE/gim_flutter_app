import 'package:customer/networking/api_response.dart';

class TripRepository{
   static var  helper=ApiBaseHelper();
   static Future<ApiResponse> getListOfUnbiddedTrips(queryMap) async{
     ApiResponse response=await helper.get("/v1/trip/getListOfUnbiddedTrips",queryParameters: queryMap);
     return response;
   }

   static Future<ApiResponse>  getBookedTripList(request) async{
     ApiResponse response=await helper.get("/v1/customer/getListOfBookedTrips",queryParameters: request);
     return response;
   }
   static Future<ApiResponse>  getTripList(queryParams) async{
     ApiResponse response=await helper.get("/v1/customer/requestedtrips",queryParameters: queryParams);
     return response;
   }
   static Future<ApiResponse>  getLiveTripList(request) async{
     ApiResponse response=await helper.get("/v1/customer/livetrips",queryParameters: request);
     return response;
   }

   static Future<ApiResponse>  getStatusOfRequestedTrips() async{
     ApiResponse response=await helper.get("/v1/customer/getStatusOfRequestedTrips");
     return response;
   }

   static Future<ApiResponse>  getCompletedTripList({queryParam}) async{
     ApiResponse response=await helper.get("/v1/customer/getListOfHistory",queryParameters: queryParam);
     return response;
   }

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


   static Future<ApiResponse> getTripStatus(queryParam) async {
     ApiResponse response = await helper.get("/v1/trip/getTrip",queryParameters: queryParam);
     return response;
   }
 }
 //customer/getStatusOfRequestedTrips