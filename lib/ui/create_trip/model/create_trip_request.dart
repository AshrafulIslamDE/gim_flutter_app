import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'create_trip_request.g.dart';

@JsonSerializable()
class CreateTripRequest {
  static final CreateTripRequest _instance =
      CreateTripRequest._privateConstructor();

  static CreateTripRequest get instance => _instance;

  CreateTripRequest._privateConstructor();

  CreateTripRequest();

  String datetimeLocal;
  String datetimeUtc;
  String datetimeUtcStr;
  String directionPolygon;
  String dropOffAddress;
  double dropOfflat;
  double dropOfflon;
  int dropoffAddressDistrict = 0;
  String dropoffAddressLine1 = "";
  String dropoffAddressLine2 = "";
  int dropoffAddressPostOffice = 0;
  int dropoffAddressThana = 0;
  int dropoffAddressZipCode = 0;
  int goodsType;
  String goodsTypeStr;
  String otherGoodType = "";
  String image;
  String paymentType = "Cash";
  String pickUpAddress;
  double pickUplat;
  double pickUplon;
  int pickupAddressDistrict = 0;
  String pickupAddressLine1 = "";
  String pickupAddressLine2 = "";
  int pickupAddressPostOffice = 0;
  int pickupAddressThana = 0;
  int pickupAddressZipCode = 0;
  String receiverName;
  String receiverNumber;
  String specialInsturctions;
  String truckHeight;
  String truckImage;
  String truckLength;
  int truckSize;
  String truckSizeStr;
  int truckType;
  String truckTypeStr;
  String truckWidth;
  int distributorUserId;
  int productId;
  String lcNumber;
  String prodType;
  String distributorStr;

  CreateTripRequest.internal();

  factory CreateTripRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateTripRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTripRequestToJson(this);

  clear() {
    init();
    pickUplat = null;
    pickUplon = null;
    pickupAddressDistrict = 0;
  }

  init() {
    image = null;
    productId = 0;
    lcNumber = null;
    prodType = null;
    truckImage = null;
    truckWidth = null;
    truckHeight = null;
    truckLength = null;
    receiverName = null;
    goodsTypeStr = null;
    otherGoodType = "";
    receiverNumber = null;
    distributorUserId = null;
    specialInsturctions = null;
    distributorStr=null;
  }
}
