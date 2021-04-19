import 'package:customer/data/local/db/customer_trip_cancel_reason.dart';
import 'package:customer/data/local/db/truck_size.dart';
import 'package:customer/data/local/db/truck_types.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'TruckDimension.dart';
import 'district.dart';
import 'goods_type.dart';
part 'master_data.g.dart';

@JsonSerializable()
class MasterDataResponse{
  @JsonKey(name: 'districts')
  List<DistrictCode> district;
  @JsonKey(name: 'districtCodes')
  List<DistrictCode> districtCodes;
  @JsonKey(name: 'goodTypes')
  List<GoodsType>goodTypes;
  @JsonKey(name: 'truckTypes')
  List<TruckType>truckTypes;
  @JsonKey(name: 'customerCancelTripReasons')
  List<CustomerTripCancelReason>customerCancelTripReasons;
  @JsonKey(name: 'truckDimensions')
  TruckDimensions truckDimensions;
  MasterDataResponse(this.district,this.goodTypes);
  List<TruckSize> truckSizes;
  factory MasterDataResponse.fromJson(Map<String, dynamic> json) => _$MasterDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MasterDataResponseToJson(this);
}

 class BaseMasterData{
  int id;
  String text;
  String image;
  String textBn;
  BaseMasterData();
}