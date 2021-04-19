
import 'package:json_annotation/json_annotation.dart';

part 'product_type.g.dart';

@JsonSerializable()
class ProductType{
  List<Product> data;
  ProductType();
  factory ProductType.fromJson(Map<String, dynamic> json) => _$ProductTypeFromJson(json);
  Map<String, dynamic> toJson() => _$ProductTypeToJson(this);
}

@JsonSerializable()
class Product{
  int productId;
  String productName;
  String productImage;
  String _image;
  String get image => productImage;
  Product();
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  String toString() {
    return productName;
  }
}