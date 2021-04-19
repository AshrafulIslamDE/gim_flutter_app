import 'dart:io';

import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/data/repository/notification_repository.dart';
import 'package:customer/data/repository/user_repository.dart';
import 'package:customer/model/auth/login_response.dart';
import 'package:customer/model/notifications/count_response.dart';
import 'package:customer/model/profile/application_status_response.dart';
import 'package:customer/utils/firebase_notifications.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/remote_config.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';

class HomeBloc extends BaseBloc {
  String _title = "my_trip";
  int _notificationCount = 0;

  //what is the index((by default it is MyTrips, so value is 1) of home page(by default it is MyTrips)
  int _homePageIndex = 1;
  int mRoleId;
  String appStatus;

  //what is the  tab index(by default requested trip which is first tab Item) of MyTrips Bottom Menu Page
  int myTripTabIndex = 0;

  /*
 this value is used for showing overlay on create trip icon
 when there is no any kind of trips of Customer.
 */
  bool _hasAnyTrip = true;

  bool get hasAnyTrip => _hasAnyTrip;

  set hasAnyTrip(bool value) {
    print("hasanytrip:" + value.toString());
    if (value != hasAnyTrip) {
      _hasAnyTrip = value;
      notifyListeners();
    }
  }

  HomeBloc() {
    FireBaseNotifications.streamController.stream.listen((data) {
      notificationCount = int.parse(Platform.isIOS
          ? ((data['badge'] == null) ? notificationCount + 1 : data['badge'])
          : ((data['data']['badge'] == null
              ? notificationCount + 1
              : data['data']['badge'])));
    });
    Prefs.getInt(Prefs.ROLE_ID).then((roleId) {
      mRoleId = roleId;
    });
  }

  int get homePageIndex => _homePageIndex;

  set homePageIndex(int value) {
    _homePageIndex = value;
  }

  int get notificationCount => _notificationCount;

  set notificationCount(int value) {
    if (value < 0) value = 0;
    _notificationCount = value;
    notifyListeners();
  }

  String get title => _title;
  LoginResponse _profileInfo = LoginResponse();

  LoginResponse get profileInfo => _profileInfo;

  set profileInfo(LoginResponse value) {
    _profileInfo = value;
    appStatus = value.getUserStatus();
    notifyListeners();
  }

  set title(String value) {
    // print("Homepage title");
    _title = value;
    notifyListeners();
  }

  int _bottomNavigationSelectedIndex = 1;

  int get bottomNavigationSelectedIndex => _bottomNavigationSelectedIndex;

  navIconColor(int index) {
    return bottomNavigationSelectedIndex == index
        ? ColorResource.colorMariGold
        : Colors.white;
  }

  set bottomNavigationSelectedIndex(int value) {
    _bottomNavigationSelectedIndex = value;
  }

  onBottomNavigationItemTapped(int itemIndex) {
    if (homePageIndex != itemIndex) {
      if (itemIndex < 3) {
        _bottomNavigationSelectedIndex = itemIndex;
      }
      homePageIndex = itemIndex;
      notifyListeners();
    }
  }

  getProfileInfo() async {
    var response = await UserRepository.getProfileInfo();
    checkResponse(response, successCallback: () {
      profileInfo = LoginResponse.fromJson(response.data);
    });
    return response;
  }

  getUserStatus() async {
    var response = await UserRepository.getUserStatus(mRoleId);
    checkResponse(response, successCallback: () {
      String userStatus = ApplicationStatus.fromJson(response.data).value;
      if (userStatus != appStatus) {
        appStatus = userStatus;
        if (appStatus == "APPROVED"){
          Prefs.setBoolean(Prefs.IS_APPROVED_USER, true);
        }
        notifyListeners();
      }
    });
    return response;
  }

  getNotificationCount() async {
    var response = await NotificationRepository.getUnReadCount();
    checkResponse(response, successCallback: () {
      notificationCount = UnReadCountResponse.fromJson(response.data).count;
    });
    return response;
  }

  bool isDistributor() => Prefs.getBoolean(Prefs.IS_DISTRIBUTOR);

  onDrawerItemClick(int index) {}
}

class ProfileInfoSingleton {
  ProfileInfoSingleton._privateConstructor() {
    if (this.profileInfo == null) profileInfo = LoginResponse();
  }

  static final ProfileInfoSingleton instance =
      ProfileInfoSingleton._privateConstructor();
  LoginResponse profileInfo;
}
