import 'package:customer/bloc/base_pagination_bloc.dart';
import 'package:customer/data/repository/bid_repository.dart';
import 'package:customer/data/repository/notification_repository.dart';
import 'package:customer/data/repository/trip_repository.dart';
import 'package:customer/model/base.dart';
import 'package:customer/model/bid/bid_status_response.dart';
import 'package:customer/model/notifications/count_response.dart';
import 'package:customer/model/notifications/notification_content.dart';
import 'package:customer/model/notifications/notification_read_list_request.dart';
import 'package:customer/model/trip/trip.dart';
import 'package:customer/utils/common_utils.dart';

class NotificationBloc extends BasePaginationBloc<NotificationContent> {
  NotificationBloc();

  NotificationBloc.internal();

  var _shouldShowWelcomeNotification = false;

  get shouldShowNotification => _shouldShowWelcomeNotification;

  set shouldShowNotification(value) {
    if (value != shouldShowNotification) {
      _shouldShowWelcomeNotification = value;
      notifyListeners();
    }
  }

  static final NotificationBloc instance = NotificationBloc.internal();

  @override
  getListFromApi({callback}) async {
    isLoading = true;
    queryParam = {
      'size': size.toString(),
      'page': currentPage.toString(),
      "roleId": 5.toString()
    };
    var response =
        await NotificationRepository.getNotificationList(getBaseQueryParam());
    checkResponse(response, successCallback: () {
      var data = BasePagination<NotificationContent>.fromJson(response.data);
      //data.contentList=List();
      setPaginationItem(data);
      if (currentPage == 2 && callback != null) callback();
      //  shouldShowNotification=isNullOrEmptyList(data.contentList);
    });
    takeDecisionShowingError(response);
  }

  getNotificationCount({callback}) async {
    var response = await NotificationRepository.getUnReadCount();
    checkResponse(response, successCallback: () {
      callback(UnReadCountResponse.fromJson(response.data));
    });
  }

  getBidStatus(int bidId, callback, {errorCallback}) async {
    if (!isLoading) {
      isLoading = true;
      var queryParam = {'bidId': bidId};
      var response = await BidRepository.getBidStatus(queryParam);
      checkResponse(response, successCallback: () {
        callback(BidStatusResponse.fromJson(response.data));
      }, errorCallback: errorCallback);
      isLoading = false;
      return response;
    }
  }

  readNotification(notificationList, Function callback) async {
    var response = await NotificationRepository.markRead(
        NotificationReadListRequest(notificationList));
    if (!isApiError(response)) {
      callback();
      final NotificationContent item = (itemList
          .where((item) => item.notificationId == notificationList[0])
          .single) as NotificationContent;
      item.read = true;
      notifyListeners();
    }
  }

  markReadNotification(notificationList) async {
    var response = await NotificationRepository.markRead(
        NotificationReadListRequest(notificationList));
    if (!isApiError(response)) {}
  }

  getTripStatus(int tripId, callback, {errorCallback}) async {
    if (!isLoading) {
      isLoading = true;
      var queryParam = {'tripId': tripId};
      var response = await TripRepository.getTripStatus(queryParam);
      checkResponse(response, successCallback: () {
        TripItem item = TripItem.fromJson(response.data);
        callback(item);
        var status = item.tripStatus;
      }, errorCallback: errorCallback);
      isLoading = false;
      return response;
    }
  }

  resetBadgeCount({callback}) async {
    var response = await NotificationRepository.resetBadgeCount();
    checkResponse(response, successCallback: () {
      callback();
    });
  }
}
