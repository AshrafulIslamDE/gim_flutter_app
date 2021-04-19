// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterDataResponse _$MasterDataResponseFromJson(Map<String, dynamic> json) {
  return MasterDataResponse(
    (json['districts'] as List)
        ?.map((e) =>
            e == null ? null : DistrictCode.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['goodTypes'] as List)
        ?.map((e) =>
            e == null ? null : GoodsType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..districtCodes = (json['districtCodes'] as List)
        ?.map((e) =>
            e == null ? null : DistrictCode.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..truckTypes = (json['truckTypes'] as List)
        ?.map((e) =>
            e == null ? null : TruckType.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..customerCancelTripReasons = (json['customerCancelTripReasons'] as List)
        ?.map((e) => e == null
            ? null
            : CustomerTripCancelReason.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..truckDimensions = json['truckDimensions'] == null
        ? null
        : TruckDimensions.fromJson(
            json['truckDimensions'] as Map<String, dynamic>)
    ..truckSizes = (json['truckSizes'] as List)
        ?.map((e) =>
            e == null ? null : TruckSize.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MasterDataResponseToJson(MasterDataResponse instance) =>
    <String, dynamic>{
      'districts': instance.district,
      'districtCodes': instance.districtCodes,
      'goodTypes': instance.goodTypes,
      'truckTypes': instance.truckTypes,
      'customerCancelTripReasons': instance.customerCancelTripReasons,
      'truckDimensions': instance.truckDimensions,
      'truckSizes': instance.truckSizes,
    };
