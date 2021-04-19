import 'package:customer/bloc/notifications/notification_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/data/constants.dart';
import 'package:customer/model/bid/bid_status_response.dart';
import 'package:customer/model/notifications/notification_content.dart';
import 'package:customer/model/trip/trip.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/trip/booking_detail/booking_detail_page.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';

class NotificationNavigationHandler {

  onNotificationItemPressed(NotificationContent item) async {
    switch (item.notificationType) {
      case Constants.PARTNER_CANCELS_WON_BID:
      case Constants.PATNER_WITHDRAW_BID:
      case Constants.NEW_BID_RECEIVED:
        await NotificationBloc.instance.getBidStatus(item.objectId, (BidStatusResponse item) {
          doActionOnBidStatus(item);
        },errorCallback: (ApiResponse response){
          showCustomSnackbar( response.message);
        });
        break;
      case Constants.PARTNER_RECEIVED_REWARD:
      case Constants.CUSTOMER_RECEIVED_REWARD:
      case Constants.REFERRER_RECEIVED_REWARD:
        break;
      case Constants.DISTRIBUTOR_APPROVED:
      case Constants.CUSTOMER_APPROVED:
        break;
      default:
        await NotificationBloc.instance.getTripStatus(item.objectId, (item) {
          doActionOnTripStatus(item);
        },errorCallback: (ApiResponse response){
          showCustomSnackbar( response.message);
        });
    }
    NotificationBloc.instance.markReadNotification([item.notificationId]);
  }

  doActionOnTripStatus(TripItem item) {
    TripItem tripItem = item;
    print("tripStatus:" + tripItem.tripStatus);
    var status = tripItem.tripStatus;
    if (status == Constants.RUNNING) {
      gotoBookedDetailPage(item, TRIP_STATUS.RUNNING);
    } else if (status == Constants.COMPLETED) {
      if (tripItem.tripTruckRating == null &&
          tripItem.tripDriverRating == null) {
        navigateToScreen(RouteConstants.addARatingRoute, arg: item.id);
        //navigateNextScreen(getGlobalContext(), AddARatingScreen(item.id));
      } else {
        gotoBookedDetailPage(item, TRIP_STATUS.COMPLETED);
      }
    } else if (status == Constants.CANCELLED || status == Constants.REJECTED) {
      showCustomSnackbar(
          translate(getGlobalContext(), 'trip_cancelled_msg'));
    } else if (status == Constants.BOOKED) {
      gotoBookedDetailPage(item, TRIP_STATUS.BOOKED);
    } else if (status == Constants.BIDDED) {
      navigateToScreen(RouteConstants.viewBidListRoute, arg: item);
      //navigateNextScreen(getGlobalContext(), ViewBidListScreen(item));
    } else {
      navigateToScreen(RouteConstants.tripDetailRoute, arg: item.id);
      //navigateNextScreen(getGlobalContext(), TripDetailPageContainer(tripId: item.id,));
    }
  }

  doActionOnBidStatus(BidStatusResponse item) {
    var tripStatus = item.tripModel.tripStatus;
    print("tripStatus:" + tripStatus);
    print("bidStatus:" + item.bidStatus);
    if (item.bidStatus == Constants.ACCEPTED) {
      if (tripStatus == Constants.BOOKED) {
        gotoBookedDetailPage(item.tripModel, TRIP_STATUS.BOOKED);
      } else if (tripStatus == Constants.RUNNING) {
        gotoBookedDetailPage(item.tripModel, TRIP_STATUS.RUNNING);
      } else if (tripStatus == Constants.COMPLETED) {
        gotoBookedDetailPage(item.tripModel, TRIP_STATUS.COMPLETED);
      } else if (tripStatus == Constants.CANCELLED) {
        showCustomSnackbar(
            translate(getGlobalContext(), 'trip_cancelled_msg'));
      } else {
        NotificationBloc.instance.getTripStatus(item.tripModel.id, (item) {
          doActionOnTripStatus(item);
        });
      }
    } else if (item.bidStatus == Constants.REJECTED) {
      showCustomSnackbar(
          translate(getGlobalContext(), 'bid_rejected_msg'));
    } else if (item.bidStatus == Constants.PENDING) {
      if (tripStatus == Constants.EXPIRED) {
        showCustomSnackbar(
            translate(getGlobalContext(), 'trip_is_expired_msg'));
      } else if (tripStatus == Constants.BIDDED) {
        navigateToScreen(RouteConstants.viewBidListRoute, arg: item.tripModel);
        //navigateNextScreen(getGlobalContext(), ViewBidListScreen(item.tripModel));
      } else {
        showCustomSnackbar( item.tripModel.tripStatus);
      }
    } else if (item.bidStatus == Constants.CANCELLED) {
      showCustomSnackbar(translate(getGlobalContext(), 'bid_cancelled_msg'));
    }
  }

  gotoBookedDetailPage(TripItem item, TRIP_STATUS tripStatus) async{
    var map = {item.id: tripStatus};
    navigateToScreen(RouteConstants.bookingDetailRoute, arg: map);
    //navigateNextScreen(getGlobalContext(), BookingDetailContainer(tripId: item.id,tripStatus:tripStatus,));
  }
  
  
}