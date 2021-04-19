import 'package:customer/data/constants.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notification_content.g.dart';

@JsonSerializable()
class NotificationContent{
  @JsonKey(name:"notificationId")
  int notificationId;
  @JsonKey(name:"objectId")
  int objectId;
  @JsonKey(name:"notificationType")
  int notificationType;
  @JsonKey(name:"data")
  NotificationData data = NotificationData();
  @JsonKey(name:"message")
  String message;

  @JsonKey(name:"userImage")
  String userImage;
  @JsonKey(name:"userName")
  String userName;
  @JsonKey(name:"modifiedAt")
  int modifiedAt;
  @JsonKey(name:"createdAt")
  int createdAt;
  @JsonKey(name:"read")
  bool read;
  String description;
  @JsonKey(ignore: true)
  bool isWelcomeNotification=false;
  NotificationContent({this.notificationId, this.notificationType, this.objectId});
  NotificationContent.internal({this.notificationType,this.objectId});
  NotificationContent.wlc(this.message,this.description,{this.isWelcomeNotification=true,this.read=true,this.createdAt});
  bool isReferralNotifiction(){
    switch(notificationType){
      case Constants.PARTNER_RECEIVED_REWARD:
      case Constants.CUSTOMER_RECEIVED_REWARD:
      case Constants.REFERRER_RECEIVED_REWARD:
        return true;
      default:return false;
    }
  }
  factory NotificationContent.fromJson(Map<String,dynamic>json)=>_$NotificationContentFromJson(json);
}

@JsonSerializable()
class NotificationData{
  @JsonKey(name:"dateTime")
  int dateTime;
  @JsonKey(name:"senderId")
  int senderId;
  @JsonKey(name:"address")
  String address;
  @JsonKey(name:"notificationType")
  int notificationType;
  @JsonKey(name:"bidAmount")
  double bidAmount;
  NotificationData();
  factory NotificationData.fromJson(Map<String,dynamic>json)=>_$NotificationDataFromJson(json);

}