import 'package:json_annotation/json_annotation.dart';
part 'dashboard_trip.g.dart';

@JsonSerializable()
class DashboardTrip{
  DashboardTrip();
  @JsonKey(name:"tripAmount")
  double tripAmount=0.0;
  @JsonKey(name:"tripDate")
  int tripDate;
  @JsonKey(name:"tripId")
  int tripId;
  @JsonKey(name:"tripNumber")
  int tripNumber;
  factory DashboardTrip.fromJson(Map<String,dynamic>json)=>_$DashboardTripFromJson(json);
}

@JsonSerializable()
class DashboardContent{
  DashboardContent();
  List<DashboardTrip>dashboardTripModels;
  @JsonKey(name:"totalAmountPaid")
  double totalAmountPaid=0.0;
  @JsonKey(name:"totalTripTaken")
  int totalTripTaken=0;
  factory DashboardContent.fromJson(Map<String,dynamic>json)=>_$DashboardContentFromJson(json);

}