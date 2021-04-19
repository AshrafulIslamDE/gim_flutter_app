import 'dart:io';

import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/auth/login_response.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/remote_config.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'firebase_analytics_utils.dart';

Future<void> initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
}

amountWithCurrencySign(amount, {shouldShowCurrencySign = true}) {
  var currencyFormat = NumberFormat("#,##0", languageCode());
  return (shouldShowCurrencySign ? "৳ " : "") +
      currencyFormat.format(amount).replaceAll("BDT", "").replaceAll("৳", "");
}

amountWithCurrencyFormatting(amount, {shouldShowCurrencySign = true}) {
  var currencyFormat = NumberFormat("#,##0.00", languageCode());
  return (shouldShowCurrencySign ? "৳ " : "") +
      currencyFormat.format(amount).replaceAll("BDT", "").replaceAll("৳", "");
}

bool isNullOrBlank(value) {
  return value == null || value == 0;
}

bool isNullOrEmpty(String value) {
  return value == null || value.trim().length == 0;
}

bool isNullOrEmptyList(List value) {
  return value == null || value.length == 0;
}

List<Widget> ratingWidget(double rating) {
  if(isNullOrBlank(rating)) return [Container()];
  int maxRating = 5;
  List<Widget> ratingWidget = List();
  int fillIndex = rating == null ? 0 : rating.toInt();
  for (int index = 0; index < fillIndex; index++) {
    ratingWidget.add(Icon(
      Icons.star,
      color: ColorResource.marigold_two,
      size: responsiveSize(20.0),
    ));
  }
  for (int index = fillIndex.isNegative ? 0 : fillIndex;
      index < maxRating;
      index++) {
    ratingWidget.add(Icon(Icons.star_border,
        color: ColorResource.marigold_two, size: responsiveSize(20.0)));
  }
  return ratingWidget;
}

String getInitialText(String nameString) {
  if (nameString == null || nameString.isEmpty) return " ";

  List<String> nameArray =
      nameString.trim().replaceAll(new RegExp(r"\s+\b|\b\s"), " ").split(" ");
  String initials = ((nameArray[0])[0] != null ? (nameArray[0])[0] : " ") +
      (nameArray.length == 1 ? " " : (nameArray[nameArray.length - 1])[0]);

  return initials;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

call(String urlString) {
  if (AppConstants.iSiOS13) return;
  try {
    UrlLauncher.canLaunch(urlString).then((canLaunch) {
      if (canLaunch) {
        UrlLauncher.launch(urlString);
        FireBaseAnalytics().logEvent(AnalyticsEvents.EVENT_CUSTOMER_SUPPORT_CALL, null);
      }
    });
  } on Exception catch (ex) {
    print(ex.toString());
  }
}

Future<bool> isIos13() async {
  if (Platform.isIOS) {
    IosDeviceInfo iosDevInfo = await DeviceInfoPlugin().iosInfo;
    try {
      AppConstants.iSiOS13 =
          int.parse(iosDevInfo.systemVersion.split('.')[0]) > 12;
    } on Exception catch (_) {
      print("Exeption in isNaIos13()");
    }
  } else
    AppConstants.iSiOS13 = false;
  return AppConstants.iSiOS13;
}

Future<bool> forceUpdate() async {
  var remoteAppVersion =
      await Prefs.getInt(FireBaseRemoteConfig.forceUpdateVersion);
  var currentAppVersion =
      int.parse((await PackageInfo.fromPlatform()).buildNumber);
  return remoteAppVersion > currentAppVersion;
}

Future<bool> optUpdate() async {
  var remoteAppVersion =
      await Prefs.getInt(FireBaseRemoteConfig.optUpdateVersion);
  var currentAppVersion =
      int.parse((await PackageInfo.fromPlatform()).buildNumber);
  return remoteAppVersion > currentAppVersion ? await _sinceLastCheck() : false;
}

Future<bool> _sinceLastCheck() async {
  var lastCheckTimestamp = await Prefs.getInt(Prefs.LAST_CHECK_DATE);
  if (lastCheckTimestamp == null) return true;
  var saveDate = DateTime.fromMillisecondsSinceEpoch(lastCheckTimestamp);
  var nowDate = DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().millisecondsSinceEpoch);
  return nowDate.difference(saveDate).inDays > 0;
}

launchURL(String url) async {
  if (await UrlLauncher.canLaunch(url)) {
    await UrlLauncher.launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

String toCamelCase(String input) {
  if (input == null || input.isEmpty) return input;
  return '${input[0].toUpperCase()}${input.substring(1).toLowerCase()}';
}

String toTitleCase(String str) {
  if (str == null || str.isEmpty) return str;
  return str.replaceAllMapped(RegExp(r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),(Match m) =>
      "${m[0][0].toUpperCase()}${m[0].substring(1).toLowerCase()}")
      .replaceAll(RegExp(r'(_|-)+'), ' ');
}

isEnterprise(List<UserRolesItem> userRoles){
  for(UserRolesItem uri in userRoles){
    if(uri.id == 5 && uri.enterprise) return true;
    continue;
  }
}

String formatTripDigits(int tripCompleted){
  var tripCount;
  if(tripCompleted > 100) tripCount = 100;
  else if(tripCompleted < 11) return '${localize('number_count', dynamicValue:tripCompleted.toString()).trim()}';
  else if(tripCompleted % 10 == 0) tripCount = tripCompleted - 10;
  else tripCount =  tripCompleted - (tripCompleted % 10);
  return '${localize('number_count', dynamicValue:tripCount.toString()).trim()}+';
}
