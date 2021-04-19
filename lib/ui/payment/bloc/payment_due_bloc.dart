import 'package:customer/bloc/base_pagination_bloc.dart';
import 'package:customer/data/repository/payment_repository.dart';
import 'package:customer/model/base.dart';
import 'package:customer/model/payment/payment_item.dart';
import 'package:customer/ui/payment/model/item_due_payment.dart';
import 'package:customer/utils/ui_constant.dart';

class PaymentDueBloc extends BasePaginationBloc<PaymentDueItem> {
  int get size => 20;

  int _totalTrip = 0;
  double _totalAmount = 0.0;

  int get totalTrip => _totalTrip;
  double get totalAmount => _totalAmount;

  bool canDoPayment = false;

  var listOfTripId = List();
  get buttonColor => canDoPayment ? HexColor("#003250") : HexColor("#96003250");

  int tripsSelForPayment;
  double totalAmountToPay;

  set totAmount(double value) {
    _totalAmount = value;
  }

  set totTrip(int value) {
    _totalTrip = value;
  }

  getListFromApi({callback}) async {
    isLoading = true;
    queryParam['serviceFeeStatus'] = 'UNPAID';
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

  getSelItems() {
    tripsSelForPayment = 0;
    totalAmountToPay = 0.0;
    listOfTripId.clear();
    for (PaymentDueItem item in itemList) {
      if(item.isChecked ?? false){
        ++tripsSelForPayment;
        totalAmountToPay += item.amount;
        listOfTripId.add(item.tripId);
      }
    }
  }

  handleButtonState(){
    canDoPayment = false;
    for (PaymentDueItem item in itemList) {
      if(item.isChecked ?? false){
        canDoPayment = true;
      }
    }
    notifyListeners();
  }
}