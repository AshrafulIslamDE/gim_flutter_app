import 'package:customer/core/localization/AppTranslationsDelegate.dart';
import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/ui/widget/platform_specific_widget.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/route.dart' as Route;
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends PlatformSpecificWidget<CupertinoApp, MaterialApp> {
  final Widget home;
  final AppTranslationsDelegate newLocaleDelegate;
  FireBaseAnalytics analytics = FireBaseAnalytics();

  AppWidget({this.home, this.newLocaleDelegate});

  @override
  MaterialApp androidWidget(BuildContext context) {
    return MaterialApp(
      // key:key,
      navigatorKey: FlavorConfig.instance.values.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          dialogBackgroundColor: Colors.white,
          primaryColor: ColorResource.colorPrimary,
          fontFamily: 'roboto'),
      onGenerateRoute: Route.Router.generateRoute,
      navigatorObservers: [
        analytics.analyticObserver,
      ],
      home: home,
      localizationsDelegates: [
        newLocaleDelegate,
        const AppTranslationsDelegate(),
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }

  @override
  CupertinoApp iosWidget(BuildContext context) {
    analytics = FireBaseAnalytics();
    return CupertinoApp(
      // key: key,
      /*theme: CupertinoThemeData(textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(fontFamily: 'roboto')
      )),*/
      navigatorKey: FlavorConfig.instance.values.navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Route.Router.generateRoute,
      navigatorObservers: [
        analytics.analyticObserver,
      ],
      home: home,
      localizationsDelegates: [
        newLocaleDelegate,
        const AppTranslationsDelegate(),
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
