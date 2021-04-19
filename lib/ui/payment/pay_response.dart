import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/payment/bloc/pay_response_bloc.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PayResponse extends StatelessWidget {
  final String title;
  final String response;

  PayResponse(this.title, this.response);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PayResponseBloc>(
            create: (_) => PayResponseBloc(response)),
      ],
      child: PaymentResponse(title),
    );
  }
}

class PaymentResponse extends StatefulWidget {
  final String title;

  PaymentResponse(this.title);

  @override
  _PaymentResponseState createState() => _PaymentResponseState();
}

class _PaymentResponseState
    extends BasePageWidgetState<PaymentResponse, PayResponseBloc> {
  @override
  onBuildCompleted() {
    markPaymentComplete();
  }

  @override
  PreferredSizeWidget getAppbar() => AppBarWidget(
        title: widget.title.toUpperCase(),
        shouldShowBackButton: false,
        setResultVal: true,
      );

  @override
  List<Widget> getPageWidget() {
    return [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            color: HexColor('e8eff3'),
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                bloc.errorMsg == null ? _getSuccessWidget() : _getErrorWidget()
              ],
            ),
          ),
          FilledColorButton(
            horizonatalMargin: 20.0,
            buttonText:
                AppTranslations.of(context).text("back_to_payment_dashboard"),
            onPressed: () {
              Navigator.pop(context, true);
            },
          )
        ],
      ),
    ];
  }

  _getSuccessWidget() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            translate(context, 'transaction_success_title'),
            style: TextStyle(
              color: HexColor('f26721'),
              fontSize: responsiveTextSize(20.0),
              fontFamily: "roboto",
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: responsiveSize(10.0),
          ),
          Text(
            translate(context, 'total_paid_amount'),
            style: TextStyle(
              color: ColorResource.colorMarineBlue,
              fontSize: responsiveTextSize(14.0),
              fontFamily: "roboto",
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: responsiveSize(5.0),
          ),
          Text(
            amountWithCurrencySign(double.parse(bloc.amount)),
            style: TextStyle(
              color: ColorResource.colorMariGold,
              fontSize: responsiveTextSize(18.0),
              fontFamily: "roboto",
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: responsiveSize(10.0),
          ),
          Text(
            translate(context, 'transation_id'),
            style: TextStyle(
              color: ColorResource.colorMarineBlue,
              fontSize: responsiveTextSize(14.0),
              fontFamily: "roboto",
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: responsiveSize(5.0),
          ),
          Text(
            bloc.transactionId,
            style: TextStyle(
              color: ColorResource.colorMarineBlue,
              fontSize: responsiveTextSize(18.0),
              fontFamily: "roboto",
              fontWeight: FontWeight.w300,
            ),
          )
        ]);
  }

  _getErrorWidget() {
    return Expanded(
      child: Text(
        bloc.errorMsg,
        softWrap: true,
        style: TextStyle(
          color: HexColor('f26721'),
          fontSize: responsiveTextSize(18.0),
          fontFamily: "roboto",
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  markPaymentComplete() async {
    submitDialog(context, dismissible: false);
    await bloc.completePayment();
    Navigator.pop(context);
  }
}
