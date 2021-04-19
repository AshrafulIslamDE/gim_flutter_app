import 'package:customer/model/base.dart';
import 'package:json_annotation/json_annotation.dart';
part 'item_due_payment.g.dart';

@JsonSerializable()
class PaymentDueItem{
  PaymentDueItem();
  double amount;
  int customerPaymentId;
  int customerPaymentTransactionId;
  String transactionId;
  int tripId;
  int tripNumber;
  int tripTime;
  int paymentTime;
  bool isChecked = false;
  factory PaymentDueItem.fromJson(Map<String,dynamic>json)=>_$PaymentDueItemFromJson(json);
}

@JsonSerializable()
class PaymentDueResponse{
  PaymentDueResponse();
  BasePagination customerTripPayments;
  double totalAmount = 0.0;
  int totalTrip = 0;
  factory PaymentDueResponse.fromJson(Map<String,dynamic>json)=>_$PaymentDueResponseFromJson(json);
}

@JsonSerializable()
class CustomerTripPayment{
  CustomerTripPayment();
  List<PaymentDueItem> contentList;
  factory CustomerTripPayment.fromJson(Map<String,dynamic>json)=>_$CustomerTripPaymentFromJson(json);
}

