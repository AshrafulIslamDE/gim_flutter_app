import 'package:json_annotation/json_annotation.dart';

part 'driver_review_response.g.dart';

@JsonSerializable()
class DriverReviewItem {
  int tripId;
  int driverId;
  int reviewedAt;
  String driverName;
  double driverRating;
  String driverReview;

  DriverReviewItem();

  factory DriverReviewItem.fromJson(Map<String, dynamic> json) => _$DriverReviewItemFromJson(json);
}
