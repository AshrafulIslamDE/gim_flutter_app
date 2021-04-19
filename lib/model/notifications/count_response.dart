import 'package:json_annotation/json_annotation.dart';
part 'count_response.g.dart';
@JsonSerializable()
class UnReadCountResponse{
   int count;
   UnReadCountResponse();
   factory UnReadCountResponse.fromJson(Map<String,dynamic>json)=>_$UnReadCountResponseFromJson(json);
}