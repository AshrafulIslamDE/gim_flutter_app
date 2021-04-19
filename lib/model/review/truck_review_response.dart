import 'package:json_annotation/json_annotation.dart';

part 'truck_review_response.g.dart';

@JsonSerializable()
class TruckReviewItem {
  int tripId;
  int truckId;
  int reviewedAt;
  double truckRating;
  String truckReview;
  String truckRegistrationNumber;

  TruckReviewItem();

  factory TruckReviewItem.fromJson(Map<String, dynamic> json) => _$TruckReviewItemFromJson(json);
}
