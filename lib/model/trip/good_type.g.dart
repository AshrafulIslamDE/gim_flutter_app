// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'good_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goods _$GoodsFromJson(Map<String, dynamic> json) {
  return Goods()
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : GoodType.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GoodsToJson(Goods instance) => <String, dynamic>{
      'data': instance.data,
    };

GoodType _$GoodTypeFromJson(Map<String, dynamic> json) {
  return GoodType()
    ..id = json['id'] as int
    ..masterGoodsTypeId = json['masterGoodsTypeId'] as int
    ..masterGoodsTypeName = json['masterGoodsTypeName'] as String
    ..masterGoodsTypeNameBn = json['masterGoodsTypeNameBn'] as String;
}

Map<String, dynamic> _$GoodTypeToJson(GoodType instance) => <String, dynamic>{
      'id': instance.id,
      'masterGoodsTypeId': instance.masterGoodsTypeId,
      'masterGoodsTypeName': instance.masterGoodsTypeName,
      'masterGoodsTypeNameBn': instance.masterGoodsTypeNameBn,
    };
