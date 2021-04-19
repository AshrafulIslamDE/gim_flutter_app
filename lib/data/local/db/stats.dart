import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
part 'stats.g.dart';

@JsonSerializable()
@Entity(tableName : 'UserTimeSpent')
class UserTimeSpent {
   @PrimaryKey()
   final String timeIn;
   String timeOut;
   final String date;

  UserTimeSpent(this.timeIn,this.timeOut,this.date);

  factory UserTimeSpent.fromJson(Map<String, dynamic> json) => _$UserTimeSpentFromJson(json);
  Map<String, dynamic> toJson() => _$UserTimeSpentToJson(this);
}

@dao
abstract class UserTimeSpentDao{
  @Query("SELECT * from UserTimeSpent")
  Future<List<UserTimeSpent>>getAll();

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insert(UserTimeSpent userTimeSpent);

  @Update()
  Future<void> update(UserTimeSpent userTimeSpent);

  @Query("DELETE from UserTimeSpent")
  Future<void> deleteAll();
}
