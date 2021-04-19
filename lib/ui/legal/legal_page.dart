import 'dart:io';

import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/ui/legal/legal_bloc.dart';
import 'package:customer/ui/webview/load_local_html_file.dart';
import 'package:customer/ui/webview/local_html_file.dart';
import 'package:customer/ui/webview/web_redirection_screen.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LegalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LegalBloc>(
      create: (context) => LegalBloc(),
      child: LegalPage(),
    );
  }
}

class LegalPage extends StatefulWidget {
  @override
  _LegalScreenState createState() => _LegalScreenState();
}

class _LegalScreenState extends BasePageWidgetState<LegalPage, LegalBloc> {
  @override
  onBuildCompleted() => bloc.getVersionInfo();

  @override
  PreferredSizeWidget getAppbar() {
    return AppBarWidget(
      title: translate(context, 'legal'),
      shouldShowBackButton: false,
      shouldShowDivider: false,
      leadingWidget: GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: Icon(
            Icons.dehaze,
            color: ColorResource.colorMarineBlue,
          )),
    );
  }

  @override
  List<Widget> getPageWidget() {
    var isEnglish = Prefs.getStringWithDefaultValue(Prefs.language_code,
            defaultValue: "en") ==
        'en';

    return [
      Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Center(
              child: SvgPicture.asset(
            'svg_img/gim_logo_text.svg',
            width: 110,
            height: 110,
          )),
          Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
            child: Text(
              translate(context, 'txt_customer').toUpperCase(),
              style: TextStyle(
                  fontSize: 25,
                  color: ColorResource.colorMarineBlue,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Consumer<LegalBloc>(
              builder: (context, bloc, _) => Text(
                    localize('version') +
                        " " +
                        bloc.version +
                        (Platform.isIOS
                            ? '-' +
                                getFlavor(FlavorConfig.instance.flavor.index)
                            : ''),
                    style:
                        TextStyle(color: ColorResource.warm_grey, fontSize: 14),
                  )),
          SizedBox(
            height: 25.0,
          ),
          Divider(
            color: ColorResource.warm_grey,
          ),
          CustomButton(
            prefixIcon: SvgPicture.asset('svg_img/ic_hammer.svg'),
            text: translate(
              context,
              'privacy_policy',
            ),
            suffixIcon: Icon(
              Icons.arrow_forward_ios,
              color: ColorResource.warm_grey,
            ),
            textColor: ColorResource.warm_grey,
            isForwardButton: true,
            isRoundedCorner: false,
            drawablePadding: 10.0,
            borderColor: Colors.transparent,
            isAllCaps: false,
            onPressed: () => navigateNextScreen(
                context,
                WebRedirectionScreen(
                  title: translate(context, 'privacy_policy'),
                  webViewUrl: isEnglish
                      ? FlavorConfig.instance.values.PRIVACY
                      : FlavorConfig.instance.values.PRIVACY_BANGLA,
                ),
                pageName: ScreenView.PRIVACY),
          ),
          Divider(
            color: ColorResource.warm_grey,
          ),
          CustomButton(
            prefixIcon: SvgPicture.asset('svg_img/ic_hammer.svg'),
            text: translate(context, 'term_condition'),
            suffixIcon: Icon(
              Icons.arrow_forward_ios,
              color: ColorResource.warm_grey,
            ),
            textColor: ColorResource.warm_grey,
            isForwardButton: true,
            isRoundedCorner: false,
            drawablePadding: 10.0,
            borderColor: Colors.transparent,
            isAllCaps: false,
            onPressed: () => navigateNextScreen(
                context,
                WebRedirectionScreen(
                  title: translate(context, 'term_condition'),
                  webViewUrl: isEnglish
                      ? FlavorConfig.instance.values.TERMS
                      : FlavorConfig.instance.values.TERMS_BANGLA,
                ),
                pageName: ScreenView.TERMS),
          ),
          Divider(
            color: ColorResource.warm_grey,
          ),
          CustomButton(
            prefixIcon: SvgPicture.asset('svg_img/ic_hammer.svg'),
            text: translate(context, 'open_source_licenses'),
            suffixIcon: Icon(
              Icons.arrow_forward_ios,
              color: ColorResource.warm_grey,
            ),
            textColor: ColorResource.warm_grey,
            isForwardButton: true,
            isRoundedCorner: false,
            drawablePadding: 10.0,
            borderColor: Colors.transparent,
            isAllCaps: false,
            onPressed: () => navigateNextScreen(
                context,
                LocalHtmlFile(
                    title: translate(context, 'open_source_licenses'),
                    fileName: 'assets/licenses.html'),
                pageName: ScreenView.OS_LICENSE),
          ),
          Divider(
            color: ColorResource.warm_grey,
          ),
        ],
      )
    ];
  }
}
