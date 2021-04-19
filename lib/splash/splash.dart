import 'dart:async';
import 'dart:io';

import 'package:customer/ui/home/homepage.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/firebase_dynamiclink.dart';
import 'package:customer/utils/firebase_notifications.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:customer/utils/ui_constant.dart';
import 'package:customer/ui/onboard/onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    try {
      checkMasterDataVersion();
      FireBaseNotifications().setUpFireBase();
    } catch (exception) {
      print("exceptionsplash:" + exception);
      startTime();
    }
    isIos13();
  }

  checkMasterDataVersion() async {
    startTime();
    FireBaseRemoteConfig.instance.syncMasterData();
  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    var widget =
        await Prefs.getBool(Prefs.IS_LOGGED_IN) ? Home() : OnboardScreen();
    widget = widget == null ? OnboardScreen() : widget;
    if (Prefs.getString(Prefs.token) == null ||
        Prefs.getString(Prefs.token).isEmpty) widget = OnboardScreen();
    navigateNextScreen(context, widget, shouldReplaceCurrentPage: true);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: false);
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldState,
      body: Container(
          color: ColorResource.colorMarineBlue,
          child: Center(
            child: GestureDetector(
              child: Platform.isIOS
                  ? Image.asset('images/gim_logo.png')
                  : Image.asset('images/gim_logo.png', width: 96, height: 126),
              onTap: () => navigationPage(),
            ),
          )),
    );
  }
}
