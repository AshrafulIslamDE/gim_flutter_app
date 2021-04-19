import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/ui/dashboard/transparent_route.dart';
import 'package:customer/ui/home/homepage.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

navigateNextScreen(BuildContext context, page,
    {bool shouldFinishPreviousPages = false,
    bool shouldReplaceCurrentPage = false, String pageName, Object arguments}) {
  hideSoftKeyboard(context);
  pageName = pageName ?? page.runtimeType.toString();
  if (!shouldFinishPreviousPages) {
    if (!shouldReplaceCurrentPage)
      return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => page,
              settings: RouteSettings(name: pageName, arguments: arguments))
      );
    else
      return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => page,
              settings: RouteSettings(name: pageName, arguments: arguments)));
  } else
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => page,
            settings: RouteSettings(name: pageName, arguments: arguments)),
        (e) => false);
}

navigateToScreen(name, {Object arg}) async {
  await getGlobalState().pushNamedAndRemoveUntil(RouteConstants.homeRoute, (e) => false);
  getGlobalState().pushNamed(name, arguments: arg);
}

navigateNextTransparentScreen(context, page,
    {bool shouldFinishPreviousPages = false,
    bool shouldReplaceCurrentPage = false}) {
  return Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) => page,
      settings: RouteSettings(name: page.runtimeType.toString())));
}
