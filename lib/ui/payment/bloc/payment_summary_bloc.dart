import 'package:customer/bloc/base_bloc.dart';

class PaymentSummaryBloc extends BaseBloc{

  var _totalNoOfTrip;
  var _totAmtToBePaid;
  var _listOfTripId;

  get totNoOfTrip => _totalNoOfTrip;
  get totAmtToBePaid => _totAmtToBePaid;
  get listOfTripsId => _listOfTripId.toString();

  PaymentSummaryBloc(noOfPay,payAmount,listOfTripId){
    _totalNoOfTrip = noOfPay.toString();
    _totAmtToBePaid = payAmount;
    _listOfTripId = listOfTripId?.join(',');
  }

}