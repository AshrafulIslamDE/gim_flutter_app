import 'dart:async';

import 'package:customer/data/local/db/app_database.dart';
import 'package:customer/data/local/db/database_controller.dart';
import 'package:customer/data/local/db/master_data.dart';
import 'package:customer/data/local/db/truck_types.dart';
import 'package:customer/model/notifications/push_notification.dart';
import 'package:customer/utils/prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:customer/utils/image_utils.dart';

import 'network_common.dart';

typedef Future<T> FutureGenerator<T>();
int masterDataVersion=0;
String deviceToken;
Future<T> retryProcess<T>(int retries, FutureGenerator aFuture) async {
  try {
    return await aFuture();
  } catch (e) {
    print("retries"+retries.toString());
    if (retries > 0) {
      return retryProcess(retries - 1, aFuture);
    }else if(retries==0)return null;

    rethrow;
  }
}

Future doSometing() async {
  await Future.delayed(Duration(milliseconds: 500));
  return "Something";
}

 getMasterData() async {
  final r = RetryOptions(maxAttempts: 10);
  final Response response = await r.retry(
         () =>  NetworkCommon().dio.get('/v1/master/all') ,
     // Retry on SocketException or TimeoutException
     retryIf: (e) => e is Exception,
   );
 }

 Future<dynamic> prepareMasterData() async {
   var client=NetworkCommon();
   var response= await client.dio.get('/v1/master/all');
   if(response.statusCode!=200)
     throw Exception;
   else{
     processMasterData(response);
     return response.data;

   }

 }

Future<dynamic> updateDeviceToken() async {
  var client=NetworkCommon();
  var response= await client.dio.put("/v1/user/updateDeviceToken",data: UpdateFcmTokenRequest(deviceToken));
  if(response.statusCode!=200)
    throw Exception;
  else{
    return response.data;

  }

}

 processMasterData(Response response)async{
   var data=MasterDataResponse.fromJson(response.data['data']);
   AppDatabase localDb=await getDatabase();
   await localDb.truckTypeDao.deleteAll();
   await localDb.goodsTypeDao.deleteAll();
   await localDb.districtDao.deleteAll();
   await localDb.districtDao.insertAll(data.district);
   await localDb.goodsTypeDao.insertAll(data.goodTypes);
   await localDb.truckTypeDao.insertAll(data.truckTypes);
   await localDb.customerTripCancelReasonDao.insertAll(data.customerCancelTripReasons);
   await localDb.truckSizeDao.insertAll(data.truckSizes);
   await localDb.truckDimensionLengthDao.insertAll(data.truckDimensions.length);
   await localDb.truckDimensionWidthDao.insertAll(data.truckDimensions.width);
   await localDb.truckDimensionHeightDao.insertAll(data.truckDimensions.height);
   await Prefs.setInt(Prefs.pref_master_data_version, masterDataVersion);
 }

 getMasterDataUsingNativeProcess({master_data_version=0}) async {
   masterDataVersion=master_data_version;
  retryProcess(15, prepareMasterData);
 }
 updateFcmToken(token){
  deviceToken=token;
  retryProcess(15, updateDeviceToken);
 }
