// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentItem _$PaymentItemFromJson(Map<String, dynamic> json) {
  return PaymentItem()
    ..paymentDate = json['paymentTime'] as int
    ..transactionId = json['transactionId'] as String
    ..paymentMode = json['customerPaymentMode'] as String
    ..amount = (json['paidAmount'] as num)?.toDouble()
    ..isChecked = json['isChecked'] as bool;
}

Map<String, dynamic> _$PaymentItemToJson(PaymentItem instance) =>
    <String, dynamic>{
      'paymentTime': instance.paymentDate,
      'transactionId': instance.transactionId,
      'customerPaymentMode': instance.paymentMode,
      'paidAmount': instance.amount,
      'isChecked': instance.isChecked,
    };

PaymentResponse _$PaymentResponseFromJson(Map<String, dynamic> json) {
  return PaymentResponse()
    ..customerPayments = json['customerPayments'] == null
        ? null
        : BasePagination.fromJson(
            json['customerPayments'] as Map<String, dynamic>)
    ..totalPaidAmount = (json['totalPaidAmount'] as num)?.toDouble();
}

Map<String, dynamic> _$PaymentResponseToJson(PaymentResponse instance) =>
    <String, dynamic>{
      'customerPayments': instance.customerPayments,
      'totalPaidAmount': instance.totalPaidAmount,
    };

CustomerPayment _$CustomerPaymentFromJson(Map<String, dynamic> json) {
  return CustomerPayment()
    ..contentList = (json['contentList'] as List)
        ?.map((e) =>
            e == null ? null : PaymentItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CustomerPaymentToJson(CustomerPayment instance) =>
    <String, dynamic>{
      'contentList': instance.contentList,
    };
