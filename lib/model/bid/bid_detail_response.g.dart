// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BidDetailResponse _$BidDetailResponseFromJson(Map<String, dynamic> json) {
  return BidDetailResponse()
    ..trackerAdded = json['trackerAdded'] as bool
    ..trackerActivated = json['trackerActivated'] as bool
    ..distributorCompanyName = json['distributorCompanyName'] as String
    ..distributorMobileNumber = json['distributorMobileNumber'] as String
    ..distributor = json['distributor'] as bool
    ..distributorUserId = json['distributorUserId'] as int
    ..dropoffAddress = json['dropoffAddress'] as String
    ..id = json['id'] as int
    ..paymentType = json['paymentType'] as String
    ..pickupAddress = json['pickupAddress'] as String
    ..pickupDateTimeUtc = json['pickupDateTimeUtc'] as int
    ..totalNoOfBids = json['totalNoOfBids'] as int
    ..tripNumber = json['tripNumber'] as int
    ..truckSize = (json['truckSize'] as num)?.toDouble()
    ..truckType = json['truckType'] as String
    ..truckIcon = json['truckIcon'] as String
    ..truckTypeId = json['truckTypeId'] as int
    ..otherGoodsType = json['otherGoodsType'] as String
    ..goodsType = json['goodsType'] as String
    ..staticMapPhotoTwoEighty = json['staticMapPhotoTwoEighty'] as String
    ..fleetOwnerName = json['fleetOwnerName'] as String
    ..bidAmount = (json['bidAmount'] as num)?.toDouble()
    ..estimatedTravelTimeInMinute = json['estimatedTravelTimeInMinute'] as int
    ..startDateTime = json['startDateTime'] as int
    ..tripDriverRating = (json['tripDriverRating'] as num)?.toDouble()
    ..tripTruckRating = (json['tripTruckRating'] as num)?.toDouble()
    ..tripStatus = json['tripStatus'] as String
    ..goodsTypeInBn = json['goodsTypeInBn'] as String
    ..truckTypeInBn = json['truckTypeInBn'] as String
    ..bidBaseModel = json['bidBaseModel'] == null
        ? null
        : BidDetail.fromJson(json['bidBaseModel'] as Map<String, dynamic>)
    ..truckWidth = (json['truckWidth'] as num)?.toDouble()
    ..truckYear = json['truckYear'] as String
    ..truckHeight = (json['truckHeight'] as num)?.toDouble()
    ..truckLength = (json['truckLength'] as num)?.toDouble()
    ..truckImage = json['truckImage'] as String
    ..driverContact = json['driverContact'] as String
    ..driverLicenceImage = json['driverLicenceImage'] as String
    ..truckFront = json['truckFront'] as String
    ..truckBack = json['truckBack'] as String
    ..truckInner = json['truckInner'] as String
    ..bidStatus = json['bidStatus'] as String
    ..truckId = json['truckId'] as int
    ..driverLicenceNo = json['driverLicenceNo'] as String
    ..driverLicenceNoExpiryDate = json['driverLicenceNoExpiryDate'] as String
    ..driverReviewCount = json['driverReviewCount'] as int
    ..truckReviewCount = json['truckReviewCount'] as int
    ..truckBrand = json['truckBrand'] as String
    ..truckRegNo = json['truckRegNo'] as String;
}

Map<String, dynamic> _$BidDetailResponseToJson(BidDetailResponse instance) =>
    <String, dynamic>{
      'trackerAdded': instance.trackerAdded,
      'trackerActivated': instance.trackerActivated,
      'distributorCompanyName': instance.distributorCompanyName,
      'distributorMobileNumber': instance.distributorMobileNumber,
      'distributor': instance.distributor,
      'distributorUserId': instance.distributorUserId,
      'dropoffAddress': instance.dropoffAddress,
      'id': instance.id,
      'paymentType': instance.paymentType,
      'pickupAddress': instance.pickupAddress,
      'pickupDateTimeUtc': instance.pickupDateTimeUtc,
      'totalNoOfBids': instance.totalNoOfBids,
      'tripNumber': instance.tripNumber,
      'truckSize': instance.truckSize,
      'truckType': instance.truckType,
      'truckIcon': instance.truckIcon,
      'truckTypeId': instance.truckTypeId,
      'otherGoodsType': instance.otherGoodsType,
      'goodsType': instance.goodsType,
      'staticMapPhotoTwoEighty': instance.staticMapPhotoTwoEighty,
      'fleetOwnerName': instance.fleetOwnerName,
      'bidAmount': instance.bidAmount,
      'estimatedTravelTimeInMinute': instance.estimatedTravelTimeInMinute,
      'startDateTime': instance.startDateTime,
      'tripDriverRating': instance.tripDriverRating,
      'tripTruckRating': instance.tripTruckRating,
      'tripStatus': instance.tripStatus,
      'goodsTypeInBn': instance.goodsTypeInBn,
      'truckTypeInBn': instance.truckTypeInBn,
      'bidBaseModel': instance.bidBaseModel,
      'truckWidth': instance.truckWidth,
      'truckYear': instance.truckYear,
      'truckHeight': instance.truckHeight,
      'truckLength': instance.truckLength,
      'truckImage': instance.truckImage,
      'driverContact': instance.driverContact,
      'driverLicenceImage': instance.driverLicenceImage,
      'truckFront': instance.truckFront,
      'truckBack': instance.truckBack,
      'truckInner': instance.truckInner,
      'bidStatus': instance.bidStatus,
      'truckId': instance.truckId,
      'driverLicenceNo': instance.driverLicenceNo,
      'driverLicenceNoExpiryDate': instance.driverLicenceNoExpiryDate,
      'driverReviewCount': instance.driverReviewCount,
      'truckReviewCount': instance.truckReviewCount,
      'truckBrand': instance.truckBrand,
      'truckRegNo': instance.truckRegNo,
    };

BidDetail _$BidDetailFromJson(Map<String, dynamic> json) {
  return BidDetail()
    ..trackerAdded = json['trackerAdded'] as bool
    ..trackerActivated = json['trackerActivated'] as bool
    ..driverId = json['driverId'] as int
    ..truckImage = json['truckImage'] as String
    ..driverContact = json['driverContact'] as String
    ..driverLicenceImage = json['driverLicenceImage'] as String
    ..driverName = json['driverName'] as String
    ..driverRating = json['driverRating'] as String
    ..truckInner = json['truckInner'] as String
    ..bidStatus = json['bidStatus'] as String
    ..truckRating = json['truckRating'] as String
    ..fleetOwnerName = json['fleetOwnerName'] as String
    ..totalAmount = (json['totalAmount'] as num)?.toDouble()
    ..advanceAmount = (json['advanceAmount'] as num)?.toDouble()
    ..driverImage = json['driverImage'] as String;
}

Map<String, dynamic> _$BidDetailToJson(BidDetail instance) => <String, dynamic>{
      'trackerAdded': instance.trackerAdded,
      'trackerActivated': instance.trackerActivated,
      'driverId': instance.driverId,
      'truckImage': instance.truckImage,
      'driverContact': instance.driverContact,
      'driverLicenceImage': instance.driverLicenceImage,
      'driverName': instance.driverName,
      'driverRating': instance.driverRating,
      'truckInner': instance.truckInner,
      'bidStatus': instance.bidStatus,
      'truckRating': instance.truckRating,
      'fleetOwnerName': instance.fleetOwnerName,
      'totalAmount': instance.totalAmount,
      'advanceAmount': instance.advanceAmount,
      'driverImage': instance.driverImage,
    };
