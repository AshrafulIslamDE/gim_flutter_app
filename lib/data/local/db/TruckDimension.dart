import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/generated/i18n.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TruckDimension.g.dart';

@JsonSerializable()
class TruckDimensions{
  @JsonKey(name: 'Length')
  List<TruckDimensionLength>length;
  @JsonKey(name: 'Width')
  List<TruckDimensionWidth>width;
  @JsonKey(name: 'Height')
  List<TruckDimensionHeight>height;
  TruckDimensions();
  factory TruckDimensions.fromJson(Map<String, dynamic> json)=>_$TruckDimensionsFromJson(json);

}

@Entity()
@JsonSerializable()
class TruckDimensionLength{
  @primaryKey
  int id;
  String value;
  TruckDimensionLength(this.id,this.value);
  factory TruckDimensionLength.fromJson(Map<String, dynamic> json)=>_$TruckDimensionLengthFromJson(json);

  @override
  String toString() {
    return isBangla()?localize('number_decimal_count',dynamicValue: value.toString(),symbol: '%f'):value.toString();
  }

}

@dao
abstract class TruckDimensionLengthDao{
  @Query("SELECT * from TruckDimensionLength")
  Future<List<TruckDimensionLength>>getAll();

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertAll( List<TruckDimensionLength> items);

  @Query("DELETE from TruckDimensionLength")
  Future<void> deleteAll();

}

@Entity()
@JsonSerializable()
class TruckDimensionWidth{
  @primaryKey
  int id;
  String value;
  TruckDimensionWidth(this.id,this.value);
  factory TruckDimensionWidth.fromJson(Map<String, dynamic> json)=>_$TruckDimensionWidthFromJson(json);

  @override
  String toString() {
    return isBangla()?localize('number_decimal_count',dynamicValue: value.toString(),symbol: '%f'):value.toString();
  }
}

@dao
abstract class TruckDimensionWidthDao{
  @Query("SELECT * from TruckDimensionWidth")
  Future<List<TruckDimensionWidth>>getAll();

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertAll( List<TruckDimensionWidth> items);

  @Query("DELETE from TruckDimensionWidth")
  Future<void> deleteAll();

}

@Entity()
@JsonSerializable()
class TruckDimensionHeight{
  @primaryKey
  int id;
  String value;
  TruckDimensionHeight(this.id,this.value);
  factory TruckDimensionHeight.fromJson(Map<String, dynamic> json)=>_$TruckDimensionHeightFromJson(json);

  @override
  String toString() {
    return isBangla()?localize('number_decimal_count',dynamicValue: value.toString(),symbol: '%f'):value.toString();
  }
}

@dao
abstract class TruckDimensionHeightDao{
  @Query("SELECT * from TruckDimensionHeight")
  Future<List<TruckDimensionHeight>>getAll();

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertAll( List<TruckDimensionHeight> items);

  @Query("DELETE from TruckDimensionHeight")
  Future<void> deleteAll();

}