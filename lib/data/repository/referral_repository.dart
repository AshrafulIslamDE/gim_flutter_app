import 'dart:convert';

import 'package:customer/model/base.dart';
import 'package:customer/model/referral/referral_history_response.dart';
import 'package:customer/model/referral/referral_response.dart';
import 'package:customer/networking/api_response.dart';

class ReferralRepository{

  static var helper = ApiBaseHelper();

  static Future<ApiResponse> getMyEarning(query) async {
    ApiResponse response = await helper.get("/v1/customer/myearnings", queryParameters: query);
   // return getReferralEarningDummyData();
    return response;
  }

  static Future<ApiResponse> getMyreferral(query) async {
    ApiResponse response =
    await helper.get("/v1/customer/myreferral",queryParameters: query);
    //  return getReferralDataDummyData();
    return response;
  }

  static Future<ApiResponse> sendReferralInvitation(request) async {
    ApiResponse response = await helper.post("/v1/customer/sendreferral", request);
    return response;
  }

  static getReferralDataDummyData(){
    // 1574585100000
    Referral referral=Referral.instance(1574585100000, "01811228526", 1574585100000, 5);
    List<Referral>referralList=[];
    for (int i=0;i<2;i++)
      referralList.add(referral);
    ReferralResponse referralResponse=ReferralResponse.counter(10,15,16);
    referralResponse.filteredReferrals=BasePagination<Referral>.instance(referralList,5,100,2);
    //print("dummy:"+jsonDecode(jsonEncode(referralResponse)).toString());
    return ApiResponse.completed(jsonDecode(jsonEncode(referralResponse)), "Successful");
  }

  static getReferralEarningDummyData(){
    // 1574585100000
    ReferralHistoryItem referral=ReferralHistoryItem.instance(rewardAmount: 105900.0,paidAmount: 189150.0,paymentDate:1574585100070,
        rewardDate: 1574585100004,rewardMessage:"Successful Transaction ",rewardReason: "Ashraf\n01811229876", transactionId: "50040" );
    List<ReferralHistoryItem>referralList=[];
    for (int i=0;i<10;i++)
      referralList.add(referral);
    ReferralHistoryResponse referralResponse=ReferralHistoryResponse.counter(1890700.78,1809897.00,1989000.345);
    referralResponse.filteredUserEarnings=BasePagination<ReferralHistoryItem>.instance(referralList,100,100,2);
    //print("dummy:"+jsonDecode(jsonEncode(referralResponse)).toString());
    return ApiResponse.completed(jsonDecode(jsonEncode(referralResponse)), "Successful");
  }

  static Future<ApiResponse> getNotificationList(queryParam) async {
    ApiResponse response =
    await helper.get("/v1/notification/notifications",queryParameters: queryParam);
    return response;
  }
}