import 'package:customer/bloc/home/homebloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/data/repository/notification_repository.dart';
import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/model/notifications/notification_sound_enable_request.dart';
import 'package:customer/networking/network_common.dart';
import 'package:customer/ui/webview/web_redirection_screen.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/ui/widget/switch_widget.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/app_data_ui_utils.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../my_app.dart';

class HomeDrawerMenu {
  BuildContext context;

  HomeDrawerMenu(this.context);

  List<Widget> constructMenu(HomeBloc bloc) {
    return [
      buildDrawerMenuItem(localize('my_profile'), "svg_img/ic_profile.svg",
          onClick: () {
        bloc.homePageIndex = 3;
        bloc.title = localize('my_profile');
      }),
      buildDrawerMenuItem(localize('my_dashboard'), "svg_img/ic_dashboard.svg",
          onClick: () {
        bloc.homePageIndex = 4;
        bloc.title = localize('dashboard');
        //  navigateNextScreen(context, MyDashboardScreen());
      }),
      buildDrawerMenuItem(
          localize('notification_sound'), 'svg_img/ic_hammer.svg',
          trailingIcon: getNotificationSoundSwitchWidget()),
      Visibility(
        visible: true,
        child: buildDrawerMenuItem(
            localize('referrals'), 'svg_img/ic_bookmark.svg', onClick: () {
          bloc.homePageIndex = 5;
          bloc.title = localize('referrals');
        }),
      ),
      if (Prefs.getBoolean(Prefs.IS_PAY_ID, defaultValue: false) &&
          isRegularUser())
        buildDrawerMenuItem(localize('payment'), "svg_img/pay.svg",
            onClick: () {
          bloc.homePageIndex = 6;
          bloc.title = localize('payment');
        }),
      buildDrawerMenuItem(localize('switch_lang'), "svg_img/ic_language.svg",
          onClick: () => changeAppLanguage()),
      buildDrawerMenuItem(localize('legal'), 'svg_img/ic_legal.svg',
          onClick: () {
        bloc.homePageIndex = 7;
        bloc.title = localize('legal');
      }),
      buildDrawerMenuItem(localize('about_us'), "svg_img/ic_about_us.svg",
          onClick: () {
        var lang = Prefs.getStringWithDefaultValue(Prefs.language_code,
            defaultValue: "en");
        var url = lang == 'en'
            ? FlavorConfig.instance.values.ABOUT_US
            : FlavorConfig.instance.values.ABOUT_US_BANGLA;

        navigateNextScreen(
            context,
            WebRedirectionScreen(
              title: localize('about_us'),
              webViewUrl: url,
            ), pageName: ScreenView.ABOUT_US);
      }),
      buildDrawerMenuItem(localize('help'), "svg_img/ic_help.svg", onClick: () {
        var lang = Prefs.getStringWithDefaultValue(Prefs.language_code,
            defaultValue: "en");
        var url = lang == 'en'
            ? FlavorConfig.instance.values.HELP_CENTER
            : FlavorConfig.instance.values.HELP_CENTER_BANGLA;

        navigateNextScreen(
            context,
            WebRedirectionScreen(
              title: localize('help'),
              webViewUrl: url,
            ), pageName: ScreenView.HELP_CENTER);
      }),
      buildDrawerMenuItem(localize('logout'), 'svg_img/ic_logout.svg',
          onClick: () {
        showAlertWithDefaultAction(context,
            title: localize('logout_dialog_title'),
            positiveBtnTxt: localize('yes').toUpperCase(),
            negativeButtonText: localize('no').toUpperCase(), callback: () {
          logoutFromApp(isNormalLogout: true);
        });
      }),
    ];
  }

  Widget getNotificationSoundSwitchWidget() {
    var soundValue = Prefs.getBoolean(
        Prefs.PREF_IS_NOTIFICATIONS_SOUND_ACTIVATED,
        defaultValue: true);
    // print('SoundValue: ${soundValue}');
    return SwitchWidget(
      activeColor: ColorResource.colorMariGold,
      onChangedValue: (value) async {
        await Prefs.setBoolean(
            Prefs.PREF_IS_NOTIFICATIONS_SOUND_ACTIVATED, value);
        NotificationRepository.changeNotificationSound(
            NotificationSoundEnableRequest(sound: value));
      },
      defaultValue: soundValue,
    );
  }

  Widget buildDrawerMenuItem(menuText, menuIcon,
      {onClick, Widget trailingIcon}) {
    var leadingIcon = menuIcon is String
        ? SvgPicture.asset(
            menuIcon,
            color: ColorResource.colorFadedBlue,
            width: responsiveSize(20),
          )
        : Icon(
            menuIcon,
            color: ColorResource.colorFadedBlue,
            size: responsiveSize(20),
          );
    var padding = 16.0;
    return GestureDetector(
      onTap: () async {
        try {
          Navigator.pop(context);
        } catch (ex) {
          print(ex);
        }
        if (onClick != null) {
          onClick();
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: padding, right: padding, top: padding, bottom: padding),
        child: Row(
          children: <Widget>[
            leadingIcon,
            SizedBox(
              width: padding,
            ),
            trailingIcon == null
                ? Expanded(
                    child: Text(
                    menuText,
                    style: TextStyle(fontSize: responsiveTextSize(14.0)),
                  ))
                : Text(
                    menuText,
                    style: TextStyle(fontSize: responsiveTextSize(14.0)),
                  ),
            SizedBox(
              width: padding,
            ),
            trailingIcon ?? Container(),
          ],
        ),
      ),
    );
    return ListTile(
      title: Align(
        child: Text(
          menuText,
          style: TextStyle(fontSize: responsiveTextSize(14.0)),
        ),
        //alignment: Alignment(trailingIcon==null?-1.2:-2.5, 0),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: responsiveSize(16.0)),
      leading: leadingIcon,
      trailing: trailingIcon,
      onTap: () async {
        Navigator.pop(context);
        if (onClick != null) {
          onClick();
        }
      },
    );
  }

  changeAppLanguage() async {
    String currentLocale = Prefs.getStringWithDefaultValue(Prefs.language_code,
        defaultValue: "en");
    print("old_locale: ${currentLocale}");
    var newLocale = currentLocale == "bn" ? "en" : "bn";
    print("locale: $newLocale");
    await Prefs.setString(Prefs.language_code, newLocale);
    NetworkCommon.instance.initConfig();
    MyApp.restartApp(context, languageCode: newLocale);
  }

  bool isRegularUser() => !Prefs.getBoolean(Prefs.PREF_IS_ENTERPRISE_USER);
}
