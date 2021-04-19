import 'package:customer/networking/api_response.dart';

class CreateTripRepo{
  static var  helper=ApiBaseHelper();
  static Future<ApiResponse>  createTrip(request) async{
    ApiResponse response=await helper.post("/v1/trip/createTrip",request);
    return response;
  }

  static Future<ApiResponse>  goodsType() async{
    ApiResponse response=await helper.get('/v1/enterprise/companygoodstypes');
    return response;
  }

  static Future<ApiResponse>  prodType() async{
    ApiResponse response=await helper.get('/v1/enterprise/producttype');
    return response;
  }

  static Future<ApiResponse>  distributors() async{
    ApiResponse response=await helper.get('/v1/enterprise/distributorslist');
    return response;
  }

  static Future<ApiResponse>  lcNumber(String lcNo) async{
    ApiResponse response=await helper.get('/v1/enterprise/lcnumber/search', queryParameters: {'lcNumber': lcNo});
    return response;
  }

}