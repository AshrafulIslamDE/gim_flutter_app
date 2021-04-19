import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/payment/bloc/payment_paid_bloc.dart';
import 'package:customer/ui/payment/item_payment_paid.dart';
import 'package:customer/ui/trip/widget/trip_utils.dart';
import 'package:customer/ui/widget/adapter.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentPaidScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PaymentPaidBloc>(
          create: (context) => PaymentPaidBloc(),
        )
      ],
      child: PaymentPaidPage(),
    );
  }
}

class PaymentPaidPage extends StatefulWidget {
  @override
  _PaymentPaidPageState createState() => _PaymentPaidPageState();
}

class _PaymentPaidPageState
    extends BasePageWidgetState<PaymentPaidPage, PaymentPaidBloc> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  PaymentPaidBloc bloc;

  @override
  onBuildCompleted() {
    super.onBuildCompleted();
    bloc = Provider.of<PaymentPaidBloc>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      bloc.getListFromApi();
    });
  }

  @override
  List<Widget> getPageWidget() {
    return [
      Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Consumer<PaymentPaidBloc>(
                    builder: (context, bloc, _) => GestureDetector(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                translate(context, 'tot_no_trip').toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: responsiveTextSize(13),
                                    color: ColorResource.colorMarineBlue,
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              AutoSizeText(
                                localize('number_count', dynamicValue: bloc.totalTrip.toString()),
                                style: TextStyle(
                                    color: ColorResource.colorMarineBlue,
                                    fontSize: responsiveTextSize(25),
                                    fontFamily: 'roboto'),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: 84,
                    child: VerticalDivider(
                      color: ColorResource.divider_color,
                      width: 1,
                    )),
                Expanded(
                  child: Consumer<PaymentPaidBloc>(
                    builder: (context, bloc, _) => GestureDetector(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                translate(context, 'tot_paid_amt')
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: responsiveTextSize(13),
                                    color: ColorResource.colorMarineBlue,
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              AutoSizeText(
                                amountWithCurrencySign(bloc.totalAmount),
                                style: TextStyle(
                                    color: ColorResource.orange_yellow,
                                    fontSize: responsiveTextSize(25),
                                    fontFamily: 'roboto'),
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Divider(
              height: 0,
              thickness: 1,
            ),
            getListViewHeader(),
            //showEmptyWidget<PaymentPaidBloc>(warning_msg: 'no_completed_trips'),
            getList<PaymentPaidBloc>(bloc, () => ItemPaymentPaid())
          ],
        ),
      ),
      showLoader<PaymentPaidBloc>(bloc)
    ];
  }

  getListViewHeader() {
    List<String> headerItems = [
      translate(context, 'payment_date'),
      translate(context, 'trip_no'),
      translate(context, 'amount'),
      translate(context, 'transation_id'),
    ];
    return Container(
      color: Color.fromRGBO(0, 50, 80, 0.086),
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                child: AutoSizeText(headerItems[0].toUpperCase(),
                    minFontSize: 10,
                    textAlign: TextAlign.center,
                    style: headerTextStyle),
              )),
          SizedBox(
              height: 30,
              child: VerticalDivider(
                color: ColorResource.divider_color,
                width: 1,
              )),
          Expanded(
              flex: 1,
              child: AutoSizeText(headerItems[1].toUpperCase(),
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: headerTextStyle)),
          SizedBox(
              height: 30,
              child: VerticalDivider(
                color: ColorResource.divider_color,
                width: 1,
              )),
          Expanded(
              flex: 1,
              child: AutoSizeText(headerItems[2].toUpperCase(),
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: headerTextStyle)),
          SizedBox(
              height: 30,
              child: VerticalDivider(
                color: ColorResource.divider_color,
                width: 1,
              )),
          Expanded(
              flex: 1,
              child: AutoSizeText(headerItems[3].toUpperCase(),
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: headerTextStyle)),
        ],
      ),
    );
  }

  final headerTextStyle = TextStyle(
      fontFamily: 'roboto',
      fontSize: responsiveTextSize(10),
      color: ColorResource.colorMarineBlue,
      fontWeight: FontWeight.w900);
}
