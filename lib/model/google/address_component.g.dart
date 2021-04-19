// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_component.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressComponent _$AddressComponentFromJson(Map<String, dynamic> json) {
  return AddressComponent()
    ..formatted_address = json['formatted_address'] as String
    ..address_components = (json['address_components'] as List)
        ?.map((e) =>
            e == null ? null : Address.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AddressComponentToJson(AddressComponent instance) =>
    <String, dynamic>{
      'formatted_address': instance.formatted_address,
      'address_components': instance.address_components,
    };

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address()
    ..short_name = json['short_name'] as String
    ..types = (json['types'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'short_name': instance.short_name,
      'types': instance.types,
    };
