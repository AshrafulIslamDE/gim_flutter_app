import 'package:customer/bloc/home/homebloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/trip/booking_detail/booking_detail_page.dart';
import 'package:customer/ui/trip/item_live_trip.dart';
import 'package:customer/ui/trip/live_trip/live_trip_bloc.dart';
import 'package:customer/ui/trip/mytrip_page.dart';
import 'package:customer/ui/trip/mytripbloc.dart';
import 'package:customer/ui/trip/widget/trip_utils.dart';
import 'package:customer/ui/widget/adapter.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LiveTripListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider<LiveTripBloc>(
        create: (context) => LiveTripBloc(), child: LiveTripScreen());
  }
}

class LiveTripScreen extends StatefulWidget {
  @override
  _LiveTripScreenState createState() => _LiveTripScreenState();
}

class _LiveTripScreenState extends BasePageWidgetState<LiveTripScreen, LiveTripBloc> {
  MyTripStatusBloc myTripStatusBloc;

  @override
  void initState() {
    myTripStatusBloc = Provider.of<MyTripStatusBloc>(context, listen: false);
    super.initState();
  }

  @override
  onBuildCompleted() {
    if (mounted) bloc.getListFromApi(callback: onApiCallback);
  }

  @override
  onRetryClick() {
    super.onRetryClick();
    bloc.reloadList(callback: onApiCallback);
  }

  onApiCallback()async=> myTripStatusBloc.tripItemCount=bloc.trip;

  @override
  List<Widget> getPageWidget() {
    return [
      showEmptyWidget<LiveTripBloc>(warning_msg: 'no_live_trip'),
      Container(
          width: double.infinity,
          child: Column(children: [
            getList<LiveTripBloc>(bloc, () => ItemLiveTrip(),
              apiCallback: onApiCallback,shouldKeepDefaultDivider: true,
              onItemClicked: (item) => onNavigateToDetailPage(item,),
            )
          ])),
      showLoader<LiveTripBloc>(Provider.of<LiveTripBloc>(context)),
      Visibility(
        visible: bloc.itemList.length>0,
        child: Positioned(
          top: 25,
          right: 25,
          child: FloatingActionButton(
            heroTag: 'liveTrip',
            child: Image.asset(
              'images/ic_fab_map_view.png',
              width: 25,
              height: 25,
            ),
            backgroundColor: ColorResource.colorMariGold,
            onPressed: ()  {
              Provider.of<HomeBloc>(context,listen: false).homePageIndex = 8;
              Provider.of<HomeBloc>(context,listen: false).notifyListeners();
              print('click in the live trip');
            }
          ),
        ),
      ),
    ];
  }

  onNavigateToDetailPage(item) async {
    var result = await navigateNextScreen(
        context,
        BookingDetailContainer(
          tripId: item.id,
          tripStatus: TRIP_STATUS.RUNNING,
        ), arguments: item.truckTypeInBn ?? null);
   /*  if user complete a live trip in booking detail page, it return true when pop the page.
     Because  trip is completed , it automatically navigate the user to history trip list page
     */
    if (result != null && result){
      MyTripStatusTypeState state = MyTripStatusType.of(context);
      //it said controller to navigate to tab  indexed number 3 which is history item tab of MyTrip page.
      state.controller.animateTo(3);

    }
    //onRetryClick();
  }

}
