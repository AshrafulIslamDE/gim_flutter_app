// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TruckType _$TruckTypeFromJson(Map<String, dynamic> json) {
  return TruckType(
    json['id'] as int,
    json['text'] as String,
    json['textBn'] as String,
    json['image'] as String,
    json['sequence'] as int,
  );
}

Map<String, dynamic> _$TruckTypeToJson(TruckType instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'textBn': instance.textBn,
      'image': instance.image,
      'sequence': instance.sequence,
    };
