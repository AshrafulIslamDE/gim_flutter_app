import 'package:customer/bloc/home/homebloc.dart';
import 'package:customer/ui/trip/booking_detail/booking_detail_page.dart';
import 'package:customer/ui/trip/item_booked_trip.dart';
import 'package:customer/ui/trip/mytripbloc.dart';
import 'package:customer/ui/trip/widget/trip_utils.dart';
import 'package:customer/ui/widget/adapter.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'booked_trip_bloc.dart';

class BookedTripListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookedTripBloc>(
      create: (context) => BookedTripBloc(),
      child: BookedTripScreen(),
    );
  }
}

class BookedTripScreen extends StatefulWidget {
  @override
  _BookedTripScreenState createState() => _BookedTripScreenState();
}

class _BookedTripScreenState extends BasePageWidgetState<BookedTripScreen,BookedTripBloc> {
  MyTripStatusBloc myTripStatusBloc;

  @override
  void initState() {
    myTripStatusBloc=Provider.of<MyTripStatusBloc>(context, listen: false);
    super.initState();

  }
  @override
  onBuildCompleted(){
    if(mounted) {
      bloc.getListFromApi(callback: onApiCallback);
      // Provider.of<HomeBloc>(context,listen: false).hasAnyTrip=true;
    }
  }
  @override
  onRetryClick(){
    super.onRetryClick();
    bloc.reloadList(callback:onApiCallback);
  }
  onApiCallback()async=> myTripStatusBloc.tripItemCount=bloc.trip;

  @override
  List<Widget> getPageWidget() {
    return [showEmptyWidget<BookedTripBloc>(warning_msg: 'no_booked_trips'),
      Container(
          width: double.infinity,
          child: Column(children: [
            getList<BookedTripBloc>(bloc,()=>ItemBookedTrip(),apiCallback: onApiCallback,
              onItemClicked:(item)=>onNavigateToDetailPage(item) ,shouldKeepDefaultDivider: true)
          ])),
      showLoader<BookedTripBloc>(Provider.of<BookedTripBloc>(context)),
    ];

  }
  onNavigateToDetailPage(item)async{
    var result=await navigateNextScreen(context,BookingDetailContainer(tripId: item.id,tripStatus: TRIP_STATUS.BOOKED,), arguments: item.truckTypeInBn ?? null);
    print("result: $result");
    if(result!=null && result)onRetryClick();
  }
}
