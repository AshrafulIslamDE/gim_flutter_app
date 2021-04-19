// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TruckDimension.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TruckDimensions _$TruckDimensionsFromJson(Map<String, dynamic> json) {
  return TruckDimensions()
    ..length = (json['Length'] as List)
        ?.map((e) => e == null
            ? null
            : TruckDimensionLength.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..width = (json['Width'] as List)
        ?.map((e) => e == null
            ? null
            : TruckDimensionWidth.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..height = (json['Height'] as List)
        ?.map((e) => e == null
            ? null
            : TruckDimensionHeight.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TruckDimensionsToJson(TruckDimensions instance) =>
    <String, dynamic>{
      'Length': instance.length,
      'Width': instance.width,
      'Height': instance.height,
    };

TruckDimensionLength _$TruckDimensionLengthFromJson(Map<String, dynamic> json) {
  return TruckDimensionLength(
    json['id'] as int,
    json['value'] as String,
  );
}

Map<String, dynamic> _$TruckDimensionLengthToJson(
        TruckDimensionLength instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };

TruckDimensionWidth _$TruckDimensionWidthFromJson(Map<String, dynamic> json) {
  return TruckDimensionWidth(
    json['id'] as int,
    json['value'] as String,
  );
}

Map<String, dynamic> _$TruckDimensionWidthToJson(
        TruckDimensionWidth instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };

TruckDimensionHeight _$TruckDimensionHeightFromJson(Map<String, dynamic> json) {
  return TruckDimensionHeight(
    json['id'] as int,
    json['value'] as String,
  );
}

Map<String, dynamic> _$TruckDimensionHeightToJson(
        TruckDimensionHeight instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };
