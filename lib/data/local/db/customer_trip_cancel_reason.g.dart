// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_trip_cancel_reason.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerTripCancelReason _$CustomerTripCancelReasonFromJson(
    Map<String, dynamic> json) {
  return CustomerTripCancelReason(
    json['id'] as int,
    json['value'] as String,
    json['valueBn'] as String,
  );
}

Map<String, dynamic> _$CustomerTripCancelReasonToJson(
        CustomerTripCancelReason instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'valueBn': instance.valueBn,
    };
