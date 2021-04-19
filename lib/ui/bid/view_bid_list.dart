import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/trip/trip.dart';
import 'package:customer/ui/bid/bid_list_item.dart';
import 'package:customer/ui/bid/view_bid_detail.dart';
import 'package:customer/ui/bid/view_bid_list_bloc.dart';
import 'package:customer/ui/trip/widget/trip_truck_info.dart';
import 'package:customer/ui/widget/adapter_expand.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/caller_layout.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/ui/widget/refresh_config_widget.dart';
import 'package:customer/ui/widget/trip_address_widget.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewBidListScreen extends StatelessWidget{
  TripItem tripItem;
  ViewBidListScreen(this.tripItem){}
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ViewBidListBloc>(create: (context)=>ViewBidListBloc())
      ],
      child: ViewBidListPage(tripItem: tripItem,),
    );
  }

}

class ViewBidListPage extends StatefulWidget{
  TripItem tripItem;
  ViewBidListPage({this.tripItem});

  @override
  _ViewBidListPageState createState() => _ViewBidListPageState();
}

class _ViewBidListPageState extends State<ViewBidListPage> {
  ViewBidListBloc bloc;
  @override
  void initState() {
    bloc=Provider.of<ViewBidListBloc>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((callback){
      bloc.tripNumber=widget.tripItem.id;
      bloc.getListFromApi();
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppRefreshConfiguration(
        child: Scaffold(
          appBar: AppBarWidget(title: translate(context, 'view_bids')+translate(context,'number_count_bracket',dynamicValue: widget.tripItem.totalNoOfBids.toString()),),
          floatingActionButton: CallerWidget(),
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Stack(children: [AddressWidget(tripItem: widget.tripItem),
                    Positioned(left:18,bottom: 18,child: TruckInfoWidget(widget.tripItem))
                  ]),
                    getList<ViewBidListBloc>(bloc,()=>BidListItem(),onItemClicked:
                      ( item )=>navigateNextScreen(context, ViewBidDetailScreen(bidId: item.bidId))),

                ],
              ),
              showLoader<ViewBidListBloc>(bloc)
            ],
          ),
        ),
      ),
    );
  }
}

