import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/trip/trip.dart';
import 'package:customer/ui/trip/item_trip.dart';
import 'package:customer/ui/trip/mytripbloc.dart';
import 'package:customer/ui/trip/requested_trip/requested_trip_bloc.dart';
import 'package:customer/ui/trip/widget/trip_utils.dart';
import 'package:customer/ui/trip/trip_detail/trip_detail_page.dart';
import 'package:customer/ui/widget/adapter.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'item_bid_recived_trip.dart';

class RequestedTripListScreen extends StatelessWidget {
  var filterId;
  RequestedTripListScreen(this.filterId);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RequestedTripBloc>(
      create: (context) => RequestedTripBloc(),
      child: RequestedTrip(filterId),
    );
  }
}

class RequestedTrip extends StatefulWidget {
  var filterId;
  RequestedTrip(this.filterId);
  @override
  _RequestedTripScreenState createState() => _RequestedTripScreenState();
}

class _RequestedTripScreenState extends BasePageWidgetState<RequestedTrip,RequestedTripBloc> {
  MyTripStatusBloc myTripStatusBloc;
  @override
  void initState() {
    myTripStatusBloc = Provider.of<MyTripStatusBloc>(context, listen: false);
    super.initState();
    bloc.filterId = widget.filterId;
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
  onApiCallback()async=> myTripStatusBloc.getTripStatus();


  @override
  List<Widget> getPageWidget() {
    return [
      showEmptyWidget<RequestedTripBloc>(),
      Container(
          width: double.infinity,
          //color: Colors.white,
          child: Column(children: [
            Container(
                width: double.infinity,
                color: isBidWaitingTrips()
                    ? ColorResource.marine_blue_two
                    : ColorResource.marigold_two,
                child: Padding(
                  padding:  EdgeInsets.only(top: responsiveSize(10.0), bottom:responsiveSize(10)),
                  child: Consumer<RequestedTripBloc>(
                    builder: (context, bloc, _) => Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            translate(
                                context, isBidWaitingTrips()
                                ? 'waiting_for_bid'
                                : 'bid_received') + translate(context, 'number_count_bracket',dynamicValue:bloc.totalNumberOfItems.toString() ),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorResource.colorMarineBlue,
                                fontFamily: 'roboto',
                                 fontSize: responsiveTextSize(14.0),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: responsiveSize(20),
                            ),
                            GestureDetector(
                              onTap: () {
                                Provider.of<MyTripStatusBloc>(context,
                                    listen: false).isRequestedTripStatusPage = true;
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: ColorResource.colorMarineBlue,
                                size: responsiveSize(20),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                )),

            getList<RequestedTripBloc>( bloc, isBidWaitingTrips()
                ?()=> ItemTrip()
                : ()=>ItemBidReceivedTrip(),
                apiCallback: onApiCallback,
                onItemClicked:(item)=>onItemClick(item),shouldKeepDefaultDivider: true ),

          ])),
      showLoader<RequestedTripBloc>(bloc)
    ];
  }
  onItemClick(TripItem item) async {
    bool isTripCancelled= await navigateNextScreen(context, TripDetailPageContainer(tripId: item.id,isCancellable: true,));
    if(isTripCancelled!=null && isTripCancelled)
      onRetryClick();

  }

  @override
  onWillPop()async{
    Provider.of<MyTripStatusBloc>(context).isRequestedTripStatusPage = true;
    return false;
  }

  isBidWaitingTrips()=> bloc.filterId == getEnumValue(RequestedTripFilter.WaitingForBid);
}
