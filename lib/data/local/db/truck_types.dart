import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/data/local/db/master_data.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'truck_types.g.dart';

@Entity(tableName: "truckType")
@JsonSerializable()
class TruckType {
  @primaryKey
  int id;
  String text;
  String textBn;
  String image;
  int sequence;

  TruckType(this.id, this.text, this.textBn, this.image, this.sequence);

  factory TruckType.fromJson(Map<String, dynamic> json) =>
      _$TruckTypeFromJson(json);

  Map<String, dynamic> toJson() => _$TruckTypeToJson(this);

  @override
  String toString() => isBangla()?textBn:text;
}

@dao
abstract class TruckTypeDao {
  @Query("SELECT * from truckType")
  Future<List<TruckType>> getAll();

  @Query('SELECT * from truckType where text = :engName')
  Future<TruckType> findTruckBanglaName(String engName);

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertAll(List<TruckType> items);

  @Query("DELETE from truckType")
  Future<void> deleteAll();
}
