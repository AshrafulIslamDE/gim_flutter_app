import 'package:customer/model/base.dart';
import 'package:customer/model/trip/trip.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bid_detail_response.g.dart';
@JsonSerializable()
class BidDetailResponse extends TripItem with BaseDistributor{
  BidDetail bidBaseModel;
  String _truckYear;
  double truckWidth;
  String _truckBrand;

  String get truckYear => _truckYear??' ';

  set truckYear(String value) {
    _truckYear = value;
  }

  String _truckRegNo;
  double truckHeight;
  double truckLength;
  String truckImage;
  String driverContact;
  String driverLicenceImage;
  String truckFront;
  String truckBack;
  String truckInner;
  String bidStatus;
  int  truckId;
  @JsonKey(name:'driverLicenceNo')
  String _driverLicenceNo;
  String get driverLicenceNo => _driverLicenceNo??' ';
  @JsonKey(name: 'driverLicenceNoExpiryDate')
  String _driverLicenceNoExpiryDate;
  String get driverLicenceNoExpiryDate => _driverLicenceNoExpiryDate??' ';
  set driverLicenceNoExpiryDate(String value) {
    print("setter:"+value.toString());
    _driverLicenceNoExpiryDate = value;
  }

  @JsonKey(name:'driverReviewCount')
  int _driverReviewCount = 0;
  int get driverReviewCount => _driverReviewCount??0;
  @JsonKey(name:'truckReviewCount')
  int _truckReviewCount = 0;

  set driverLicenceNo(String value) {
    _driverLicenceNo = value;
  }

  int get truckReviewCount => _truckReviewCount??0;

  set driverReviewCount(int value) {
    _driverReviewCount = value;
  }

  set truckReviewCount(int value) {
    _truckReviewCount = value;
  }
  BidDetailResponse();
  factory BidDetailResponse.fromJson(Map<String,dynamic>json)=>_$BidDetailResponseFromJson(json);

  String get truckBrand => _truckBrand??' ';

  set truckBrand(String value) {
    _truckBrand = value;
  }

  String get truckRegNo => _truckRegNo??' ';

  set truckRegNo(String value) {
    _truckRegNo = value;
  }
}

@JsonSerializable()
class BidDetail extends BaseTrackerInfo{
  int driverId;
  String truckImage;
  String driverContact;
  String driverLicenceImage;
  String driverName;
  String driverRating;
  String truckInner;
  String bidStatus;
  String _fleetOwnerName;
  String truckRating;

  String get fleetOwnerName => _fleetOwnerName??' ';

  set fleetOwnerName(String value) {
    _fleetOwnerName = value;
  }

  double totalAmount=0;
  double advanceAmount=0;
  @JsonKey(name: 'driverImage')
  String _driverImage;

  String get driverImage => _driverImage;

  set driverImage(String value) {
    _driverImage = value;
  }

  BidDetail();
  factory BidDetail.fromJson(Map<String,dynamic>json)=>_$BidDetailFromJson(json);
  Map<String, dynamic> toJson() => _$BidDetailToJson(this);





}

