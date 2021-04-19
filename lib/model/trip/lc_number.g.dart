// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lc_number.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LCNumber _$LCNumberFromJson(Map<String, dynamic> json) {
  return LCNumber()
    ..data = (json['data'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$LCNumberToJson(LCNumber instance) => <String, dynamic>{
      'data': instance.data,
    };
