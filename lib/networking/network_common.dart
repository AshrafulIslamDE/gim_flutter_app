import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/utils/prefs.dart';
import 'package:dio/dio.dart';
 class NetworkCommon {
  Dio _dio;

  Dio get dio => _dio;

  set dio(Dio value) {
    _dio = value;
  }

  static NetworkCommon _instance;

  static NetworkCommon get instance => NetworkCommon();

  NetworkCommon._internal(){initConfig();}

  factory NetworkCommon() {
    _instance ??= NetworkCommon._internal();
    return _instance;
  }

  initConfig(){
    dio = Dio();
    BaseOptions options = BaseOptions(
        baseUrl: FlavorConfig.instance.values.API_URL,
        receiveTimeout: 50000,
        connectTimeout: 30000,
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
     //   builder.addHeader("Accept-Language", language)

        headers: {'authtoken': getAuthToken(),"Accept-Language":languageCode
          (),'platform':Platform.isIOS ? 'ios' : 'android'}
    );
    dio = Dio(options);
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true,requestHeader: true));
  }
}

String getAuthToken(){
   print("authtoken method called");
   String token = Prefs.getString(Prefs.token);
   return token;

}

Future<bool> isOffline() async {
  var connection= await Connectivity().checkConnectivity();
  return connection.index==ConnectivityResult.none.index;
}