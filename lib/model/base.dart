import 'package:customer/data/local/db/goods_type.dart';
import 'package:customer/model/bid/bid_item.dart';
import 'package:customer/model/dashboard/dashboard_trip.dart';
import 'package:customer/model/google/address_component.dart';
import 'package:customer/model/notifications/notification_content.dart';
import 'package:customer/model/payment/payment_item.dart';
import 'package:customer/model/referral/referral_history_response.dart';
import 'package:customer/model/referral/referral_response.dart';
import 'package:customer/model/review/driver_review_response.dart';
import 'package:customer/model/review/truck_review_response.dart';
import 'package:customer/features/registration/model/otp_generation_response.dart';
import 'package:customer/model/trip/good_type.dart';
import 'package:customer/model/trip/product_type.dart';
import 'package:customer/model/trip/trip.dart';
import 'package:customer/ui/create_trip/model/create_trip_response.dart';
import 'package:customer/ui/payment/model/item_due_payment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base.g.dart';

@JsonSerializable(anyMap: true)
class BaseResponse<T> {
  BaseResponse();

  BaseResponse.instance(this.data);

  // @JsonKey(name: 'data', fromJson: _dataFromJson, toJson: _dataToJson)
  @_Converter()
  T data;
  bool success;
  String message;
  String errorCode;
  int responseCode;

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson<T>(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

@JsonSerializable()
class BaseTrip {
  int requestedTripCount;
  int bookedTripCount;
  int liveTripCount;
  int completedTripCount;

  BaseTrip();

  BaseTrip.counter(
      {this.requestedTripCount,
      this.bookedTripCount,
      this.liveTripCount,
      this.completedTripCount});

  BasePagination<TripItem> paginatedTrips;

  factory BaseTrip.fromJson(Map<String, dynamic> json) =>
      _$BaseTripFromJson(json);

  Map<String, dynamic> toJson() => _$BaseTripToJson(this);

  getTotalTripCount() {
    return requestedTripCount +
        bookedTripCount +
        liveTripCount +
        completedTripCount;
  }
}

@JsonSerializable()
class BasePagination<T> {
  BasePagination(this.contentList);

  BasePagination.instance(
      this.contentList, this.totalPages, this.numberOfResults, this.nextPage);

  @_Converter()
  List<T> contentList;
  int totalPages;
  int numberOfResults;
  int nextPage;

  factory BasePagination.fromJson(Map<String, dynamic> json) =>
      _$BasePaginationFromJson<T>(json);

  Map<String, dynamic> toJson() => _$BasePaginationToJson(this);
}

/*@JsonSerializable()
class BaseResponseList<T>{

}*/

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    // print("type of T:"+T.toString());
    if (T == TripItem) {
      return TripItem.fromJson(json) as T;
    } else if (T == BidItem) {
      return BidItem.fromJson(json) as T;
    } else if (T == NotificationContent) {
      return NotificationContent.fromJson(json) as T;
    } else if (T == DashboardTrip) {
      return DashboardTrip.fromJson(json) as T;
    } else if (T == DashboardContent) {
      return DashboardContent.fromJson(json) as T;
    } else if (T == GoodsType) {
      return GoodsType.fromJson(json) as T;
    }else if (T == Goods) {
      return Goods.fromJson(json) as T;
    }else if (T == GoodType) {
      return GoodType.fromJson(json) as T;
    } else if (T == BaseTrip) {
      return BaseTrip.fromJson(json) as T;
    } else if (T == CreateTripResponse) {
      return CreateTripResponse.fromJson(json) as T;
    } else if (T == OtpGenerationResponse) {
      return OtpGenerationResponse.fromJson(json) as T;
    } else if (T == Referral) {
      return Referral.fromJson(json) as T;
    } else if (T == ReferralHistoryItem) {
      return ReferralHistoryItem.fromJson(json) as T;
    } else if (T == DriverReviewItem) {
      return DriverReviewItem.fromJson(json) as T;
    } else if (T == TruckReviewItem) {
      return TruckReviewItem.fromJson(json) as T;
    } else if (T == ProductType) {
      return ProductType.fromJson(json) as T;
    } else if (T == AddressComponent) {
      return AddressComponent.fromJson(json) as T;
    } else if (T == PaymentItem) {
      return PaymentItem.fromJson(json) as T;
    }else if (T == CustomerPayment) {
      return CustomerPayment.fromJson(json) as T;
    }else if (T == PaymentResponse) {
      return PaymentResponse.fromJson(json) as T;
    }else if (T == PaymentDueItem) {
      return PaymentDueItem.fromJson(json) as T;
    }else if (T == CustomerTripPayment) {
      return CustomerTripPayment.fromJson(json) as T;
    }else if (T == PaymentDueResponse) {
      return PaymentDueResponse.fromJson(json) as T;
    }

    return json as T;
  }

  @override
  Object toJson(T object) {
    return object;
  }
}

@JsonSerializable()
class StatusResponse {
  bool status;

  StatusResponse();

  factory StatusResponse.fromJson(Map<String, dynamic> json) =>
      _$StatusResponseFromJson(json);
}

@JsonSerializable()
class IdValuePair {
  int id = 0;
  int value = 0;

  IdValuePair();

  factory IdValuePair.fromJson(Map<String, dynamic> json) =>
      _$IdValuePairFromJson(json);
}

@JsonSerializable()
class BaseTrackerInfo {
  bool trackerAdded = false;
  bool trackerActivated = false;

  BaseTrackerInfo();

  factory BaseTrackerInfo.fromJson(Map<String, dynamic> json) =>
      _$BaseTrackerInfoFromJson(json);
}

@JsonSerializable()
class BaseDistributor {
  String distributorCompanyName;
  String distributorMobileNumber;
  bool distributor;
  int distributorUserId;
}
class _Converter2<T> implements JsonConverter<T, Object> {
  const _Converter2();

  @override
  T fromJson(Object json) {
    return json as T;
  }

  @override
  Object toJson(T object) {
    return object;
  }
}
convertDynamicListToStaticList2<T>(List<dynamic> items) {
  return items?.map(_Converter2<T>().fromJson).toList();
}
convertDynamicListToStaticList<T>(List<dynamic> items) {
  return items?.map(_Converter<T>().fromJson)?.toList();
}
