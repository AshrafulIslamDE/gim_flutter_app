import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/widget/adapter.dart';
import 'package:customer/ui/trip/mytripbloc.dart';
import 'package:customer/ui/trip/booking_detail/booking_detail_page.dart';
import 'package:customer/ui/trip/item_history.dart';
import 'package:customer/ui/trip/widget/trip_utils.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'history_trip_bloc.dart';

class HistoryTripListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<HistoryTripBloc>(
          create: (context) => HistoryTripBloc()),
    ], child: HistoryTripScreen());
  }
}

class HistoryTripScreen extends StatefulWidget {
  @override
  _HistoryTripScreenState createState() => _HistoryTripScreenState();
}

class _HistoryTripScreenState extends BasePageWidgetState<HistoryTripScreen,HistoryTripBloc> {
  MyTripStatusBloc myTripStatusBloc;

  @override
  void initState() {
    myTripStatusBloc=Provider.of<MyTripStatusBloc>(context, listen: false);
    super.initState();
  }
  @override
  onBuildCompleted(){
    if(mounted)
      bloc.getListFromApi(callback: onApiCallback);
  }
  @override
  onRetryClick(){
    super.onRetryClick();
    bloc.reloadList(callback:onApiCallback);
  }
  onApiCallback()async=> myTripStatusBloc.tripItemCount=bloc.trip;

  @override
  List<Widget> getPageWidget() {
    return [showEmptyWidget<HistoryTripBloc>(warning_msg: 'no_history_trips'),
      Container(
          width: double.infinity,
          child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: ColorResource.lightBlueGrey,
                  child: Padding(
                    padding: getResponsiveDimension(const EdgeInsets.only(top: 5.0, bottom: 5.0)),
                    child: Text(
                      translate(context, 'history_days_hint'),
                      style: TextStyle(color: ColorResource.colorWhite,fontSize: responsiveDefaultTextSize()),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                getList<HistoryTripBloc>(bloc,()=>ItemHistoryTrip(),apiCallback: onApiCallback,
                  onItemClicked:(item)=>onNavigateToDetailPage(item) ,shouldKeepDefaultDivider: true
                )
              ])),
      showLoader<HistoryTripBloc>(Provider.of<HistoryTripBloc>(context)),
    ];

  }
  onNavigateToDetailPage(item)async{
    await navigateNextScreen(context,BookingDetailContainer(tripId: item.id,tripStatus: TRIP_STATUS.COMPLETED,), arguments: item.truckTypeInBn ?? null);
  }

}