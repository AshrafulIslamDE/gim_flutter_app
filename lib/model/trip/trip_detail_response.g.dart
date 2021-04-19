// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetailResponse _$TripDetailResponseFromJson(Map<String, dynamic> json) {
  return TripDetailResponse()
    ..goodsTypeInBn = json['goodsTypeInBn'] as String
    ..driverName = json['driverName'] as String
    ..driverContact = json['driverContact'] as String
    ..fleetOwnerName = json['fleetOwnerName'] as String
    ..fleetOwnerContact = json['fleetOwnerContact'] as String
    ..truckRegNo = json['truckRegNo'] as String
    ..tripPickupLat = json['tripPickupLat'] as String
    ..tripPickupLong = json['tripPickupLong'] as String
    ..tripDropoffLat = json['tripDropoffLat'] as String
    ..tripDropoffLong = json['tripDropoffLong'] as String
    ..customerName = json['customerName'] as String
    ..customerMobileNumber = json['customerMobileNumber'] as String
    ..customerImageUrl = json['customerImageUrl'] as String
    ..receiverNumber = json['receiverNumber'] as String
    ..receiverName = json['receiverName'] as String
    ..truckLocation = json['truckLocation'] as String
    ..truckLocationLat = (json['truckLocationLat'] as num)?.toDouble()
    ..truckLocationLon = (json['truckLocationLon'] as num)?.toDouble()
    ..customerAvgRating = (json['customerAvgRating'] as num)?.toDouble()
    ..customerRatingReceived =
        (json['customerRatingReceived'] as num)?.toDouble()
    ..customerId = json['customerId'] as int
    ..id = json['id'] as int
    ..dropoffAddress = json['dropoffAddress'] as String
    ..dropOffDateTime = json['dropOffDateTime'] as int
    ..pickupDateTimeLocal = json['pickupDateTimeLocal'] as int
    ..pickupDateTimeUtc = json['pickupDateTimeUtc'] as int
    ..pickupAddress = json['pickupAddress'] as String
    ..truckSize = (json['truckSize'] as num)?.toDouble()
    ..truckType = json['truckType'] as String
    ..truckTypeInBn = json['truckTypeInBn'] as String
    ..goodsType = json['goodsType'] as String
    ..paymentType = json['paymentType'] as String
    ..totalNoOfBids = json['totalNoOfBids'] as int
    ..tripNumber = json['tripNumber'] as int
    ..truckIcon = json['truckIcon'] as String
    ..truckLength = (json['truckLength'] as num)?.toDouble()
    ..truckWidth = (json['truckWidth'] as num)?.toDouble()
    ..truckHeight = (json['truckHeight'] as num)?.toDouble()
    ..specialInsturctions = json['specialInsturctions'] as String
    ..image = json['image'] as String
    ..tripStatus = json['tripStatus'] as String
    ..directionPolygon = json['directionPolygon'] as String
    ..trackerAdded = json['trackerAdded'] as bool
    ..trackerActivated = json['trackerActivated'] as bool
    ..driverImage = json['driverImage'] as String
    ..partnerImage = json['partnerImage'] as String
    ..driverId = json['driverId'] as int
    ..truckId = json['truckId'] as int
    ..truckImage = json['truckImage'] as String
    ..staticMapPhotoThreeTwenty = json['staticMapPhotoThreeTwenty'] as String
    ..staticMapPhotoFourEighty = json['staticMapPhotoFourEighty'] as String
    ..staticMapPhotoTwoThirteen = json['staticMapPhotoTwoThirteen'] as String
    ..staticMapPhotoTwoEighty = json['staticMapPhotoTwoEighty'] as String
    ..truckTypeId = json['truckTypeId'] as int
    ..otherGoodsType = json['otherGoodsType'] as String
    ..staticMapPhotoTwoFifty = json['staticMapPhotoTwoFifty'] as String
    ..minBidAmount = (json['minBidAmount'] as num)?.toDouble()
    ..maxBidAmount = (json['maxBidAmount'] as num)?.toDouble()
    ..advance = (json['advance'] as num)?.toDouble()
    ..bidAmount = (json['bidAmount'] as num)?.toDouble()
    ..driverRating = (json['driverRating'] as num)?.toDouble()
    ..truckRating = (json['truckRating'] as num)?.toDouble()
    ..bidId = json['bidId'] as int
    ..partnerTruckSize = (json['partnerTruckSize'] as num)?.toDouble()
    ..bidStatus = json['bidStatus'] as String
    ..driverImageUrl = json['driverImageUrl'] as String
    ..tripDriverRating = (json['tripDriverRating'] as num)?.toDouble()
    ..tripDriverReview = json['tripDriverReview']
    ..tripTruckRating = (json['tripTruckRating'] as num)?.toDouble()
    ..tripTruckReview = json['tripTruckReview']
    ..startDateTime = json['startDateTime'] as int
    ..truckRegistrationNumber = json['truckRegistrationNumber'] as String
    ..tripReviewImage = json['tripReviewImage'] as String
    ..bookedTruckSize = (json['bookedTruckSize'] as num)?.toDouble()
    ..customerRating = (json['customerRating'] as num)?.toDouble()
    ..customerReview = json['customerReview'] as String
    ..estimatedTravelTimeInMinute = json['estimatedTravelTimeInMinute'] as int
    ..productType = json['productType'] as String
    ..lcNumber = json['lcNumber'] as String
    ..distributor = json['distributor'] as bool
    ..distributorUserId = json['distributorUserId'] as int
    ..distributorCompanyName = json['distributorCompanyName'] as String
    ..distributorMobileNumber = json['distributorMobileNumber'] as String;
}

