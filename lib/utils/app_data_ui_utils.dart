import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/data/local/db/app_database.dart';
import 'package:customer/data/local/db/database_controller.dart';
import 'package:customer/data/local/db/stats.dart';
import 'package:customer/data/repository/common_repository.dart';
import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/model/base.dart';
import 'package:customer/model/stats/stats_request.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';

import 'firebase_analytics_utils.dart';
import 'prefs.dart';

setTruckDimension({double length, double width, double height}) {
  if ((length == null && height == null && width == null) ||
      (length == 0.0 && width == 0.0 && height == 0.0))
    return localize('tdp_np_lbl');
  else {
    var anyText = localize('txt_any');
    String maintext;
    maintext = (length == null || length == 0.0 || length == 0)
        ? "L=$anyText"
        : "L=${getDimensionLocalizedValue(length)}";
    maintext += ", ";
    maintext += (width == null || width == 0.0 || width == 0)
        ? "W=$anyText"
        : "W=${getDimensionLocalizedValue(width)}";
    maintext += ", ";
    maintext += (height == null || height == 0.0 || height == 0)
        ? "H=$anyText"
        : "H=${getDimensionLocalizedValue(height)}";
    return maintext;
  }
}

getDimensionLocalizedValue(double value){
  return localize('number_decimal_count',dynamicValue:value.toString() ,symbol: '%f');
}

logoutFromApp({isNormalLogout=false})async {
  print('logout with user stats');

  if (isNormalLogout) {
    var requestList = UserTimeSpentRequestList(userAppTimeBatchs: List());
    AppDatabase localDb = await getDatabase();
    var list = await localDb.userTimeSpentDao.getAll();
    print('list size ${list.length}');

    if (list.isNotEmpty) {
      for (UserTimeSpent item in list) {
        if (item.timeOut == null) continue;
        requestList.userAppTimeBatchs.add(UserTimeSpent(item.timeIn, item
            .timeOut, item.date));
      }
    }

    await CommonRepository.logoutWithStats(requestList);
    FireBaseAnalytics().logEvent(AnalyticsEvents.SIGN_OUT,AnalyticsParams.USER_ROLE);
    Prefs.setString(Prefs.INVITE_REFERRAL_CODE, '');
  } else {
    FireBaseAnalytics().logEvent(AnalyticsEvents.SESSION_SIGN_OUT, null);
  }

  if(Prefs.getBoolean(Prefs.IS_LOGGED_IN,defaultValue: true)) {
    Future.delayed(const Duration(milliseconds: 550), () {
      FlavorConfig.instance.values.navigatorKey.currentState
          .pushNamedAndRemoveUntil(RouteConstants.authErrorRoute, (e) => false);
    });
  }
  Prefs.setBoolean(Prefs.IS_LOGGED_IN, false);
  Prefs.setBoolean(Prefs.IS_DISTRIBUTOR, false);
  Prefs.setBoolean(Prefs.PREF_IS_ENTERPRISE_USER, false);
}

Future<PackageInfo> getPackageInfo() async{
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo;

}

Widget setTrackerImageVisibility(BaseTrackerInfo item,{tintColor}){
  if(item==null||item.trackerAdded==null || item.trackerActivated==null)
    return Container();
  else if(item.trackerAdded && item.trackerActivated)
    return SvgPicture.asset('svg_img/ic_tracker_activated.svg',width: responsiveSize(15),color: tintColor,);
  else if(item.trackerAdded && !item.trackerActivated)
    return SvgPicture.asset('svg_img/ic_tracker_deactivated.svg',width: responsiveSize(15),color: tintColor,);

  return Container();
}

Widget setDistributorTagVisibility(BaseDistributor data,{iconSize=16.0}){
 // return SvgPicture.asset('svg_img/ic_distributor_label.svg',width: responsiveSize(14),);

  if(data!=null && data.distributor!=null && data.distributor){
   return SvgPicture.asset('svg_img/ic_distributor_label.svg',width: responsiveSize(iconSize),);
 }else
   return Container();
}