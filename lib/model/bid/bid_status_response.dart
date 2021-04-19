import 'package:customer/model/trip/trip.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bid_status_response.g.dart';

@JsonSerializable()
class BidStatusResponse{
  double advanceAmount = 0.0;
  int id = 0;
  double totalAmount = 0.0;
  String bidStatus;
  TripItem tripModel;
  BidStatusResponse();
  factory BidStatusResponse.fromJson(Map<String,dynamic>json)=>_$BidStatusResponseFromJson(json);
}