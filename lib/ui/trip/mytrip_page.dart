import 'package:customer/bloc/home/homebloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/trip/requested_trip/requested_trip_page.dart';
import 'package:customer/ui/trip/requested_trip/requested_trip_status.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'booked_trip/booked_trip.dart';
import 'history_trip/history_trip_page.dart';
import 'live_trip/live_trip_page.dart';
import 'mytripbloc.dart';

class MyTripStatusTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyTripStatusBloc>(
      create: (context) => MyTripStatusBloc(),
      child: MyTripStatusType(),
    );
  }
}

class MyTripStatusType extends StatefulWidget {
  int myTripTabIndex;

  @override
  State<StatefulWidget> createState() => MyTripStatusTypeState();

  static MyTripStatusTypeState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_MyTripInheritedStateContainer>()
        .data;
  }
}

class MyTripStatusTypeState extends State<MyTripStatusType>
    with SingleTickerProviderStateMixin {
  final List<String> _tabTitles = [
    "requested_count",
    "booked_count",
    "live_count",
    "history_count"
  ];
  TabController controller;

  @override
  void initState() {
    super.initState();
    widget.myTripTabIndex =
        Provider.of<HomeBloc>(context, listen: false).myTripTabIndex;
    controller = TabController(
      length: 4,
      initialIndex: widget.myTripTabIndex,
      vsync: this,
    );
    Provider.of<HomeBloc>(context, listen: false).myTripTabIndex = 0;
    int previousIndex;
    controller.addListener(() {
      if (previousIndex != controller.index){
        previousIndex = controller.index;
        FireBaseAnalytics().screenViewEvent(ScreenView.TRIP_SCREENS[previousIndex]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<MyTripStatusBloc>(context, listen: false);
    //bloc.getTripStatus();

    getTabList(MyTripStatusBloc bloc) {
      var itemCountList = [
        bloc.requestedTripCount,
        bloc.bookedTripCount,
        bloc.liveTripCount,
        bloc.historyTripCount
      ];
      List<Widget> tabs = new List.generate(
          4,
          (i) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      translate(context, _tabTitles[i],
                              dynamicValue: itemCountList[i].toString())
                          .toUpperCase(),
                      style: TextStyle(fontSize: responsiveTextSize(12)),
                    )),
              ));
      return tabs;
    }

    return _MyTripInheritedStateContainer(
        data: this,
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Consumer<MyTripStatusBloc>(
                builder: (context, model, _) => TabBar(
                  unselectedLabelColor: ColorResource.colorBrownGrey,
                  indicatorColor: ColorResource.colorMarineBlue,
                  labelColor: ColorResource.colorMarineBlue,
                  labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                  controller: controller,
                  tabs: getTabList(model),
                  onTap: (index) {},
                  // child: ,
                ),
              ),
              Divider(
                color: ColorResource.warm_grey,
                height: 2,
              ),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: <Widget>[
                    Selector<MyTripStatusBloc, bool>(
                      selector: (context, MyTripStatusBloc) =>
                          bloc.isRequestedTripStatusPage,
                      builder: (context, selection, _) => selection
                          ? RequestedTripStatusScreen()
                          : RequestedTripListScreen(
                              bloc.requestedTripListFilterId),
                    ),
                    BookedTripListScreen(),
                    LiveTripListScreen(),
                    HistoryTripListScreen()
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

/* create this InheritedWidget to access tabController from other widget class when we should manipulate tab page
 to go to specific tab page*/
class _MyTripInheritedStateContainer extends InheritedWidget {
  _MyTripInheritedStateContainer({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final MyTripStatusTypeState data;

  @override
  bool updateShouldNotify(_MyTripInheritedStateContainer oldWidget) {
    return true;
  }
}
