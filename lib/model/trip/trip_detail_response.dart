import 'package:customer/model/trip/trip.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trip_detail_response.g.dart';

@JsonSerializable()
class TripDetailResponse extends TripItem {
  String driverName;
  String driverContact;
  String fleetOwnerName;
  String fleetOwnerContact;
  String truckRegNo;
  String tripPickupLat;
  String tripPickupLong;
  String tripDropoffLat;
  String tripDropoffLong;
  String customerName;
  String customerMobileNumber;
  String customerImageUrl;
  String receiverNumber;
  String receiverName;
  String truckLocation;
  double truckLocationLat;
  double truckLocationLon;
  double customerAvgRating;
  double customerRatingReceived;
  int customerId;
  int id;
  String dropoffAddress;
  int dropOffDateTime;
  int pickupDateTimeLocal;
  int pickupDateTimeUtc;
  String pickupAddress;
  double truckSize;
  String truckType;
  String truckTypeInBn;
  String goodsType;
  String paymentType;
  int totalNoOfBids;
  int tripNumber;
  String truckIcon;
  double truckLength;
  double truckWidth;
  double truckHeight;
  String specialInsturctions;
  String image;
  String tripStatus;
  String directionPolygon;
  bool trackerAdded;
  bool trackerActivated;
  String driverImage;
  String partnerImage;
  int driverId;
  int truckId;
  String truckImage;
  String staticMapPhotoThreeTwenty;
  String staticMapPhotoFourEighty;
  String staticMapPhotoTwoThirteen;
  String staticMapPhotoTwoEighty;
  int truckTypeId;
  String otherGoodsType;
  String staticMapPhotoTwoFifty;
  double minBidAmount;
  double maxBidAmount;
  double advance;
  double bidAmount;
  double driverRating;
  double truckRating;
  int bidId;
  double partnerTruckSize;
  String bidStatus;
  String driverImageUrl;
  double tripDriverRating;
  var tripDriverReview;
  double tripTruckRating;
  var tripTruckReview;
  int startDateTime;
  String truckRegistrationNumber;
  String tripReviewImage;
  double bookedTruckSize;
  double customerRating;
  String customerReview;
  int estimatedTravelTimeInMinute;
  String productType;
  String lcNumber;
  bool distributor;
  int distributorUserId;
  String distributorCompanyName;
  String distributorMobileNumber;

  TripDetailResponse();

  factory TripDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TripDetailResponseFromJson(json);
}
