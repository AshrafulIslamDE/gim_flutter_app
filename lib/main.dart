import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'flavor/flavor_config.dart';
import 'my_app.dart';

void main() {
  FlavorConfig(
      flavor: Flavor.DEV,
      values: FlavorValues(
          baseUrl: "https://dev2.gim.com.bd",
          API_URL: 'https://dev2.gim.com.bd/ejogajog/api',
          TERMS: '/ejoga/#/term/mobile',
          PRIVACY: '/ejoga/#/privacy/mobile',
          HELP_CENTER: '/ejoga/#/help/mobile',
          ABOUT_US: 'ejoga/#/about?src=android'));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiProvider(
      providers: [],
      child: MyApp(),
    ));
  });
}

/*
class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    Prefs.init();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ColorResource.colorMarineBlue,
        statusBarBrightness: Brightness.dark
    ));
    return AppWidget(
      home: ScaffoldLayout(
        body: SplashScreen(),
      ),
      newLocaleDelegate: _newLocaleDelegate,
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}
*/
