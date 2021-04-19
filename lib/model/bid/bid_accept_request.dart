
import 'package:json_annotation/json_annotation.dart';
part 'bid_accept_request.g.dart';

@JsonSerializable()
class BidAcceptRequest{
 int id;
 BidAcceptRequest(this.id);
 Map<String, dynamic> toJson() => _$BidAcceptRequestToJson(this);

}