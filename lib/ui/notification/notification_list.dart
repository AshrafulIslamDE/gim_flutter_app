import 'package:customer/bloc/home/homebloc.dart';
import 'package:customer/bloc/notifications/notification_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/data/constants.dart';
import 'package:customer/model/bid/bid_status_response.dart';
import 'package:customer/model/notifications/notification_content.dart';
import 'package:customer/model/trip/trip.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/bid/view_bid_list.dart';
import 'package:customer/ui/notification/item_notification.dart';
import 'package:customer/ui/review/add_rating_page.dart';
import 'package:customer/ui/trip/booking_detail/booking_detail_page.dart';
import 'package:customer/ui/trip/trip_detail/trip_detail_page.dart';
import 'package:customer/ui/widget/adapter.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/ui/widget/optimized_adapter.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NotificationBloc>(
          create: (context) => NotificationBloc(),
        ),
      ],
      child: NotificationList(),
    );
  }
}

class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends BasePageWidgetState<NotificationList,NotificationBloc> {
  @override
  onBuildCompleted(){
    bloc.getListFromApi();
    bloc.resetBadgeCount(callback: _updateReadCount);
  }

  _updateReadCount(){
    bloc.getNotificationCount(callback: (item) {
      Provider.of<HomeBloc>(context, listen: false).notificationCount = item.count;
    });
  }

  @override
  onRetryClick() {
    super.onRetryClick();
    bloc.getListFromApi();
  }

  @override
  List<Widget> getPageWidget() {
    return [
      Column(
      children: <Widget>[
        //getWelcomeNotificationWidget(),
        getList<NotificationBloc>(bloc,()=> ItemNotification(),isSingleParameterCallback: false, onItemClicked:(item,position)=> onNotificationItemPressed(item,position), apiCallback: ()=> bloc.resetBadgeCount(callback: _updateReadCount)),
      ],
    ),
      showLoaderWithNonItemMessage<NotificationBloc>(bloc,msg: localize('empty_notification'),textColor: ColorResource.marine_blue_two)
    ];
  }

 Widget getWelcomeNotificationWidget(){
    return Consumer<NotificationBloc>(
      builder: (context,bloc,_) {
        final item =NotificationContent.wlc(localize('wlc_gim'), localize('thank_joining'),
            createdAt: DateTime.now().millisecondsSinceEpoch) ;
        BaseItemView child=ItemNotification();
        child.item=item;
        return Visibility(
          visible: bloc.shouldShowNotification,
          child:Container(
              decoration: BoxDecoration( //                    <-- BoxDecoration
                border: Border(bottom: BorderSide(color: ColorResource.divider_color)),
              ),child: child) ,
        );
      },
    );
  }
  onNotificationItemPressed(NotificationContent item,int position) async {
    print(item.notificationType.toString()+":"+item.objectId.toString());
    List<int> unReadNotificationIds=[];
    if(!item.read) {
      unReadNotificationIds.add(item.notificationId);
      bloc.readNotification(unReadNotificationIds,_updateReadCount);
    }

    switch (item.notificationType) {
      case Constants.PARTNER_CANCELS_WON_BID:
      case Constants.PATNER_WITHDRAW_BID:
      case Constants.NEW_BID_RECEIVED:
        await bloc.getBidStatus(item.objectId, (BidStatusResponse item) {
          doActionOnBidStatus(item);
        },errorCallback: (ApiResponse response){
          showSnackBar(scaffoldState.currentState, response.message);
        });
        break;
      case Constants.PARTNER_RECEIVED_REWARD:
      case Constants.CUSTOMER_RECEIVED_REWARD:
      case Constants.REFERRER_RECEIVED_REWARD:
        break;
      case Constants.DISTRIBUTOR_APPROVED:
        break;
      case Constants.CUSTOMER_APPROVED:
        break;
      default:
        await bloc.getTripStatus(item.objectId, (item) {
          doActionOnTripStatus(item);
        },errorCallback: (ApiResponse response){
          showSnackBar(scaffoldState.currentState, response.message);
        });

    }
  }

  doActionOnTripStatus(TripItem item){
    TripItem tripItem = item;
    print("tripStatus:"+tripItem.tripStatus);
    var status = tripItem.tripStatus;
    if (status == Constants.RUNNING) {
      gotoBookedDetailPage( item, TRIP_STATUS.RUNNING);
    } else if (status == Constants.COMPLETED) {
      if (tripItem.tripTruckRating == null &&
          tripItem.tripDriverRating == null) {
        navigateNextScreen(context, AddARatingScreen(item.id));
      } else {
        gotoBookedDetailPage( item, TRIP_STATUS.COMPLETED);
      }
    } else if (status == Constants.CANCELLED || status == Constants.REJECTED) {
      showSnackBar(scaffoldState.currentState, translate(context, 'trip_cancelled_msg'));
    } else if (status == Constants.BOOKED) {
      gotoBookedDetailPage(item, TRIP_STATUS.BOOKED);
    } else if (status == Constants.BIDDED) {
      navigateNextScreen(context, ViewBidListScreen(item));
    } else {
      navigateNextScreen(context, TripDetailPageContainer(tripId: item.id,));
    }
  }
  doActionOnBidStatus(BidStatusResponse item){
    var tripStatus=item.tripModel.tripStatus;
    print("tripStatus:"+tripStatus);
    print("bidStatus:"+item.bidStatus);
    if(item.bidStatus==Constants.ACCEPTED){
      if(tripStatus==Constants.BOOKED){
        gotoBookedDetailPage( item.tripModel, TRIP_STATUS.BOOKED);
      }else if(tripStatus==Constants.RUNNING){
        gotoBookedDetailPage( item.tripModel, TRIP_STATUS.RUNNING);

      }else if(tripStatus==Constants.COMPLETED){
        gotoBookedDetailPage( item.tripModel, TRIP_STATUS.COMPLETED);

      }else if(tripStatus==Constants.CANCELLED){
        showSnackBar(scaffoldState.currentState,translate(context, 'trip_cancelled_msg'));
      }else{
        bloc.getTripStatus(item.tripModel.id, (item){
          doActionOnTripStatus(item);
        });
      }
    }else if(item.bidStatus==Constants.REJECTED){
      showSnackBar(scaffoldState.currentState,translate(context, 'bid_rejected_msg'));

    }else if(item.bidStatus==Constants.PENDING){
      if(tripStatus==Constants.EXPIRED){
        showSnackBar(scaffoldState.currentState,translate(context, 'trip_is_expired_msg'));

      }else if(tripStatus==Constants.BIDDED){
        navigateNextScreen(context, ViewBidListScreen(item.tripModel));
      }else{
        showSnackBar(scaffoldState.currentState,item.tripModel.tripStatus);
      }

    }else if(item.bidStatus==Constants.CANCELLED){
      showSnackBar(scaffoldState.currentState,translate(context, 'bid_cancelled_msg'));
    }
  }
  gotoBookedDetailPage(TripItem item,TRIP_STATUS tripStatus){
    navigateNextScreen(context, BookingDetailContainer(tripId: item.id,tripStatus:tripStatus,));
  }
}