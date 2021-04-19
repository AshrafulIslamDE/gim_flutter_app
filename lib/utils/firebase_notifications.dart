import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:customer/data/constants.dart';
import 'package:customer/model/notifications/notification_content.dart';
import 'package:customer/model/notifications/push_notification.dart';
import 'package:customer/ui/notification/notification_handler.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:customer/networking/background_process.dart';

//import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:overlay_support/overlay_support.dart';

class FireBaseNotifications {
  static StreamController streamController;
  FirebaseMessaging _fireBaseMessaging;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void setUpFireBase() {
    _fireBaseMessaging = FirebaseMessaging();
    streamController = StreamController.broadcast();
    initLocalNotification();
    fireBaseCloudMessagingListeners();
  }

  initLocalNotification() {
    if (!Platform.isIOS) {
      flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin == null
          ? FlutterLocalNotificationsPlugin()
          : flutterLocalNotificationsPlugin;
      var initializationSettingsAndroid =
          AndroidInitializationSettings('ic_gim_logo');
      var initializationSettingsIOS = IOSInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
      var initializationSettings = InitializationSettings(
          initializationSettingsAndroid, initializationSettingsIOS);
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: onNonIosSelectNotification);
    }
  }

  void fireBaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();

    _fireBaseMessaging.getToken().then((token) {
      print("Found fcmtoken from firebase: " + token);
      Prefs.setString(Prefs.PREF_DEVICE_TOKEN, token);
      Prefs.getBool(Prefs.IS_LOGGED_IN).then((res) {
        if (res) updateFcmToken(token);
      });
    });
    _fireBaseMessaging.configure(
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onMessage: (Map<String, dynamic> message) async {
        sinkMessage(message);
        manageNotification(message);
        showNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        sinkMessage(message);
        manageNotification(message);
        onSelectNotification(getPushNotificationData(message));
      },
      onLaunch: (Map<String, dynamic> message) async {
        manageNotification(message);
        onSelectNotification(getPushNotificationData(message));
      },
    );
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    manageNotification(message);
    sinkMessage(message);
    showNotification(message);
    return null;
  }

  static sinkMessage(Map<String, dynamic> message) {
    if (streamController == null)
      streamController = StreamController.broadcast();
    streamController.sink.add(message);
  }

  void iOSPermission() async {
    var soundAlert = await Prefs.getBool(
        Prefs.PREF_IS_NOTIFICATIONS_SOUND_ACTIVATED,
        defaultValue: true);
    _fireBaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: soundAlert, badge: true, alert: true));
    _fireBaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  static void showNotification(Map<String, dynamic> msg) async {
    var data = getPushNotificationData(msg);
    if (Platform.isIOS)
      showCustomNotification(data);
    else {
      try {
        var soundAlert = Prefs.getBoolean(
            Prefs.PREF_IS_NOTIFICATIONS_SOUND_ACTIVATED,
            defaultValue: true);
        var android = AndroidNotificationDetails(
          data.objectId ?? '0',
          "notification_channel",
          'GIM Notifications',
          importance: Importance.Max,
          priority: Priority.High,
          playSound: soundAlert,
        );

        var iOS = new IOSNotificationDetails(
            presentAlert: true, presentSound: soundAlert);
        var platform = new NotificationDetails(android, iOS);
        await flutterLocalNotificationsPlugin.show(
            int.parse(data.objectId) ?? 0, data.title, data.body, platform,
            payload: msg.toString());
      } catch (ex) {
        print("ex:${ex}");
      }
    }
  }

  static manageNotification(Map<String, dynamic> msg) async {
    print("enter manage:");
    var data = getPushNotificationData(msg);
    try {
      if (data.notificationType != null) {
        if (int.parse(data.notificationType) == Constants.CUSTOMER_APPROVED)
          await Prefs.setBoolean(Prefs.IS_APPROVED_USER, true);
        else if (int.parse(data.notificationType) ==
            Constants.DISTRIBUTOR_APPROVED)
          await Prefs.setBoolean(Prefs.IS_DISTRIBUTOR, true);
      }
    } catch (exception) {
      print("manageNotificationIssue:" + exception.toString());
    }
  }

  static showCustomNotification(data) {
    showOverlayNotification((context) {
      return SlideDismissible(
        key: ValueKey('msg'),
        enable: true,
        child: GestureDetector(
          onTap: () {
            OverlaySupportEntry.of(context).dismiss();
            print(
                'Firebase Notification showCustomNotification =================?????????>>>>>>>>');
            onSelectNotification(data);
          },
          child: Card(
            color: ColorResource.colorMarineBlue,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    'svg_img/gim_logo.svg',
                    height: 28,
                    width: 28,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data.title,
                          style: TextStyle(
                              color: ColorResource.colorWhite, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          data.body,
                          style: TextStyle(
                              color: ColorResource.colorWhite, fontSize: 14.0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          ),
        ),
      );
    }, duration: Duration(milliseconds: 4000));
  }

  static PushNotificationData getPushNotificationData(
      Map<String, dynamic> msg) {
    print(msg.toString());
    Map<String, dynamic> jsonEncoded;
    var jsonEncoded2;
    if (Platform.isIOS) {
      jsonEncoded = msg;
    } else {
      jsonEncoded = msg['data'].cast<String, dynamic>();
    }
    jsonEncoded2 = json.encode(msg['notification']);
    //print("jsonencode:"+jsonEncoded);
    // print("jsonencode:"+jsonEncoded2);

    PushNotificationData data = PushNotificationData.fromJson(jsonEncoded);

    data.title = data.title ?? msg['notification']['title'];
    data.body = data.body ?? msg['notification']['body'];

    /*var badge = msg['data']['badge'];
    print('push notification badge $badge');

    if(!isNullOrEmpty(badge)) {
      var count = int.parse(badge);
      FlutterAppBadger.updateBadgeCount(count);
    }*/

    return data;
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    debugPrint('onDidReceiveLocalNotification: ' + payload);
  }

  static onSelectNotification(data) async {
    if (data != null) {
      if (data.notificationType == null) return;
      if (int.parse(data.notificationType) == Constants.CUSTOMER_APPROVED)
        await Prefs.setBoolean(Prefs.IS_APPROVED_USER, true);
      NotificationNavigationHandler().onNotificationItemPressed(
          NotificationContent(
              notificationId: int.parse(data.notificationId.toString()),
              notificationType: int.parse(data.notificationType),
              objectId: int.parse(data.objectId)));
      /*_streamController.close();*/
    }
  }

  Future onNonIosSelectNotification(String payload) async {
    var pushData = PushNotificationData();
    pushData.setUpVal(payload);
    if (pushData.notificationId ==
        Prefs.getString(Prefs.LAST_HANDLED_NOTIFICATION)) return;
    Prefs.setString(Prefs.LAST_HANDLED_NOTIFICATION, pushData.notificationId);
    onSelectNotification(pushData);
  }
}
