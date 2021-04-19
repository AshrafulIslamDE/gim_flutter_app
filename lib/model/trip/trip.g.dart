// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripItem _$TripItemFromJson(Map<String, dynamic> json) {
  return TripItem()
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
    ..truckImage = json['truckImage'] as String
    ..tripDriverRating = (json['tripDriverRating'] as num)?.toDouble()
    ..tripTruckRating = (json['tripTruckRating'] as num)?.toDouble()
    ..tripStatus = json['tripStatus'] as String
    ..goodsTypeInBn = json['goodsTypeInBn'] as String
    ..truckTypeInBn = json['truckTypeInBn'] as String;
}

Map<String, dynamic> _$TripItemToJson(TripItem instance) => <String, dynamic>{
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
      'truckImage': instance.truckImage,
      'tripDriverRating': instance.tripDriverRating,
      'tripTruckRating': instance.tripTruckRating,
      'tripStatus': instance.tripStatus,
      'goodsTypeInBn': instance.goodsTypeInBn,
      'truckTypeInBn': instance.truckTypeInBn,
    };
