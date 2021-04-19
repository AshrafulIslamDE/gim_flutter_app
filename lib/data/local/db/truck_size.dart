
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
part 'truck_size.g.dart';

@Entity()
@JsonSerializable()
class TruckSize{
  @primaryKey
  int id;
  double size;
  TruckSize(this.id,this.size);
  factory TruckSize.fromJson(Map<String, dynamic> json) => _$TruckSizeFromJson(json);
  Map<String, dynamic> toJson() => _$TruckSizeToJson(this);

  @override
  String toString() {
   return (isBangla()?localize('number_decimal_count',dynamicValue: size.toString(),symbol: '%f'):size.toString())+localize('txt_ton');
  }
}

@dao
abstract class TruckSizeDao{
  @Query("SELECT * from TruckSize")
  Future<List<TruckSize>>getAll();

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertAll( List<TruckSize> items);

  @Query("DELETE from TruckSize")
  Future<void> deleteAll();

}