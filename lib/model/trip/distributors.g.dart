// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distributors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Distributors _$DistributorsFromJson(Map<String, dynamic> json) {
  return Distributors()
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Distributors.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$DistributorsToJson(Distributors instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Distributor _$DistributorFromJson(Map<String, dynamic> json) {
  return Distributor()
    ..userId = json['userId'] as int
    ..name = json['name'] as String
    ..mobileNumber = json['mobileNumber'] as String;
}

Map<String, dynamic> _$DistributorToJson(Distributor instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'mobileNumber': instance.mobileNumber,
    };
