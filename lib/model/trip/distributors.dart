import 'package:json_annotation/json_annotation.dart';

part 'distributors.g.dart';

@JsonSerializable()
class Distributors{
  List<Distributors> data;
  Distributors();
  factory Distributors.fromJson(Map<String, dynamic> json) => _$DistributorsFromJson(json);
  Map<String, dynamic> toJson() => _$DistributorsToJson(this);
}

@JsonSerializable()
class Distributor{
  int userId;
  String name;
  String mobileNumber;
  Distributor();
  factory Distributor.fromJson(Map<String, dynamic> json) => _$DistributorFromJson(json);
  Map<String, dynamic> toJson() => _$DistributorToJson(this);

  @override
  String toString() {
    return '$name\n${mobileNumber == null ? '' : mobileNumber}';
  }
}