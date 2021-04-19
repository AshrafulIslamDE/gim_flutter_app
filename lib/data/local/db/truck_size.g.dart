// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck_size.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TruckSize _$TruckSizeFromJson(Map<String, dynamic> json) {
  return TruckSize(
    json['id'] as int,
    (json['size'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$TruckSizeToJson(TruckSize instance) => <String, dynamic>{
      'id': instance.id,
      'size': instance.size,
    };
