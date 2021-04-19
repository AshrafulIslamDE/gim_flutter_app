
import 'package:customer/networking/api_response.dart';

class CustomerRepository {

  static var helper = ApiBaseHelper();

  static Future<ApiResponse> getDashboardTripList(query) async {
    ApiResponse response = await helper.get("/v1/customer/dashboard/trips", queryParameters: query);
    return response;
  }


  static Future<ApiResponse> getGoodsTypeList() async {
    ApiResponse response =
    await helper.get("/v1/customer/goodtypes");
    return response;
  }


}