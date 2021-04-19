import 'dart:collection';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/bloc/dashboard/dashboard_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/dashboard/dashboard_filter.dart';
import 'package:customer/ui/dashboard/item_dashboard.dart';
import 'package:customer/ui/home/home_drawer_icon.dart';
import 'package:customer/ui/trip/trip_detail/trip_detail_page.dart';
import 'package:customer/ui/trip/widget/trip_utils.dart';
import 'package:customer/ui/widget/adapter.dart';
import 'package:customer/ui/widget/app_bar.dart';
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

class MyDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DashboardBloc>(
          create: (context) => DashboardBloc(),
        )
      ],
      child: MyDashboardPage(),
    );
  }
}

class MyDashboardPage extends StatefulWidget {
  @override
  _MyDashboardPageState createState() => _MyDashboardPageState();
}

class _MyDashboardPageState extends BasePageWidgetState<MyDashboardPage,DashboardBloc> {


  @override
  onBuildCompleted()=>bloc.getListFromApi();
  buildFilterHeaderSection() {
    return Consumer<DashboardBloc>(
      builder: (context, bloc, child) => Visibility(
        visible: bloc.isFilterApplied,
        child: Container(
          width: double.infinity,
          color: HexColor("99ffc33c"),
          child: Padding(
            padding: EdgeInsets.all(responsiveSize(8.0)),
            child: Row(
              children: <Widget>[
                showFilterInformation(),
                GestureDetector(
                    onTap: () {
                      bloc.isFilterApplied = false;
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

  showFilterInformation(){
    return Expanded(
      child: Center(
          child: Text(
            translate(context, 'filtered_trips')+" " +
                translate(context,'number_count',dynamicValue: bloc.totalTrip.toString()) +
                "/" +translate(context,'number_count',dynamicValue: bloc.grandTotalTrip.toString()),
            style: TextStyle(
                color: ColorResource.colorMarineBlue,
                fontWeight: FontWeight.w500),
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  translate(context, 'total_trips').toUpperCase(),
                  style: TextStyle(
                      fontSize: responsiveSize(15.0),
                      color: ColorResource.colorMarineBlue,
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8,
                ),
                Consumer<DashboardBloc>(
                    builder: (context, bloc, _) => Text(localize('number_count',dynamicValue:bloc.totalTrip.toString() ),
                          style: TextStyle(
                              color: ColorResource.colorMarineBlue,
                              fontSize: responsiveTextSize(22.0)),
                        ))
              ],
            ),
          ),
        ),
        SizedBox(
            height: 70,
            child: VerticalDivider(
              color: ColorResource.divider_color,
              width: 1,
            )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  translate(context, 'total_amount').toUpperCase(),
                  style: TextStyle(
                      fontSize: responsiveTextSize(15.0),
                      color: ColorResource.colorMarineBlue,
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8,
                ),
                Consumer<DashboardBloc>(
                    builder: (context, bloc, _) => AutoSizeText(
                          amountWithCurrencySign(bloc.totalAmountPaid),
                          style: TextStyle(
                            color: Color.fromRGBO(255, 189, 39, 1),
                            fontSize: responsiveTextSize(22.0),
                          ),
                          maxLines: 1,
                        ))
              ],
            ),
          ),
        )
      ],
    );
  }

  getListViewHeader() {
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
                child: AutoSizeText(
                    translate(context, 'trip_date').toUpperCase(),
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
              child: AutoSizeText(
                  translate(context, 'trip_number').toUpperCase(),
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
              child: AutoSizeText(
                  translate(context, 'trip_amount').toUpperCase(),
                  textAlign: TextAlign.center,
                  style: headerTextStyle)),
        ],
      ),
    );
  }

  final headerTextStyle =  TextStyle(
      fontSize: responsiveTextSize(12.0),
      color: ColorResource.colorMarineBlue,
      fontWeight: FontWeight.bold);

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
            buildFilterHeaderSection(),
            getHeaderSection(),
            getListViewHeader(),
            Divider(
              color: ColorResource.divider_color,
              height: 0,
            ),
            showEmptyWidget<DashboardBloc>(warning_msg: 'no_completed_trips'),

            getList<DashboardBloc>(
                bloc, () => ItemDashboard(),
                onItemClicked: (item) {
              navigateNextScreen(
                  context,
                  TripDetailPageContainer(
                    tripId: item.tripId,
                  ));
            }),
          ],
        ),
      ),
      showLoader<DashboardBloc>(bloc)
    ];
  }

  @override
  getAppbar() => AppBarWidget(
        title: translate(context, 'dashboard'),
         shouldShowBackButton: false,
         leadingWidget: getDrawerIcon(Scaffold.of(context)),
         action: <Widget>[
          GestureDetector(
            onTap: () async {
              Map queryMap = await navigateNextTransparentScreen(
                  context, DashboardFilterScreen());
              if (queryMap != null && queryMap.isNotEmpty) {
                var params = HashMap<String, String>();
                params.addAll(queryMap);
                params.remove("goodsTypeText");
                params.remove("fromDate");
                params.remove("toDate");

                bloc.isFilterApplied = true;
                bloc.reloadList(additionalQueryParam: params);

                FireBaseAnalytics().logFilterDashboard
                  (queryMap["fromDate"], queryMap["toDate"],
                    queryMap["goodsTypeText"]);
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
          )
        ],
      );
  @override
  onRetryClick(){
    super.onRetryClick();
    bloc.reloadList();
  }
}