Map<String, dynamic> _$TripDetailResponseToJson(TripDetailResponse instance) =>
    <String, dynamic>{
      'goodsTypeInBn': instance.goodsTypeInBn,
      'driverName': instance.driverName,
      'driverContact': instance.driverContact,
      'fleetOwnerName': instance.fleetOwnerName,
      'fleetOwnerContact': instance.fleetOwnerContact,
      'truckRegNo': instance.truckRegNo,
      'tripPickupLat': instance.tripPickupLat,
      'tripPickupLong': instance.tripPickupLong,
      'tripDropoffLat': instance.tripDropoffLat,
      'tripDropoffLong': instance.tripDropoffLong,
      'customerName': instance.customerName,
      'customerMobileNumber': instance.customerMobileNumber,
      'customerImageUrl': instance.customerImageUrl,
      'receiverNumber': instance.receiverNumber,
      'receiverName': instance.receiverName,
      'truckLocation': instance.truckLocation,
      'truckLocationLat': instance.truckLocationLat,
      'truckLocationLon': instance.truckLocationLon,
      'customerAvgRating': instance.customerAvgRating,
      'customerRatingReceived': instance.customerRatingReceived,
      'customerId': instance.customerId,
      'id': instance.id,
      'dropoffAddress': instance.dropoffAddress,
      'dropOffDateTime': instance.dropOffDateTime,
      'pickupDateTimeLocal': instance.pickupDateTimeLocal,
      'pickupDateTimeUtc': instance.pickupDateTimeUtc,
      'pickupAddress': instance.pickupAddress,
      'truckSize': instance.truckSize,
      'truckType': instance.truckType,
      'truckTypeInBn': instance.truckTypeInBn,
      'goodsType': instance.goodsType,
      'paymentType': instance.paymentType,
      'totalNoOfBids': instance.totalNoOfBids,
      'tripNumber': instance.tripNumber,
      'truckIcon': instance.truckIcon,
      'truckLength': instance.truckLength,
      'truckWidth': instance.truckWidth,
      'truckHeight': instance.truckHeight,
      'specialInsturctions': instance.specialInsturctions,
      'image': instance.image,
      'tripStatus': instance.tripStatus,
      'directionPolygon': instance.directionPolygon,
      'trackerAdded': instance.trackerAdded,
      'trackerActivated': instance.trackerActivated,
      'driverImage': instance.driverImage,
      'partnerImage': instance.partnerImage,
      'driverId': instance.driverId,
      'truckId': instance.truckId,
      'truckImage': instance.truckImage,
      'staticMapPhotoThreeTwenty': instance.staticMapPhotoThreeTwenty,
      'staticMapPhotoFourEighty': instance.staticMapPhotoFourEighty,
      'staticMapPhotoTwoThirteen': instance.staticMapPhotoTwoThirteen,
      'staticMapPhotoTwoEighty': instance.staticMapPhotoTwoEighty,
      'truckTypeId': instance.truckTypeId,
      'otherGoodsType': instance.otherGoodsType,
      'staticMapPhotoTwoFifty': instance.staticMapPhotoTwoFifty,
      'minBidAmount': instance.minBidAmount,
      'maxBidAmount': instance.maxBidAmount,
      'advance': instance.advance,
      'bidAmount': instance.bidAmount,
      'driverRating': instance.driverRating,
      'truckRating': instance.truckRating,
      'bidId': instance.bidId,
      'partnerTruckSize': instance.partnerTruckSize,
      'bidStatus': instance.bidStatus,
      'driverImageUrl': instance.driverImageUrl,
      'tripDriverRating': instance.tripDriverRating,
      'tripDriverReview': instance.tripDriverReview,
      'tripTruckRating': instance.tripTruckRating,
      'tripTruckReview': instance.tripTruckReview,
      'startDateTime': instance.startDateTime,
      'truckRegistrationNumber': instance.truckRegistrationNumber,
      'tripReviewImage': instance.tripReviewImage,
      'bookedTruckSize': instance.bookedTruckSize,
      'customerRating': instance.customerRating,
      'customerReview': instance.customerReview,
      'estimatedTravelTimeInMinute': instance.estimatedTravelTimeInMinute,
      'productType': instance.productType,
      'lcNumber': instance.lcNumber,
      'distributor': instance.distributor,
      'distributorUserId': instance.distributorUserId,
      'distributorCompanyName': instance.distributorCompanyName,
      'distributorMobileNumber': instance.distributorMobileNumber,
    };
