import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/ui/payment/b_cash_pay_offline.dart';
import 'package:customer/ui/payment/bloc/b_cash_opt_bloc.dart';
import 'package:customer/ui/webview/pay_screen.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BCashPayOpt extends StatelessWidget {
  final String amount;
  final String listOfTripId;

  BCashPayOpt(this.amount, {this.listOfTripId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BCashOptionBloc>(
            create: (_) => BCashOptionBloc(double.parse(amount).floor(), listOfTripId: listOfTripId)),
      ],
      child: BCashPayOption(),
    );
  }
}

class BCashPayOption extends StatefulWidget {
  @override
  _BCashPayOptionState createState() => _BCashPayOptionState();
}

class _BCashPayOptionState
    extends BasePageWidgetState<BCashPayOption, BCashOptionBloc> {
  @override
  PreferredSizeWidget getAppbar() => AppBarWidget(
        title: translate(context, 'payment').toUpperCase(),
        shouldShowBackButton: true,
      );

  @override
  List<Widget> getPageWidget() {
    return [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(translate(context, 'sel_b_kash'),
                    style: TextStyle(
                      color: ColorResource.colorMarineBlue,
                      fontSize: responsiveTextSize(14.0),
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(
                  height: responsiveSize(20.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: SizedBox(
                        width: Checkbox.width,
                        height: Checkbox.width,
                        child: Container(
                          decoration: new BoxDecoration(
                            border: Border.all(
                              width: 1,
                            ),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          child: Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.transparent,
                            ),
                            child: Checkbox(
                              value: bloc.payMode,
                              onChanged: (state) =>
                                  setState(() => bloc.paymentMode()),
                              activeColor: HexColor('00aa4b'),
                              checkColor: ColorResource.colorWhite,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: responsiveSize(10.0),
                    ),
                    Text(translate(context, 'b_kash_onl'),
                        style: TextStyle(
                          color: ColorResource.colorBrownGrey,
                          fontSize: responsiveTextSize(16.0),
                          fontFamily: "roboto",
                          fontWeight: FontWeight.w900,
                        )),
                  ],
                ),
                SizedBox(
                  height: responsiveSize(5.0),
                ),
                Padding(padding: EdgeInsets.only(left: responsiveSize(10.0)), child: Image.asset('images/b_kash_logo.png')),
                SizedBox(
                  height: responsiveSize(20.0),
                ),
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: SizedBox(
                        width: Checkbox.width,
                        height: Checkbox.width,
                        child: Container(
                          decoration: new BoxDecoration(
                            border: Border.all(
                              width: 1,
                            ),
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          child: Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.transparent,
                            ),
                            child: Checkbox(
                              value: !bloc.payMode,
                              onChanged: (state) =>
                                  setState(() => bloc.paymentMode()),
                              activeColor: HexColor('00aa4b'),
                              checkColor: ColorResource.colorWhite,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: responsiveSize(10.0),
                    ),
                    Text(translate(context, 'b_kash_ofl'),
                        style: TextStyle(
                          color: ColorResource.colorMarineBlue,
                          fontSize: responsiveTextSize(14.0),
                          fontFamily: "roboto",
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
                SizedBox(
                  height: responsiveSize(5.0),
                ),
                Image.asset('images/b_kash_logo.png'),*/
              ],
            ),
          ),
          FilledColorButton(
            horizonatalMargin: 20.0,
            buttonText: AppTranslations.of(context).text("txt_next"),
            onPressed: () async {
              var result = await navigateNextScreen(
                  context,
                  bloc.payMode
                      ? PayScreen(
                          title: localize('payment'),
                          authToken: bloc.authToken,
                          webViewUrl: bloc.listOfTripId == null
                              ? '${FlavorConfig.instance.values.CUSTOMER_PAY_URL}?authtoken=${bloc.authToken}'
                              : '${FlavorConfig.instance.values.CUSTOMER_PAY_URL}?tripIds=${bloc.listOfTripId}&authtoken=${bloc.authToken}&amount=${bloc.amount}',
                        )
                      : PayBCashOffline('5000'));
              Navigator.pop(context,result);
            },
          )
        ],
      )
    ];
  }
}
