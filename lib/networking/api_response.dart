import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:customer/core/data/db/sqf_entity_provider.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/auth/login_screen.dart';
import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/model/base.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/app_data_ui_utils.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/rendering.dart';

import 'network_common.dart';
import 'package:dio/dio.dart';

class ApiResponse {
  Status status;
  var apiResponse;
  var data;
  String message;

  ApiResponse.loading(this.message,this.apiResponse) : status = Status.LOADING;
  ApiResponse.completed(this.data,this.message) : status = Status.COMPLETED;
  ApiResponse.error(this.message,this.apiResponse) : status = Status.ERROR;
  ApiResponse.unhandledError(this.message) : status = Status.ERROR;


  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $apiResponse";
  }
}

enum Status { LOADING, COMPLETED, ERROR }

class ApiBaseHelper {


  Future<ApiResponse> get(String url,{queryParameters=null}) async {
    var responseJson;
    checkInternetConnection();
    try {
      Response response = await NetworkCommon.instance.dio.get(url,
          queryParameters: queryParameters,
          options: _getResponseReturnOption());
      debugPrint("ApiResponse:"+response.toString());
      responseJson = _returnResponse(response);
    }catch( ex){
      return manageException(ex);
    }
    return responseJson;
  }


  Future<ApiResponse> post(String url,request,{isPut=false}) async {
    checkInternetConnection();
    var responseJson;
    print("requestparam:"+request.toString());
    try {
      Response response;
      if(!isPut)
       response = await NetworkCommon.instance.dio.post(url, data: request, options:_getResponseReturnOption());
      else
        response = await NetworkCommon.instance.dio.put(url, data: request, options:_getResponseReturnOption());

      responseJson = _returnResponse(response);
    }catch( ex){
     return manageException(ex);
    }
    return responseJson;
  }

  manageException( ex){
    //DioErrorType.RECEIVE_TIMEOUT
    var errorMessage=localize('something_went_wrong');
    try {
      if(DioErrorType.CONNECT_TIMEOUT==ex.type || DioErrorType.SEND_TIMEOUT==ex.type||
      DioErrorType.RECEIVE_TIMEOUT==ex.type)
            errorMessage="Connection timeout. Try again later";

        else if (DioErrorType.DEFAULT == ex.type) {
        if (ex.message.contains('SocketException'))
          errorMessage = localize('network_error_message');
      }
    }catch(ex){
      print(ex.toString());
    }

    return ApiResponse.unhandledError(errorMessage);
  }
  checkInternetConnection() async {
    var connection= await Connectivity().checkConnectivity();
    if(connection.index==ConnectivityResult.none.index )
      showCustomSnackbar(localize('network_error_message'),bgColor: ColorResource.pink_red);
  }
  _getResponseReturnOption(){
   return Options(
        followRedirects: false,
        validateStatus: (status){return true;}
    );
  }

  ApiResponse _returnResponse(Response response) {
    BaseResponse baseResponse;
    try {
       //response.data="lh<sg>";
       baseResponse = BaseResponse.fromJson(response.data);
    }catch( ex){
      return manageException(ex);
    }
    switch (response.statusCode) {
    case 200:
        return ApiResponse.completed(response.data['data'],baseResponse.message);
      case 401:
        logoutFromApp();
        return ApiResponse.error(baseResponse.message,response.data);
        break;

      case 400:
      case 403:
      case 404:
      case 500:
      default:
        return ApiResponse.error(baseResponse.message,response.data);
    }
  }
}


