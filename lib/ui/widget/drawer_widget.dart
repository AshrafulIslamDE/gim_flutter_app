import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/bloc/home/homebloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/ui/dashboard/dashboard_page.dart';
import 'package:customer/ui/dashboard/payment_page.dart';
import 'package:customer/ui/profile/profile_page.dart';
import 'package:customer/ui/referral/referral_screen.dart';
import 'package:customer/ui/webview/web_redirection_screen.dart';
import 'package:customer/utils/app_data_ui_utils.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'navigation_utils.dart';

class DrawerWidget extends StatefulWidget{

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  buildDrawerMenuItem(menuText, menuIcon, {onClick}) {
    var leadingIcon = menuIcon is String
        ? SvgPicture.asset(
      menuIcon,
      color: ColorResource.ColorDropOffBlue,
    )
        : Icon(
      menuIcon,
      color: ColorResource.ColorDropOffBlue,
      size: 30,
    );
    return ListTile(
      title: Align(
        child: Text(menuText),
        alignment: Alignment(-1.2, 0),
      ),
      leading: leadingIcon,
      onTap: () async {
        Navigator.pop(context);
        if (onClick != null) {
          onClick();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<HomeBloc>(context, listen: false).getProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Consumer<HomeBloc>(
            builder: (context, bloc, _) => DrawerHeader(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(children: [
                  getCircleImage(radius: 30, url: bloc.profileInfo?.pic),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                  width: 304.0 - 112.0,
                                  child: AutoSizeText(
                                      bloc.profileInfo.name ?? ' ',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: ColorResource.colorWhite),
                                      textAlign: TextAlign.left)),
                            ],
                          ),
                          AutoSizeText(
                            'Customer (${bloc?.profileInfo})'
                                .toUpperCase(),
                            style: TextStyle(
                                fontSize: 14, color: ColorResource.colorWhite),
                          )
                        ]),
                  )
                ]),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/account_switcher.webp'),
                      fit: BoxFit.fill)),
            ),
          ),
          buildDrawerMenuItem(
              translate(context, 'my_profile'), "svg_img/ic_profile.svg",
              onClick: () =>
                  navigateNextScreen(context, ProfilePageContainer())),
          buildDrawerMenuItem(
              translate(context, 'my_dashboard'), "svg_img/ic_dashboard.svg",
              onClick: () {
                // bloc.homePageIndex=4;
                // bloc.title=translate(context,'my_dashboard');
                navigateNextScreen(context, MyDashboardScreen());
              }),
          buildDrawerMenuItem(
              translate(context, 'referrals'), Icons.turned_in_not,
              onClick: () => navigateNextScreen(context, ReferralScreen())),
          buildDrawerMenuItem(
              translate(context, 'switch_lang'), "svg_img/ic_language.svg"),
          buildDrawerMenuItem('Legal', Icons.receipt, onClick: () {
            navigateNextScreen(
                context,
                WebRedirectionScreen(
                  title: 'Legal',
                  webViewUrl: FlavorConfig.instance.values.TERMS,
                ));
          }),
          buildDrawerMenuItem(
              translate(context, 'about_us'), "svg_img/ic_about_us.svg",
              onClick: () {
                navigateNextScreen(
                    context,
                    WebRedirectionScreen(
                      title: 'About Us',
                      webViewUrl: FlavorConfig.instance.values.ABOUT_US,
                    ));
              }),
          buildDrawerMenuItem(translate(context, 'help'), "svg_img/ic_help.svg",
              onClick: () {
                navigateNextScreen(
                    context,
                    WebRedirectionScreen(
                      title: 'Help',
                      webViewUrl: FlavorConfig.instance.values.HELP_CENTER,
                    ));
              }),
          buildDrawerMenuItem(
              translate(context, 'logout'), Icons.power_settings_new,
              onClick: () {
                showAlertWithDefaultAction(context,
                    title: translate(context, 'logout_dialog_title'),
                    content: translate(context, 'logout_dialog_content'),
                    positiveBtnTxt: translate(context, 'logout_positive_action'),
                    negativeButtonText:
                    translate(context, 'logout_negative_action'), callback: () {
                      logoutFromApp();
                    });
              }),
        ],
      ),
    );
  }
}