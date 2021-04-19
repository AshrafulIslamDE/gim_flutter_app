 import 'package:customer/model/base.dart';
import 'package:json_annotation/json_annotation.dart';
part 'requested_trip_status.g.dart';
@JsonSerializable()
class RequestedTripStatusResponse{
   IdValuePair biddedDisplayModel=IdValuePair();
   IdValuePair unbiddedDisplayModel=IdValuePair();
   IdValuePair bookedDisplayModel=IdValuePair();
   IdValuePair liveDisplayModel=IdValuePair();
   IdValuePair completedDisplayModel=IdValuePair();
   IdValuePair requestedDisplayModel=IdValuePair();
   int serverTime;
   RequestedTripStatusResponse();
   factory RequestedTripStatusResponse.fromJson(Map<String,dynamic>json)=>_$RequestedTripStatusResponseFromJson(json);
 }