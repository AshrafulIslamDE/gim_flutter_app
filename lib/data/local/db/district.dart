
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
part 'district.g.dart';
@Entity(tableName:"districtCodes" )
@JsonSerializable()
class DistrictCode{
  @primaryKey
  int id;
  String text;
  String image;
  String textBn;
  DistrictCode(this.id,this.text,this.image,this.textBn);
  factory DistrictCode.fromJson(Map<String, dynamic> json) => _$DistrictCodeFromJson(json);
  Map<String, dynamic> toJson() => _$DistrictCodeToJson(this);
  @override
  String toString() {
    return isBangla()? textBn:text;
  }
}

@dao
abstract class DistrictDao{
  @Query("SELECT * from districtCodes")
  Future<List<DistrictCode>>getAll();

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertAll( List<DistrictCode> districts);

  @Query("DELETE from districtCodes")
  Future<void> deleteAll();

}