import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/payment/b_cash_pay_opt.dart';
import 'package:customer/ui/payment/bloc/payment_opt_bloc.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentOption extends StatelessWidget {
  final String amount;

  PaymentOption(this.amount);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PaymentOptionBloc>(
            create: (_) => PaymentOptionBloc(amount)),
      ],
      child: PaymentOptionPage(),
    );
  }
}

class PaymentOptionPage extends StatefulWidget {
  @override
  PaymentOptionPageState createState() => PaymentOptionPageState();
}

class PaymentOptionPageState
    extends BasePageWidgetState<PaymentOptionPage, PaymentOptionBloc> {
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
                Text(translate(context, 'sel_pay_opt_ttl'),
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
                              value: true,
                              onChanged: (state) => setState(() => true),
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
                      width: responsiveSize(20.0),
                    ),
                    Padding(padding: EdgeInsets.only(left: responsiveSize(10.0)), child: Image.asset('images/b_kash_logo.png')),
                  ],
                )
              ],
            ),
          ),
          FilledColorButton(
            horizonatalMargin: 20.0,
            buttonText: AppTranslations.of(context).text("txt_next"),
            onPressed: () async {
              await navigateNextScreen(context, BCashPayOpt(bloc.amount));
              Navigator.pop(context,true);
            },
          )
        ],
      )
    ];
  }
}
