
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'good_type.g.dart';

@JsonSerializable()
class Goods{
  List<GoodType> data;
  Goods();
  factory Goods.fromJson(Map<String, dynamic> json) => _$GoodsFromJson(json);
  Map<String, dynamic> toJson() => _$GoodsToJson(this);
}

@JsonSerializable()
class GoodType{
  int id;
  int masterGoodsTypeId;
  String masterGoodsTypeName;
  String masterGoodsTypeNameBn;
  GoodType();
  factory GoodType.fromJson(Map<String, dynamic> json) => _$GoodTypeFromJson(json);
  Map<String, dynamic> toJson() => _$GoodTypeToJson(this);

  @override
  String toString() {
    return isBangla() ? masterGoodsTypeNameBn ?? masterGoodsTypeName : masterGoodsTypeName;
  }
}

