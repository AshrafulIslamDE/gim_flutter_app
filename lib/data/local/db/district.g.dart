// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistrictCode _$DistrictCodeFromJson(Map<String, dynamic> json) {
  return DistrictCode(
    json['id'] as int,
    json['text'] as String,
    json['image'] as String,
    json['textBn'] as String,
  );
}

Map<String, dynamic> _$DistrictCodeToJson(DistrictCode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'image': instance.image,
      'textBn': instance.textBn,
    };
