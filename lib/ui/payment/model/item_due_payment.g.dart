// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_due_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDueItem _$PaymentDueItemFromJson(Map<String, dynamic> json) {
  return PaymentDueItem()
    ..amount = (json['amount'] as num)?.toDouble()
    ..customerPaymentId = json['customerPaymentId'] as int
    ..customerPaymentTransactionId = json['customerPaymentTransactionId'] as int
    ..transactionId = json['transactionId'] as String
    ..tripId = json['tripId'] as int
    ..tripNumber = json['tripNumber'] as int
    ..tripTime = json['tripTime'] as int
    ..paymentTime = json['paymentTime'] as int
    ..isChecked = json['isChecked'] as bool;
}

Map<String, dynamic> _$PaymentDueItemToJson(PaymentDueItem instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'customerPaymentId': instance.customerPaymentId,
      'customerPaymentTransactionId': instance.customerPaymentTransactionId,
      'transactionId': instance.transactionId,
      'tripId': instance.tripId,
      'tripNumber': instance.tripNumber,
      'tripTime': instance.tripTime,
      'paymentTime': instance.paymentTime,
      'isChecked': instance.isChecked,
    };

PaymentDueResponse _$PaymentDueResponseFromJson(Map<String, dynamic> json) {
  return PaymentDueResponse()
    ..customerTripPayments = json['customerTripPayments'] == null
        ? null
        : BasePagination.fromJson(
            json['customerTripPayments'] as Map<String, dynamic>)
    ..totalAmount = (json['totalAmount'] as num)?.toDouble()
    ..totalTrip = json['totalTrip'] as int;
}

Map<String, dynamic> _$PaymentDueResponseToJson(PaymentDueResponse instance) =>
    <String, dynamic>{
      'customerTripPayments': instance.customerTripPayments,
      'totalAmount': instance.totalAmount,
      'totalTrip': instance.totalTrip,
    };

CustomerTripPayment _$CustomerTripPaymentFromJson(Map<String, dynamic> json) {
  return CustomerTripPayment()
    ..contentList = (json['contentList'] as List)
        ?.map((e) => e == null
            ? null
            : PaymentDueItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CustomerTripPaymentToJson(
        CustomerTripPayment instance) =>
    <String, dynamic>{
      'contentList': instance.contentList,
    };
