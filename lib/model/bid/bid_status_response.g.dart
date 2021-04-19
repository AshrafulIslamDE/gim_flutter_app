// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BidStatusResponse _$BidStatusResponseFromJson(Map<String, dynamic> json) {
  return BidStatusResponse()
    ..advanceAmount = (json['advanceAmount'] as num)?.toDouble()
    ..id = json['id'] as int
    ..totalAmount = (json['totalAmount'] as num)?.toDouble()
    ..bidStatus = json['bidStatus'] as String
    ..tripModel = json['tripModel'] == null
        ? null
        : TripItem.fromJson(json['tripModel'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BidStatusResponseToJson(BidStatusResponse instance) =>
    <String, dynamic>{
      'advanceAmount': instance.advanceAmount,
      'id': instance.id,
      'totalAmount': instance.totalAmount,
      'bidStatus': instance.bidStatus,
      'tripModel': instance.tripModel,
    };
