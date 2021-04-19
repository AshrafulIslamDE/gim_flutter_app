import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/data/repository/payment_repository.dart';
import 'package:customer/utils/common_utils.dart';

class PayResponseBloc extends BaseBloc {
  final String response;
  String amount;
  String errorMsg;
  String paymentId;
  String transactionId;

  PayResponseBloc(this.response) {
    _setTxnStatus();
  }

  _setTxnStatus() {
    var uri = Uri.parse(response);
    uri.queryParameters.forEach((k, v) {
      switch (k) {
        case 'trxID':
          transactionId = v;
          break;
        case 'amount':
          amount = v;
          break;
        case 'paymentID':
          paymentId = v;
          break;
        case 'error':
          errorMsg = v;
      }
    });
  }

  completePayment() async {
    if (isNullOrEmpty(paymentId) || !isNullOrEmpty(errorMsg)) return;
    await PaymentRepository.paymentComplete(paymentId,transactionId);
  }
}
