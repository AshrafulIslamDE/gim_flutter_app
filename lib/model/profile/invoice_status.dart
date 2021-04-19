
import 'package:json_annotation/json_annotation.dart';

part 'invoice_status.g.dart';

@JsonSerializable()
class InvoiceStatus {
  bool status;

  InvoiceStatus();

  factory InvoiceStatus.fromJson(Map<String, dynamic> json) =>
      _$InvoiceStatusFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceStatusToJson(this);
}
