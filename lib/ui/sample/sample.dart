import 'package:customer/data/local/db/truck_types.dart';
import 'package:customer/features/master/master_repository.dart';
import 'package:customer/ui/sample/samplebloc.dart';
import 'package:customer/ui/widget/auto_suggestion_widget.dart';
import 'package:customer/ui/widget/autocompleteTextField.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../widget/dropdown.dart';


class Sample extends StatefulWidget{
 // final _scaffoldKey = GlobalKey<ScaffoldState>();
  //final listViewKey =GlobalKey();


  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  List<TruckType>list=List();

  @override
  void initState() {
    MasterRepository.getTruckTypes().then((onValue){
      setState(() {
        list=onValue;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: false);

    var isButtonInitialized=false;

    decideTextcolor(){
      isButtonInitialized=true;
      var bloc=Provider.of<SampleBloc>(context,listen: false);
      if(bloc.buttonText=="Button") {
        bloc.buttonText="Button1";
        return ColorResource.colorWhite;
      }
      else {
        bloc.buttonText="Button";
        return ColorResource.colorMariGold;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("smaple ui"),
      ),
      body: Container(
        color: ColorResource.colorWhite,

        child: Column(
          children: <Widget>[
            AutocompleteSuggestionWidget(
        labelText: 'AutocompleteTextView',
        suggestionList: ['Noghtat','Marshmallow','Kitkat'],
         onSuggestionItemSelected: (value){showToast(value);},
        ),
            DropDownWidget(dropDownItems:!isNullOrEmptyList(list)?list:['Noghtat','Marshmallow','Kitkat'],
              labelText: "Flavor",withImg: !isNullOrEmptyList(list)?true:false,
              onItemSelcted: (value){
              print(value.toString());
              }, ),



          ],

        ),
      ),
    );
  }
}


_getTripList() async {

}

/*import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:customer/model/notifications/notification_content.dart';
import 'package:customer/model/notifications/push_notification.dart';
import 'package:customer/ui/notification/notification_handler.dart';
import 'package:customer/utils/prefs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:customer/networking/background_process.dart';

class FireBaseNotifications {
  StreamController _streamController;
  FirebaseMessaging _fireBaseMessaging;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Map<String,dynamic>incomingBackgroundPushMSg;
  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message)async {
    print("messagehandler");
    _streamController = StreamController();
    _streamController.sink.add(message);
    incomingBackgroundPushMSg=message;
    showNotification(message);
    return Future<void>.value();
  }
  StreamController setUpFireBase() {
    _fireBaseMessaging = FirebaseMessaging();
    var android = AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform,
        onSelectNotification: onSelectNotification);
    fireBaseCloudMessagingListeners();
    return _streamController;
  }

  void fireBaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();

    _fireBaseMessaging.getToken().then((token) {
      print("fcmtoken" + token);
      Prefs.setString(Prefs.PREF_DEVICE_TOKEN, token);
      updateFcmToken(token);
    });

    _fireBaseMessaging.configure(
      onBackgroundMessage: Platform.isIOS?null: myBackgroundMessageHandler,
      onMessage: (Map<String, dynamic> message) async {
        _streamController = StreamController();
        _streamController.sink.add(message);
        print("on message");
        showNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        _streamController = StreamController();
        _streamController.sink.add(message);
        print("on reseume");
        onSelectNotification(message.toString());
        //showNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        _streamController = StreamController();
        _streamController.sink.add(message);
        print("on launch");
        onSelectNotification(message.toString());
        // showNotification(message);
      },
    );
  }



  void iOSPermission() {
    _fireBaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _fireBaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void showNotification(Map<String, dynamic> msg) async {
    var data =getPushNotificationData(msg);
    var android = AndroidNotificationDetails(data.title,
        data.body, 'notification_channel',
        importance: Importance.Max, priority: Priority.High);
    var iOS = new IOSNotificationDetails(presentAlert: true);
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, data.title, data.body, platform,
        payload: msg.toString());
  }

  PushNotificationData getPushNotificationData(Map<String, dynamic> msg){
    Map<String, dynamic> jsonEncoded;
    var jsonEncoded2;
    if(Platform.isIOS) {
      jsonEncoded = msg;
      print(msg['notification']['title']);
      print(msg['notificationId']);
      print(jsonEncoded['title']);
      print(jsonEncoded['body']);
      // msg = json.decode(jsonEncoded);

    }else {
      print("data:${msg['data']}");
      jsonEncoded=msg['data'].cast<String,dynamic>();

    }
    jsonEncoded2 = json.encode(msg['notification']);
    //print("jsonencode:"+jsonEncoded);
    // print("jsonencode:"+jsonEncoded2);

    PushNotificationData data=PushNotificationData.fromJson(jsonEncoded);

    data.title=data.title??msg['notification']['title'];
    data.body=data.body??msg['notification']['body'];

    return data;
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    debugPrint('onDidReceiveLocalNotification: ' + payload);
  }

  Future onSelectNotification(String payload) async {
    debugPrint('notification payload: ' + payload);
    var subscription;
    if (payload != null) {
      print("afterPayload");
      if(_streamController==null){
        if(incomingBackgroundPushMSg!=null) manageNotification(incomingBackgroundPushMSg);
        return;
      }
      subscription = _streamController?.stream?.listen((pushMsg) {
        print("listenstream");
        subscription?.cancel();
        manageNotification(pushMsg);
        _streamController?.close();
      });
    }
  }
  manageNotification(Map<String,dynamic> pushMsg){
    var data=getPushNotificationData(pushMsg);
    if (data.notificationType == null) return;
    NotificationNavigationHandler().onNotificationItemPressed(
        NotificationContent(
            notificationId: int.parse(data.notificationId),
            notificationType: int.parse(data.notificationType),
            objectId: int.parse(data.objectId))
    );
  }

  Map<String,dynamic> convert(String payload){
    Map<String,dynamic> valueMap = json.decode(payload);
    return valueMap;

  }
}*/

