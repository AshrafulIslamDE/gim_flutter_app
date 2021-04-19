import 'dart:io';

import 'package:customer/model/notifications/notification_content.dart';
import 'package:json_annotation/json_annotation.dart';
part 'push_notification.g.dart';
@JsonSerializable()
class PushNotificationData {
  @JsonKey(name:"notificationId")
  String notificationId;
  @JsonKey(name:"objectId")
  String objectId;
  @JsonKey(name:"notificationType")
  String notificationType;
  @JsonKey(name:"tripId")
  String tripId;
  @JsonKey(name:"title")
  String title;
  @JsonKey(name:'body')
  String body;
  @JsonKey(name:"dateTime")
  String dateTime;
  @JsonKey(name:"senderId")
  String senderId;
  @JsonKey(name:"address")
  String address;
 /* @JsonKey(name:"bidAmount")
  double bidAmount;*/
  PushNotificationData();
  factory PushNotificationData.fromJson(Map<String,dynamic>json)=>_$PushNotificationDataFromJson(json);

  setUpVal(String payload){
    int idIndex = payload.indexOf('notificationId:');
    int typeIndex = payload.indexOf('notificationType:');
    int objIndex = payload.indexOf('objectId:');
    if(idIndex != -1){
      idIndex += 15;
      notificationId = payload.substring(idIndex,payload.indexOf(',',idIndex)).trim();
    }
    if(typeIndex != -1){
      typeIndex += 17;
      notificationType = payload.substring(typeIndex,payload.indexOf(',',typeIndex)).trim();
    }
    if(objIndex != -1){
      objIndex += 9;
      objectId = payload.substring(objIndex,payload.indexOf(',',objIndex)).trim();
    }
  }
}

@JsonSerializable()
class UpdateFcmTokenRequest{
  @JsonKey(name:"deviceToken")
  String deviceToken;
  @JsonKey(name:"deviceType")
  String deviceType = Platform.isAndroid?"ANDROID":"IOS";
  @JsonKey(name:"roleId")
  var roleId=5;
  UpdateFcmTokenRequest(this.deviceToken);
  Map<String, dynamic> toJson() => _$UpdateFcmTokenRequestToJson(this);

}