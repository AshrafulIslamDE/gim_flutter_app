// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck_review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TruckReviewItem _$TruckReviewItemFromJson(Map<String, dynamic> json) {
  return TruckReviewItem()
    ..tripId = json['tripId'] as int
    ..truckId = json['truckId'] as int
    ..reviewedAt = json['reviewedAt'] as int
    ..truckRating = (json['truckRating'] as num)?.toDouble()
    ..truckReview = json['truckReview'] as String
    ..truckRegistrationNumber = json['truckRegistrationNumber'] as String;
}

Map<String, dynamic> _$TruckReviewItemToJson(TruckReviewItem instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'truckId': instance.truckId,
      'reviewedAt': instance.reviewedAt,
      'truckRating': instance.truckRating,
      'truckReview': instance.truckReview,
      'truckRegistrationNumber': instance.truckRegistrationNumber,
    };
