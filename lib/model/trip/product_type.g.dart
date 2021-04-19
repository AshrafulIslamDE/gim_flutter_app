// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductType _$ProductTypeFromJson(Map<String, dynamic> json) {
  return ProductType()
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Product.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ProductTypeToJson(ProductType instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product()
    ..productId = json['productId'] as int
    ..productName = json['productName'] as String
    ..productImage = json['productImage'] as String;
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'productImage': instance.productImage,
    };
