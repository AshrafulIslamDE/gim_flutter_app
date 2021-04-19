// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardTrip _$DashboardTripFromJson(Map<String, dynamic> json) {
  return DashboardTrip()
    ..tripAmount = (json['tripAmount'] as num)?.toDouble()
    ..tripDate = json['tripDate'] as int
    ..tripId = json['tripId'] as int
    ..tripNumber = json['tripNumber'] as int;
}

Map<String, dynamic> _$DashboardTripToJson(DashboardTrip instance) =>
    <String, dynamic>{
      'tripAmount': instance.tripAmount,
      'tripDate': instance.tripDate,
      'tripId': instance.tripId,
      'tripNumber': instance.tripNumber,
    };

DashboardContent _$DashboardContentFromJson(Map<String, dynamic> json) {
  return DashboardContent()
    ..dashboardTripModels = (json['dashboardTripModels'] as List)
        ?.map((e) => e == null
            ? null
            : DashboardTrip.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..totalAmountPaid = (json['totalAmountPaid'] as num)?.toDouble()
    ..totalTripTaken = json['totalTripTaken'] as int;
}

Map<String, dynamic> _$DashboardContentToJson(DashboardContent instance) =>
    <String, dynamic>{
      'dashboardTripModels': instance.dashboardTripModels,
      'totalAmountPaid': instance.totalAmountPaid,
      'totalTripTaken': instance.totalTripTaken,
    };
