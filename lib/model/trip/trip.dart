import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trip.g.dart';

@JsonSerializable()
class TripItem extends BaseTrackerInfo with BaseDistributor {
  TripItem();

  String dropoffAddress;
  int id = 0;
  String paymentType;
  String pickupAddress;
  int pickupDateTimeUtc;
  int totalNoOfBids;
  int tripNumber;
  double truckSize;
  String truckType;
  String truckIcon;
  int truckTypeId;
  String otherGoodsType;
  String goodsType;
  String staticMapPhotoTwoEighty;
  String fleetOwnerName;
  double bidAmount;
  int estimatedTravelTimeInMinute;
  int startDateTime;
  String truckImage;
  double tripDriverRating;
  double tripTruckRating;
  String tripStatus;
  String goodsTypeInBn;
  String truckTypeInBn;

  getTruckTypeWithSize() {
    return (isBangla() ? truckTypeInBn ?? truckType : truckType) +
        ", " +
        localize('number_decimal_count',
            dynamicValue: truckSize.toString(), symbol: '%f') +
        localize('txt_ton');
  }

  factory TripItem.fromJson(Map<String, dynamic> json) =>
      _$TripItemFromJson(json);

  Map<String, dynamic> toJson() => _$TripItemToJson(this);
}
