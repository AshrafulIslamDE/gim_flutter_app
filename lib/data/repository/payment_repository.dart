
import 'package:customer/networking/api_response.dart';

class PaymentRepository {

  static var helper = ApiBaseHelper();

  static Future<ApiResponse> getPayment(query) async {
    ApiResponse response = await helper.get("/v1/customer/payments",
        queryParameters: query);
    return response;
  }

  static Future<ApiResponse> getDuePayment(query) async {
    ApiResponse response = await helper.get("/v1/customer/trippayments",
        queryParameters: query);
    return response;
  }

  static Future<ApiResponse> paymentComplete(paymentId,txnId) async {
    ApiResponse response =
    await helper.post("/v1/customer/bkashonline/complete",'{"paymentId":"$paymentId","trxId":"$txnId"}');
    return response;
  }

}