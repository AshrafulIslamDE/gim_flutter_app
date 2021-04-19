// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsType _$GoodsTypeFromJson(Map<String, dynamic> json) {
  return GoodsType(
    json['id'] as int,
    json['text'] as String,
    json['image'] as String,
    json['textBn'] as String,
  );
}

Map<String, dynamic> _$GoodsTypeToJson(GoodsType instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'image': instance.image,
      'textBn': instance.textBn,
    };
