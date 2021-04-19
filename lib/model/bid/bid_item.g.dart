// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BidItem _$BidItemFromJson(Map<String, dynamic> json) {
  return BidItem()
    ..trackerAdded = json['trackerAdded'] as bool
    ..trackerActivated = json['trackerActivated'] as bool
    ..distributorCompanyName = json['distributorCompanyName'] as String
    ..distributorMobileNumber = json['distributorMobileNumber'] as String
    ..distributor = json['distributor'] as bool
    ..distributorUserId = json['distributorUserId'] as int
    ..totalAmount = (json['totalAmount'] as num)?.toDouble()
    ..bidId = json['bidId'] as int
    ..driverId = json['driverId'] as int
    ..driverName = json['driverName'] as String
    ..driverRating = json['driverRating'] as String
    ..fleetOwnerContact = json['fleetOwnerContact'] as String
    ..fleetOwnerName = json['fleetOwnerName'] as String
    ..advanceAmount = (json['advanceAmount'] as num)?.toDouble()
    ..truckRating = json['truckRating'] as String
    ..truckRegistrationNumber = json['truckRegistrationNumber'] as String
    ..driverLicenceNoExpiryDate = json['driverLicenceNoExpiryDate'] as String
    ..completedTripsCount = json['completedTripsCount'] as int
    ..truckLength = (json['truckLength'] as num)?.toDouble()
    ..truckTypeInBn = json['truckTypeInBn'] as String
    ..truckSize = (json['truckSize'] as num)?.toDouble()
    ..truckType = json['truckType'] as String;
}

Map<String, dynamic> _$BidItemToJson(BidItem instance) => <String, dynamic>{
      'trackerAdded': instance.trackerAdded,
      'trackerActivated': instance.trackerActivated,
      'distributorCompanyName': instance.distributorCompanyName,
      'distributorMobileNumber': instance.distributorMobileNumber,
      'distributor': instance.distributor,
      'distributorUserId': instance.distributorUserId,
      'totalAmount': instance.totalAmount,
      'bidId': instance.bidId,
      'driverId': instance.driverId,
      'driverName': instance.driverName,
      'driverRating': instance.driverRating,
      'fleetOwnerContact': instance.fleetOwnerContact,
      'fleetOwnerName': instance.fleetOwnerName,
      'advanceAmount': instance.advanceAmount,
      'truckRating': instance.truckRating,
      'truckRegistrationNumber': instance.truckRegistrationNumber,
      'driverLicenceNoExpiryDate': instance.driverLicenceNoExpiryDate,
      'isExpanded': instance.isExpanded,
      'completedTripsCount': instance.completedTripsCount,
      'truckLength': instance.truckLength,
      'truckTypeInBn': instance.truckTypeInBn,
      'truckSize': instance.truckSize,
      'truckType': instance.truckType,
    };
