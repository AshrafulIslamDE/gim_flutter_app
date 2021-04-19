import 'package:customer/bloc/base_pagination_bloc.dart';
import 'package:customer/data/repository/payment_repository.dart';
import 'package:customer/model/base.dart';
import 'package:customer/ui/payment/model/item_due_payment.dart';

class PaymentPaidBloc extends BasePaginationBloc{

  int get size => 20;

  int _totalTrip = 0;
  double _totalAmount = 0.0;

  int get totalTrip => _totalTrip;
  double get totalAmount => _totalAmount;

  set totAmount(double value) {
    _totalAmount = value;
  }

  set totTrip(int value) {
    _totalTrip = value;
  }

  getListFromApi({callback}) async {
    isLoading = true;
    queryParam['serviceFeeStatus'] = 'PAID';
    var response = await PaymentRepository.getDuePayment(getBaseQueryParam());
    checkResponse(response, successCallback: () {
      totTrip = response.data['totalTrip'];
      totAmount = response.data['totalAmount'];
      var paymentResponse = PaymentDueResponse.fromJson(response.data);
      if (paymentResponse.customerTripPayments.contentList.isNotEmpty) {
        setPaginationItem(paymentResponse.customerTripPayments);
      }
    });
    takeDecisionShowingError(response);
    return response;
  }

  setContentList(contentList) {
    itemList = convertDynamicListToStaticList<PaymentDueItem>(contentList);
  }

  @override
  reloadList({additionalQueryParam, callback}) {
    return super.reloadList(additionalQueryParam: additionalQueryParam);
  }
}