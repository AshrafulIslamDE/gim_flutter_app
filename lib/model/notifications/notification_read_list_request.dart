import 'package:json_annotation/json_annotation.dart';
part 'notification_read_list_request.g.dart';
@JsonSerializable()
class NotificationReadListRequest{
  List<int> notificationIds;
  NotificationReadListRequest(this.notificationIds);
  Map<String,dynamic>toJson()=>_$NotificationReadListRequestToJson(this);
}