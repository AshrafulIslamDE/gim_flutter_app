import 'dart:core';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
part 'goods_type.g.dart';

@Entity(tableName: "goodsType")
@JsonSerializable()
class GoodsType  {
  @primaryKey
  int id;
  String text;
  String image;
  String textBn;
  GoodsType(this.id,this.text,this.image,this.textBn);
  factory GoodsType.fromJson(Map<String, dynamic> json) => _$GoodsTypeFromJson(json);
  Map<String, dynamic> toJson() => _$GoodsTypeToJson(this);
  @override
  String toString() {
    return isBangla()?textBn??text:text;
    //return text;
  }
}

@dao
abstract class GoodsTypeDao{
  @Query("SELECT * from goodsType")
  Future<List<GoodsType>>getAll();

  @Query("SELECT * from goodsType where text = :engName")
  Future<GoodsType> findGoodsBanglaName(String engName);

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertAll( List<GoodsType> goodTypes);

  @Query("DELETE from goodsType")
  Future<void> deleteAll();

}