import 'dart:collection';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/bloc/base_pagination_bloc.dart';
import 'package:customer/bloc/dashboard/dashboard_bloc.dart';
import 'package:customer/bloc/payment/payment_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/payment/payment_item.dart';
import 'package:customer/ui/dashboard/dashboard_filter.dart';
import 'package:customer/ui/dashboard/item_dashboard.dart';
import 'package:customer/ui/home/home_drawer_icon.dart';
import 'package:customer/ui/payment/item_payment.dart';
import 'package:customer/ui/payment/payment_option.dart';
import 'package:customer/ui/trip/trip_detail/trip_detail_page.dart';
import 'package:customer/ui/trip/widget/trip_utils.dart';
import 'package:customer/ui/widget/adapter.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PaymentBloc>(
          create: (context) => PaymentBloc(),
        )
      ],
      child: PaymentPage(),
    );
  }
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends BasePageWidgetState<PaymentPage, PaymentBloc> {
  @override
  onBuildCompleted() => bloc.getListFromApi();

  buildFilterHeaderSection() {
    return Consumer<PaymentBloc>(
      builder: (context, bloc, child) => Visibility(
//        visible: bloc.isFilterApplied,
        child: Container(
          width: double.infinity,
          color: HexColor("99ffc33c"),
          child: Padding(
            padding: EdgeInsets.all(responsiveSize(8.0)),
            child: Row(
              children: <Widget>[
                //showFilterInformation(),
                GestureDetector(
                    onTap: () {
//                      bloc.isFilterApplied = false;
                      bloc.reloadList();
                    },
                    child: SvgPicture.asset(
                      'svg_img/ic_cancel.svg',
                      width: 15,
                      height: 15,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showFilterInformation() {
    return Expanded(
      child: Center(
          child: Text(
        translate(context, 'filtered_trips') +
            " " +
            translate(context, 'number_count', dynamicValue: "100"),
//                translate(context,'number_count',dynamicValue: bloc.totalTrip.toString()) +
//                "/" +translate(context,'number_count',dynamicValue: bloc.grandTotalTrip.toString()),
        style: TextStyle(
            color: ColorResource.colorMarineBlue, fontWeight: FontWeight.w500),
      )),
    );
  }

  getHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(responsiveSize(20.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  translate(context, 'paid_amount').toUpperCase(),
                  style: TextStyle(
                      fontSize: responsiveTextSize(18.0),
                      color: ColorResource.colorMarineBlue,
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8,
                ),
                Consumer<PaymentBloc>(
                    builder: (context, bloc, _) => AutoSizeText(
                      amountWithCurrencyFormatting(bloc.paidAmount),
                          style: TextStyle(
                              color: ColorResource.colorMariGold,
                              fontSize: responsiveTextSize(24.0),
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w800),
                          maxLines: 1,
                        )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  makePayment() async {
    await navigateNextScreen(context, PaymentOption('0.0'));
    onRetryClick();
  }

  getListViewHeader() {
    return Container(
      color: Color.fromRGBO(0, 50, 80, 0.086),
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                child: AutoSizeText(
                    translate(context, 'payment_date').toUpperCase(), minFontSize: 10.0,
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
              flex: 2,
              child: AutoSizeText(
                  translate(context, 'transaction_id').toUpperCase(), minFontSize: 10.0,
                  textAlign: TextAlign.center,
                  style: headerTextStyle)),
          SizedBox(
              height: 30,
              child: VerticalDivider(
                color: ColorResource.divider_color,
                width: 1,
              )),
          Expanded(
              flex: 2,
              child: AutoSizeText(translate(context, 'mode').toUpperCase(), minFontSize: 10.0,
                  textAlign: TextAlign.center, style: headerTextStyle)),
          SizedBox(
              height: 30,
              child: VerticalDivider(
                color: ColorResource.divider_color,
                width: 1,
              )),
          Expanded(
              flex: 1,
              child: AutoSizeText(translate(context, 'amount').toUpperCase(), minFontSize: 10.0,
                  textAlign: TextAlign.center, style: headerTextStyle)),
        ],
      ),
    );
  }

  final headerTextStyle = TextStyle(
      fontSize: responsiveTextSize(10.0),
      color: ColorResource.colorMarineBlue,
      fontWeight: FontWeight.w600);

  @override
  List<Widget> getPageWidget() {
    return [
      Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Divider(
              color: ColorResource.divider_color,
              height: 0,
            ),
            //buildFilterHeaderSection(),
            getHeaderSection(),
            getListViewHeader(),
            Divider(
              color: ColorResource.divider_color,
              height: 0,
            ),
            showEmptyMsg<PaymentBloc>(),

            getList<PaymentBloc>(bloc, () => ItemPayment(),
                onItemClicked: (item) {
              navigateNextScreen(
                  context,
                  TripDetailPageContainer(
                    tripId: item.tripId,
                  ));
            }),
            FilledColorButton(
              buttonText: translate(
                  context,
                  'make_paymen'
                  't'),
              horizonatalMargin: 20,
              onPressed: () => makePayment(),
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      ),
      showLoader<PaymentBloc>(bloc)
    ];
  }

  @override
  getAppbar() => AppBarWidget(
        title: translate(context, 'payment'),
        shouldShowBackButton: false,
        leadingWidget: getDrawerIcon(Scaffold.of(context)),
        action: <Widget>[
          /*GestureDetector(
            onTap: () async {
              Map queryMap = await navigateNextTransparentScreen(
                  context, PaymentScreen());
              if (queryMap != null && queryMap.isNotEmpty) {
                var params = HashMap<String, String>();
                params.addAll(queryMap);
                params.remove("goodsTypeText");
                params.remove("fromDate");
                params.remove("toDate");

                //bloc.isFilterApplied = true;
                bloc.reloadList(additionalQueryParam: params);

                */ /*FireBaseAnalytics().logFilterDashboard
                  (queryMap["fromDate"], queryMap["toDate"],
                    queryMap["goodsTypeText"]);*/ /*
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: SvgPicture.asset(
                'svg_img/ic_filter_search.svg',
                height: responsiveSize(25),
                width: responsiveSize(25),
              ),
            ),
          )*/
        ],
      );

  @override
  onRetryClick() {
    super.onRetryClick();
    bloc.reloadList();
  }
}
