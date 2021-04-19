import 'package:flutter/material.dart';
enum Flavor {
  DEV,
  QA,
  STAGING,
  PRODUCTION,
  QA_TEST
}

String  getFlavor(int index){
  switch(index){
    case 0:return "DEV";
    case 1: return "QA";
    case 2: return "STAGING";
    case 3: return "PRODUCTION";
    case 4: return "QA_TEST";
  }
}

class FlavorValues {
  FlavorValues({@required this.baseUrl,this.API_URL,this.TERMS, this.TERMS_BANGLA,this.PRIVACY,this.PRIVACY_BANGLA,
    this.HELP_CENTER,this.HELP_CENTER_BANGLA, this.ABOUT_US,this
        .ABOUT_US_BANGLA, this
        .SHARE_URL, this.GOOGLE_API_KEY,this.CUSTOMER_PAY_URL,this.CUSTOMER_INVITE_URL, this.PARTNER_INVITE_URL, this.APP_PACKAGE = 'com.ejogajog.serviceseeker', this.PARTNER_APP_PACKAGE = 'com.ejogajog.partner'}){}
  final String baseUrl;
  final String API_URL;
  final String TERMS;
  final String TERMS_BANGLA;
  final String PRIVACY;
  final String PRIVACY_BANGLA;
  final String HELP_CENTER;
  final String HELP_CENTER_BANGLA;
  final String ABOUT_US;
  final String ABOUT_US_BANGLA;
  final String SHARE_URL;
  final String GOOGLE_API_KEY;
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final String CUSTOMER_INVITE_URL;
  final String PARTNER_INVITE_URL;
  final String APP_PACKAGE;
  final String PARTNER_APP_PACKAGE;
  final String CUSTOMER_PAY_URL;
}

class FlavorConfig {
  final Flavor flavor;
  final FlavorValues values;
  static FlavorConfig _instance;

  factory FlavorConfig({
    @required Flavor flavor,
    @required FlavorValues values}) {
    _instance ??= FlavorConfig._internal(flavor, values);
    return _instance;
  }

  FlavorConfig._internal(this.flavor,  this.values);
  static FlavorConfig get instance { return _instance;}
  static bool isProduction() => _instance.flavor == Flavor.PRODUCTION;
  static bool isDevelopment() => _instance.flavor == Flavor.DEV;
  static bool isQA() => _instance.flavor == Flavor.QA;
}