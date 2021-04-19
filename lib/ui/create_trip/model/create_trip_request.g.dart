// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_trip_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTripRequest _$CreateTripRequestFromJson(Map<String, dynamic> json) {
  return CreateTripRequest()
    ..datetimeLocal = json['datetimeLocal'] as String
    ..datetimeUtc = json['datetimeUtc'] as String
    ..datetimeUtcStr = json['datetimeUtcStr'] as String
    ..directionPolygon = json['directionPolygon'] as String
    ..dropOffAddress = json['dropOffAddress'] as String
    ..dropOfflat = (json['dropOfflat'] as num)?.toDouble()
    ..dropOfflon = (json['dropOfflon'] as num)?.toDouble()
    ..dropoffAddressDistrict = json['dropoffAddressDistrict'] as int
    ..dropoffAddressLine1 = json['dropoffAddressLine1'] as String
    ..dropoffAddressLine2 = json['dropoffAddressLine2'] as String
    ..dropoffAddressPostOffice = json['dropoffAddressPostOffice'] as int
    ..dropoffAddressThana = json['dropoffAddressThana'] as int
    ..dropoffAddressZipCode = json['dropoffAddressZipCode'] as int
    ..goodsType = json['goodsType'] as int
    ..goodsTypeStr = json['goodsTypeStr'] as String
    ..otherGoodType = json['otherGoodType'] as String
    ..image = json['image'] as String
    ..paymentType = json['paymentType'] as String
    ..pickUpAddress = json['pickUpAddress'] as String
    ..pickUplat = (json['pickUplat'] as num)?.toDouble()
    ..pickUplon = (json['pickUplon'] as num)?.toDouble()
    ..pickupAddressDistrict = json['pickupAddressDistrict'] as int
    ..pickupAddressLine1 = json['pickupAddressLine1'] as String
    ..pickupAddressLine2 = json['pickupAddressLine2'] as String
    ..pickupAddressPostOffice = json['pickupAddressPostOffice'] as int
    ..pickupAddressThana = json['pickupAddressThana'] as int
    ..pickupAddressZipCode = json['pickupAddressZipCode'] as int
    ..receiverName = json['receiverName'] as String
    ..receiverNumber = json['receiverNumber'] as String
    ..specialInsturctions = json['specialInsturctions'] as String
    ..truckHeight = json['truckHeight'] as String
    ..truckImage = json['truckImage'] as String
    ..truckLength = json['truckLength'] as String
    ..truckSize = json['truckSize'] as int
    ..truckSizeStr = json['truckSizeStr'] as String
    ..truckType = json['truckType'] as int
    ..truckTypeStr = json['truckTypeStr'] as String
    ..truckWidth = json['truckWidth'] as String
    ..distributorUserId = json['distributorUserId'] as int
    ..productId = json['productId'] as int
    ..lcNumber = json['lcNumber'] as String
    ..prodType = json['prodType'] as String
    ..distributorStr = json['distributorStr'] as String;
}

Map<String, dynamic> _$CreateTripRequestToJson(CreateTripRequest instance) =>
    <String, dynamic>{
      'datetimeLocal': instance.datetimeLocal,
      'datetimeUtc': instance.datetimeUtc,
      'datetimeUtcStr': instance.datetimeUtcStr,
      'directionPolygon': instance.directionPolygon,
      'dropOffAddress': instance.dropOffAddress,
      'dropOfflat': instance.dropOfflat,
      'dropOfflon': instance.dropOfflon,
      'dropoffAddressDistrict': instance.dropoffAddressDistrict,
      'dropoffAddressLine1': instance.dropoffAddressLine1,
      'dropoffAddressLine2': instance.dropoffAddressLine2,
      'dropoffAddressPostOffice': instance.dropoffAddressPostOffice,
      'dropoffAddressThana': instance.dropoffAddressThana,
      'dropoffAddressZipCode': instance.dropoffAddressZipCode,
      'goodsType': instance.goodsType,
      'goodsTypeStr': instance.goodsTypeStr,
      'otherGoodType': instance.otherGoodType,
      'image': instance.image,
      'paymentType': instance.paymentType,
      'pickUpAddress': instance.pickUpAddress,
      'pickUplat': instance.pickUplat,
      'pickUplon': instance.pickUplon,
      'pickupAddressDistrict': instance.pickupAddressDistrict,
      'pickupAddressLine1': instance.pickupAddressLine1,
      'pickupAddressLine2': instance.pickupAddressLine2,
      'pickupAddressPostOffice': instance.pickupAddressPostOffice,
      'pickupAddressThana': instance.pickupAddressThana,
      'pickupAddressZipCode': instance.pickupAddressZipCode,
      'receiverName': instance.receiverName,
      'receiverNumber': instance.receiverNumber,
      'specialInsturctions': instance.specialInsturctions,
      'truckHeight': instance.truckHeight,
      'truckImage': instance.truckImage,
      'truckLength': instance.truckLength,
      'truckSize': instance.truckSize,
      'truckSizeStr': instance.truckSizeStr,
      'truckType': instance.truckType,
      'truckTypeStr': instance.truckTypeStr,
      'truckWidth': instance.truckWidth,
      'distributorUserId': instance.distributorUserId,
      'productId': instance.productId,
      'lcNumber': instance.lcNumber,
      'prodType': instance.prodType,
      'distributorStr': instance.distributorStr,
    };
