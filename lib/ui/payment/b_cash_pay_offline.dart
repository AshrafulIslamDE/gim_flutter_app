import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/payment/bloc/b_cash_offline.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/expandable.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PayBCashOffline extends StatelessWidget {

  final String amount;

  PayBCashOffline(this.amount);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BCashOfflineBloc>(
            create: (_) => BCashOfflineBloc(amount)),
      ],
      child: PayBCashOfflinePage(),
    );
  }
}

class PayBCashOfflinePage extends StatefulWidget {
  @override
  _PayBCashOfflinePageState createState() => _PayBCashOfflinePageState();
}

class _PayBCashOfflinePageState
    extends BasePageWidgetState<PayBCashOfflinePage, BCashOfflineBloc> {
  @override
  PreferredSizeWidget getAppbar() => AppBarWidget(
        title: translate(context, 'b_kash_ofl').toUpperCase(),
        shouldShowBackButton: true,
      );

  @override
  List<Widget> getPageWidget() {
    return [
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  translate(context, 'ur_due_amt'),
                  style: TextStyle(
                    color: HexColor('ff4131'),
                    fontSize: responsiveTextSize(14.0),
                    fontFamily: "roboto",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: responsiveSize(5.0),
                ),
                Text(
                  bloc.amount,
                  style: TextStyle(
                    color: ColorResource.colorMarineBlue,
                    fontSize: responsiveTextSize(36.0),
                    fontFamily: "roboto",
                    fontWeight: FontWeight.w900,
                  ),
                )
              ],
            ),
          ),
          ExpandableTheme(
            data: ExpandableThemeData(
              useInkWell: false,
              headerAlignment: ExpandablePanelHeaderAlignment.center,
            ),
            child: ExpandableNotifier(
              initialExpanded: true,
              child: ExpandablePanel(
                header: Padding(
                  padding: const EdgeInsets.only(left:20.0,top:15.0,bottom: 15.0),
                  child: Text(
                    translate(context, 'pay_by_app_ttl'),
                    style: TextStyle(
                      color: ColorResource.greyIshBrown,
                      fontSize: responsiveTextSize(14.0),
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                expanded: Container(
                  color: HexColor('e8eff3'),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 20.0, bottom: 20.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          translate(context, 'pay_by_app'),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          ExpandableTheme(
              data: ExpandableThemeData(
                useInkWell: false,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
              ),
              child: ExpandablePanel(
                header: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top:15.0,bottom: 15.0),
                  child: Text(
                    translate(context, 'pay_by_usd_ttl'),
                    style: TextStyle(
                      color: ColorResource.greyIshBrown,
                      fontSize: responsiveTextSize(14.0),
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                expanded: Container(
                  color: HexColor('e8eff3'),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            translate(context, 'pay_by_usd'),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      )
    ];
  }
}
