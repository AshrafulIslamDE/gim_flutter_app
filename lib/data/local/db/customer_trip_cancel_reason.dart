
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
part 'customer_trip_cancel_reason.g.dart';
@Entity(tableName: 'customerTripCancelReason')
@JsonSerializable()
class CustomerTripCancelReason{
  @primaryKey
  int id;
  String value;
  String valueBn;
  CustomerTripCancelReason(this.id,this.value,this.valueBn);
  factory CustomerTripCancelReason.fromJson(Map<String, dynamic> json) => _$CustomerTripCancelReasonFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerTripCancelReasonToJson(this);
  @override
  String toString() {
    return isBangla()?valueBn:value;
  }
}

@dao
abstract class CustomerTripCancelReasonDao{
  @Query("SELECT * from customerTripCancelReason")
  Future<List<CustomerTripCancelReason>>getAll();


  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertAll( List<CustomerTripCancelReason> items);

  @Query("DELETE from customerTripCancelReason")
  Future<void> deleteAll();

}