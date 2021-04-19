// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(Map json) {
  return BaseResponse<T>()
    ..data = _Converter<T>().fromJson(json['data'])
    ..success = json['success'] as bool
    ..message = json['message'] as String
    ..errorCode = json['errorCode'] as String
    ..responseCode = json['responseCode'] as int;
}

Map<String, dynamic> _$BaseResponseToJson<T>(BaseResponse<T> instance) =>
    <String, dynamic>{
      'data': _Converter<T>().toJson(instance.data),
      'success': instance.success,
      'message': instance.message,
      'errorCode': instance.errorCode,
      'responseCode': instance.responseCode,
    };

BaseTrip _$BaseTripFromJson(Map<String, dynamic> json) {
  return BaseTrip()
    ..requestedTripCount = json['requestedTripCount'] as int
    ..bookedTripCount = json['bookedTripCount'] as int
    ..liveTripCount = json['liveTripCount'] as int
    ..completedTripCount = json['completedTripCount'] as int
    ..paginatedTrips = json['paginatedTrips'] == null
        ? null
        : BasePagination.fromJson(
            json['paginatedTrips'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BaseTripToJson(BaseTrip instance) => <String, dynamic>{
      'requestedTripCount': instance.requestedTripCount,
      'bookedTripCount': instance.bookedTripCount,
      'liveTripCount': instance.liveTripCount,
      'completedTripCount': instance.completedTripCount,
      'paginatedTrips': instance.paginatedTrips,
    };

BasePagination<T> _$BasePaginationFromJson<T>(Map<String, dynamic> json) {
  return BasePagination<T>(
    (json['contentList'] as List)?.map(_Converter<T>().fromJson)?.toList(),
  )
    ..totalPages = json['totalPages'] as int
    ..numberOfResults = json['numberOfResults'] as int
    ..nextPage = json['nextPage'] as int;
}

Map<String, dynamic> _$BasePaginationToJson<T>(BasePagination<T> instance) =>
    <String, dynamic>{
      'contentList':
          instance.contentList?.map(_Converter<T>().toJson)?.toList(),
      'totalPages': instance.totalPages,
      'numberOfResults': instance.numberOfResults,
      'nextPage': instance.nextPage,
    };

StatusResponse _$StatusResponseFromJson(Map<String, dynamic> json) {
  return StatusResponse()..status = json['status'] as bool;
}

Map<String, dynamic> _$StatusResponseToJson(StatusResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
    };

IdValuePair _$IdValuePairFromJson(Map<String, dynamic> json) {
  return IdValuePair()
    ..id = json['id'] as int
    ..value = json['value'] as int;
}

Map<String, dynamic> _$IdValuePairToJson(IdValuePair instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };

BaseTrackerInfo _$BaseTrackerInfoFromJson(Map<String, dynamic> json) {
  return BaseTrackerInfo()
    ..trackerAdded = json['trackerAdded'] as bool
    ..trackerActivated = json['trackerActivated'] as bool;
}

Map<String, dynamic> _$BaseTrackerInfoToJson(BaseTrackerInfo instance) =>
    <String, dynamic>{
      'trackerAdded': instance.trackerAdded,
      'trackerActivated': instance.trackerActivated,
    };

BaseDistributor _$BaseDistributorFromJson(Map<String, dynamic> json) {
  return BaseDistributor()
    ..distributorCompanyName = json['distributorCompanyName'] as String
    ..distributorMobileNumber = json['distributorMobileNumber'] as String
    ..distributor = json['distributor'] as bool
    ..distributorUserId = json['distributorUserId'] as int;
}

Map<String, dynamic> _$BaseDistributorToJson(BaseDistributor instance) =>
    <String, dynamic>{
      'distributorCompanyName': instance.distributorCompanyName,
      'distributorMobileNumber': instance.distributorMobileNumber,
      'distributor': instance.distributor,
      'distributorUserId': instance.distributorUserId,
    };
