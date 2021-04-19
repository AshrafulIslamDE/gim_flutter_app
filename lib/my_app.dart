import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/core/localization/AppTranslationsDelegate.dart';
import 'package:customer/core/localization/Application.dart';
import 'package:customer/splash/splash.dart';
import 'package:customer/ui/widget/app_widget.dart';
import 'package:customer/utils/firebase_dynamiclink.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/stats_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();

  static restartApp(BuildContext context, {languageCode}) {
    final MyAppState state = context.findAncestorStateOfType<MyAppState>();
    state.restartApp(languageCode: languageCode);
  }
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  AppLifecycleState _appLifecycleState;
  AppTranslationsDelegate _newLocaleDelegate;
  FireBaseDynamicLink _fireBaseDynamicLink = FireBaseDynamicLink();
  String languageCode = "en";

  void restartApp({languageCode}) {
    this.setState(() {
      this.languageCode = languageCode ?? this.languageCode;
      _newLocaleDelegate =
          AppTranslationsDelegate(newLocale: Locale(languageCode));
      application.onLocaleChanged = onLocaleChange;
      //  key = new UniqueKey();
    });
  }

  @override
  void initState() {
    super.initState();
    initPreference();
    // ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
    //  connectionStatus.initialize();
    WidgetsBinding.instance.addObserver(this);
    _fireBaseDynamicLink.retrieveDynamicLink();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
       _appLifecycleState= state;

      if(state == AppLifecycleState.resumed) {
        print("didChangeAppLifecycleState resumed");
        getServerTime();
      }

       if(state == AppLifecycleState.paused) {
         print("didChangeAppLifecycleState paused");
         getServerTimeAndPostUserStats();
       }
    });
  }

  initPreference() async {
    _newLocaleDelegate =
        AppTranslationsDelegate(newLocale: Locale(getLanguageCode()));
    await Prefs.init();
    print('init');
    languageCode = Prefs.getStringWithDefaultValue(Prefs.language_code,
        defaultValue: "en");
    if (languageCode != null && languageCode == 'bd') languageCode = "bn";
    _newLocaleDelegate =
        AppTranslationsDelegate(newLocale: Locale(languageCode));
    application.onLocaleChanged = onLocaleChange;
    await AppTranslations.load(Locale(languageCode));
    print('init last line');
  }

  static String getLanguageCode() =>
      Prefs.getStringWithDefaultValue(Prefs.language_code, defaultValue: "en");

  @override
  Widget build(BuildContext context) {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    print('Crashlytics initialized');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorResource.colorMarineBlue,
      statusBarBrightness: Brightness.dark,
    ));
    return OverlaySupport(
        child: AppWidget(
      // key: key,
      home: SplashScreen(),
      newLocaleDelegate: _newLocaleDelegate,
    ));
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      print("setstate local");
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}
