
import 'package:json_annotation/json_annotation.dart';

part 'lc_number.g.dart';

@JsonSerializable()
class LCNumber{
  List<String> data;
  LCNumber();
  factory LCNumber.fromJson(Map<String, dynamic> json) =>
      _$LCNumberFromJson(json);

  Map<String, dynamic> toJson() => _$LCNumberToJson(this);

}

