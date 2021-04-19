import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/payment/b_cash_pay_opt.dart';
import 'package:customer/ui/payment/bloc/payment_summary_bloc.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/editfield.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentSummaryScreen extends StatelessWidget {
  final int noOfPayments;
  final double paymentAmount;
  final List listOfTripId;

  PaymentSummaryScreen(this.noOfPayments, this.paymentAmount,{this.listOfTripId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PaymentSummaryBloc>(
          create: (context) => PaymentSummaryBloc(noOfPayments,paymentAmount,listOfTripId),
        )
      ],
      child: PaymentSummaryPage(),
    );
  }
}

class PaymentSummaryPage extends StatefulWidget {
  @override
  _PaymentSummaryPageState createState() => _PaymentSummaryPageState();
}

class _PaymentSummaryPageState
    extends BasePageWidgetState<PaymentSummaryPage, PaymentSummaryBloc> {
  var _noOfTripSel = TextEditingController();
  var _totAmtToBePaid = TextEditingController();

  @override
  PreferredSizeWidget getAppbar() => AppBarWidget(
        title: translate(context, "payment"),
        shouldShowBackButton: true,
      );

  @override
  List<Widget> getPageWidget() {
    _noOfTripSel.text = localize('number_count',dynamicValue: bloc.totNoOfTrip);
    _totAmtToBePaid.text = amountWithCurrencySign(bloc.totAmtToBePaid);
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top:24.0),
            child: Text(
              translate(context, 'u_pay_for_lbl'),
              style: TextStyle(
                  fontFamily:'roboto',
                  color: ColorResource.colorBlack,
                  fontSize: responsiveTextSize(14),
                  fontWeight: FontWeight.w300),
            ),
          ),
          Card(
            margin: EdgeInsets.all(20.0),
            elevation: 4.0,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(translate(context, 'tot_no_trip').toUpperCase(),
                            style: labelStyle),
                        TextEditText(
                          labelText: '',
                          textEditingController: _noOfTripSel,
                          readOnly: true,
                          fontSize: responsiveTextSize(20),
                          behaveNormal: false,
                          isHtmlText: true,
                          textAlign: TextAlign.center,
                          textColor: ColorResource.colorMarineBlue,
                          fontWeight: FontWeight.w700,
                          verticalPad: EdgeInsets.only(
                              left: 15, top: 15, right: 10, bottom: 15),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: ColorResource.divider_color,
                    height: 1.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(translate(context, 'total_amount').toUpperCase(),
                            style: labelStyle),
                        TextEditText(
                          labelText: '',
                          textColor: ColorResource.colorMarineBlue,
                          textEditingController: _totAmtToBePaid,
                          readOnly: true,
                          fontSize: responsiveTextSize(20),
                          behaveNormal: false,
                          isHtmlText: true,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                          verticalPad: EdgeInsets.only(
                              left: 15, top: 15, right: 10, bottom: 15),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          FilledColorButton(
            buttonText: translate(context, 'txt_next'),
            horizonatalMargin: 20,
            verticalMargin: 40,
            onPressed: () => makePayment(),
            fontWeight: FontWeight.normal,
          ),
        ],
      )
    ];
  }

  var labelStyle = TextStyle(
      fontFamily:'roboto',
      color: ColorResource.colorMarineBlue,
      fontSize: responsiveTextSize(14),
      fontWeight: FontWeight.w700);

  makePayment() async {
    var result = await navigateNextScreen(context, BCashPayOpt(bloc.totAmtToBePaid.toString(), listOfTripId: bloc.listOfTripsId,));
    Navigator.pop(context, result);
  }
}
