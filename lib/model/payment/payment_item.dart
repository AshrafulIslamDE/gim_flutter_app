import 'package:customer/model/base.dart';
import 'package:json_annotation/json_annotation.dart';
part 'payment_item.g.dart';

@JsonSerializable()
class PaymentItem{
  PaymentItem();
  @JsonKey(name:"paymentTime")
  int paymentDate;
  @JsonKey(name:"transactionId")
  String transactionId;
  @JsonKey(name:"customerPaymentMode")
  String paymentMode;
  @JsonKey(name:"paidAmount")
  double amount;
  bool isChecked = false;
  factory PaymentItem.fromJson(Map<String,dynamic>json)=>_$PaymentItemFromJson(json);
}

@JsonSerializable()
class PaymentResponse{
  PaymentResponse();
  BasePagination customerPayments;
  @JsonKey(name:"totalPaidAmount")
  double totalPaidAmount=0.0;
  factory PaymentResponse.fromJson(Map<String,dynamic>json)=>_$PaymentResponseFromJson(json);
}

@JsonSerializable()
class CustomerPayment{
  CustomerPayment();
  List<PaymentItem> contentList;
  factory CustomerPayment.fromJson(Map<String,dynamic>json)=>_$CustomerPaymentFromJson(json);
}

