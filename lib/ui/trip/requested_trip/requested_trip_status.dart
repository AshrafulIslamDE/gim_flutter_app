
import 'package:customer/bloc/home/homebloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/trip/mytripbloc.dart';
import 'package:customer/ui/trip/requested_trip/requested_trip_bloc.dart';
import 'package:customer/ui/trip/requested_trip/requested_trip_status_bloc.dart';
import 'package:customer/ui/trip/widget/trip_utils.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RequestedTripStatusScreen  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RequestedTripStatusBloc>(create:(context)=>RequestedTripStatusBloc()),
      ],
      child: RequestedTripStatusPage(),

    );
  }

}

class RequestedTripStatusPage extends StatefulWidget{
  @override
  _RequestedTripStatusPageState createState() => _RequestedTripStatusPageState();
}

class _RequestedTripStatusPageState extends BasePageWidgetState<RequestedTripStatusPage,RequestedTripStatusBloc> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  scaffoldBackgroundColor()=>ColorResource.lightBlue;

  @override
  onBuildCompleted()=>getTripStatus();

  @override
  onRetryClick(){
    super.onRetryClick();
    getTripStatus();
  }

  getTripStatus(){
    bloc.getRequestedTripStatus((response) {
      Provider.of<MyTripStatusBloc>(context, listen: false).tripItemCount = response;
      if(bloc.tripStatus!=null && bloc.getTripCount().getTotalTripCount()==0)
      Provider.of<HomeBloc>(context,listen: false).hasAnyTrip=false;

    });
  }
  @override
  List<Widget> getPageWidget() {
    var padding=EdgeInsets.only(left:responsiveTextSize(18),right:responsiveTextSize(18),
        top:responsiveTextSize(10),bottom:responsiveTextSize(10));
    return [
    Selector<RequestedTripStatusBloc, bool>(
        selector: (context, myBloc) => myBloc.tripStatus!=null,
        builder: (context, builderVal, _) =>bloc.tripStatus==null?
     Container(): bloc.getTripCount().getTotalTripCount()>0?
      Column(
        children: <Widget>[
          Expanded(flex: 66,
            child: Padding(
              padding: padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (bloc.tripStatus.biddedDisplayModel.id <= 0)
                          showSnackBar(scaffoldState.currentState,
                              translate(context, 'no_bids_to_display'));
                        else
                          onSectionClick(getEnumValue(RequestedTripFilter.BidReceived));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(responsiveSize(10)),
                            gradient: LinearGradient(
                                stops: [0.03, 0.03],
                                colors: [
                                  ColorResource.colorMariGold,
                                  Colors.white
                                ])
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(width: responsiveSize(25),),
                              SvgPicture.asset('svg_img/ic_received_bids.svg',
                                color: ColorResource.colorMariGold,width: responsiveSize(25),),
                              SizedBox(width: responsiveSize(15),),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Consumer<RequestedTripStatusBloc>(
                                    builder: (context, bloc, _) =>
                                        Text(translate(context, 'total_trip_count',dynamicValue: bloc.tripStatus.biddedDisplayModel.id.toString())
                                            .toUpperCase(), style: TextStyle(
                                            color: ColorResource.greyish_brown,
                                            fontFamily: 'roboto',
                                            fontWeight: FontWeight.w700,
                                          fontSize: responsiveDefaultTextSize()
                                        ),
                                        ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(translate(context, 'bid_received')
                                      .toUpperCase(), style: TextStyle(
                                      color: ColorResource.colorMariGold,
                                      fontFamily: 'roboto',
                                      fontWeight: FontWeight.w700,
                                      fontSize: responsiveTextSize(22)
                                  ),),
                                  SizedBox(height: 5,),
                                  Consumer<RequestedTripStatusBloc>(
                                      builder: (context, bloc, _) =>
                                          Text(getTimeDifferenceInText(
                                              bloc.tripStatus.biddedDisplayModel
                                                  .value,bloc.tripStatus.serverTime).toUpperCase(),
                                              style: TextStyle(
                                                  color: ColorResource
                                                      .warm_grey,
                                                  fontSize: responsiveTextSize(12),
                                                  fontFamily: 'roboto',
                                                  fontWeight: FontWeight.w700))
                                  )
                                ],
                              ),
                              Expanded(child: Align(
                                child: Icon(Icons.arrow_forward_ios,
                                  color: ColorResource.colorMariGold,size:responsiveSize(24.0) ,),
                                alignment: Alignment.centerRight,)),
                              SizedBox(width: 15,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18,),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (bloc.tripStatus.unbiddedDisplayModel.id <= 0)
                          showSnackBar(scaffoldState.currentState,
                              translate(context, 'no_bids_to_display'));
                        else
                          onSectionClick(getEnumValue(RequestedTripFilter.WaitingForBid));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(responsiveSize(10)),
                            gradient: LinearGradient(
                                stops: [0.03, 0.03],
                                colors: [
                                  ColorResource.colorMarineBlue,
                                  Colors.white
                                ])
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(width: responsiveSize(25),),
                              SvgPicture.asset('svg_img/ic_waiting_bids.svg',
                                width: responsiveSize(25),
                                color: ColorResource.colorMarineBlue,),
                              SizedBox(width: responsiveSize(15),),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Consumer<RequestedTripStatusBloc>(
                                    builder: (context, bloc, _) =>
                                        Text(translate(context, 'total_trip_count',dynamicValue:
                                        bloc.tripStatus.unbiddedDisplayModel.id.toString()).toUpperCase(),
                                          style: TextStyle(
                                            color: ColorResource.greyish_brown,
                                            fontFamily: 'roboto',
                                            fontWeight: FontWeight.w700,
                                            fontSize: responsiveDefaultTextSize()
                                        ),
                                        ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(translate(context, 'waiting_for_bid')
                                      .toUpperCase(), style: TextStyle(
                                      color: ColorResource.colorMarineBlue,
                                      fontFamily: 'roboto',
                                      fontWeight: FontWeight.w700,
                                      fontSize: responsiveTextSize(22)
                                  ),),
                                  SizedBox(height: 5,),
                                  Consumer<RequestedTripStatusBloc>(
                                      builder: (context, bloc, _) =>
                                          Text(getTimeDifferenceInText(
                                              bloc.tripStatus
                                                  .unbiddedDisplayModel.value,bloc.tripStatus.serverTime)
                                              .toUpperCase(), style: TextStyle(
                                              color: ColorResource.warm_grey,
                                              fontSize: responsiveTextSize(12.0),
                                              fontFamily: 'roboto',
                                              fontWeight: FontWeight.w700))
                                  )
                                ],
                              ),
                              Expanded(child: Align(
                                child: Icon(Icons.arrow_forward_ios,
                                  color: ColorResource.colorMarineBlue,size:responsiveSize(24.0)),
                                alignment: Alignment.centerRight,)),
                              SizedBox(width: 15,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),),
          Expanded(flex: 34, child: Container(),)
        ],
      ):getWelcomeWidget()),
     showLoader<RequestedTripStatusBloc>(bloc)
    ];
  }
  
  onSectionClick(filterId) {
    Provider.of<MyTripStatusBloc>(context, listen: false).requestedTripListFilterId = filterId;
    Provider.of<MyTripStatusBloc>(context, listen: false).isRequestedTripStatusPage = false;
  }
  
  Widget getWelcomeWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 50,right: 50,top: 120),
          child: AspectRatio(
              aspectRatio: 468/144,
              child: Image.asset('images/trip_welcome.webp',)),
        ),
        SizedBox(height: 30,),
        Text(translate(context, 'welcome_new_trip_creation'),textAlign: TextAlign.center,
          style: TextStyle(fontSize: responsiveSize(20),color: ColorResource.colorMarineBlue,fontWeight: FontWeight.w600),),
        SizedBox(height: 30,),
        Text(translate(context, 'welcome_new_trip_creation_note'),textAlign: TextAlign.center,
          style: TextStyle(fontSize: responsiveSize(16),color: ColorResource.brownish_grey,fontWeight: FontWeight.w600),)
        ,SizedBox(height: 20,),
        Expanded(child: Align(alignment:Alignment.topCenter,child: Image.asset('images/arrow.webp'))),

      ],
    );
  }
}