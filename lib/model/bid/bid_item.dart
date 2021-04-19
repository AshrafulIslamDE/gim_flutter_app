
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/base.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bid_item.g.dart';

@JsonSerializable()
class BidItem extends BaseTrackerInfo with BaseDistributor{
  double totalAmount;
  int bidId;
  int driverId;
  String driverName;
  String driverRating;
  String fleetOwnerContact;
  String fleetOwnerName;
  double advanceAmount;
  String truckRating;
  String truckRegistrationNumber;
  String driverLicenceNoExpiryDate;
  bool isExpanded = false;
  int  completedTripsCount = 0;
  double truckLength;
  String truckTypeInBn;
  double truckSize;
  String truckType;

  BidItem();
  factory BidItem.fromJson(Map<String,dynamic>json)=>_$BidItemFromJson(json);

  getTruckTypeWithSize() {
    return (isBangla() ? truckTypeInBn ?? truckType : truckType) +
        ", " +
        localize('number_decimal_count',
            dynamicValue: truckSize.toString(), symbol: '%f') +
        localize('txt_ton');
  }
}

