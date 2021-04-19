// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverReviewItem _$DriverReviewItemFromJson(Map<String, dynamic> json) {
  return DriverReviewItem()
    ..tripId = json['tripId'] as int
    ..driverId = json['driverId'] as int
    ..reviewedAt = json['reviewedAt'] as int
    ..driverName = json['driverName'] as String
    ..driverRating = (json['driverRating'] as num)?.toDouble()
    ..driverReview = json['driverReview'] as String;
}

Map<String, dynamic> _$DriverReviewItemToJson(DriverReviewItem instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'driverId': instance.driverId,
      'reviewedAt': instance.reviewedAt,
      'driverName': instance.driverName,
      'driverRating': instance.driverRating,
      'driverReview': instance.driverReview,
    };
