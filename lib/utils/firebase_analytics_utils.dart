import 'package:customer/utils/analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';

class FireBaseAnalytics {
  static final FireBaseAnalytics _fireBaseAnalytic =
      FireBaseAnalytics._internal();

  factory FireBaseAnalytics() {
    return _fireBaseAnalytic;
  }

  FireBaseAnalytics._internal() {
    _analytics = FirebaseAnalytics();
    _analyticsObserver = FirebaseAnalyticsObserver(analytics: _analytics);
  }

  FirebaseAnalytics _analytics;
  FirebaseAnalyticsObserver _analyticsObserver;

  get analyticObserver => _analyticsObserver;

  logSignUp() async {
    await _analytics.logSignUp(signUpMethod: "SignUp using mobile number.");
  }

  logLogin() async {
    await _analytics.logLogin();
  }

  screenViewEvent(eventName) async {
    await _analytics.setCurrentScreen(screenName: eventName, screenClassOverride: eventName);
  }

  logEvent(String eventName, Map<String, dynamic> param) async {
    debugPrint("Recording event $eventName");
    await _analytics.logEvent(
      name: eventName,
      parameters: param,
    );
  }

  logFilterDashboard(String fromDate, String toDate, String goodsType) {
    debugPrint("Recording event ${AnalyticsEvents.EVENT_FILTER_DASHBOARD} "
        "$fromDate $toDate $goodsType");
    var params = {AnalyticsParams.FROM_DATE: fromDate, AnalyticsParams
        .TO_DATE: toDate, AnalyticsParams.GOODS_TYPE: goodsType};
    logEvent(AnalyticsEvents.EVENT_FILTER_DASHBOARD, params);
  }

}
