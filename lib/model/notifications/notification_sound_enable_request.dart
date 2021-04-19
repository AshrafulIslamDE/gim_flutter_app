import 'package:json_annotation/json_annotation.dart';
part 'notification_sound_enable_request.g.dart';
@JsonSerializable()
class NotificationSoundEnableRequest{
  int roleId=5;
  bool sound=true;
  String deviceType="IOS";
  NotificationSoundEnableRequest({this.sound});
  Map<String,dynamic>toJson()=>_$NotificationSoundEnableRequestToJson(this);
}