import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/utils/prefs.dart';

class BCashOptionBloc extends BaseBloc {
  final int amount;
  bool _payMode = true;
  var listOfTripId;
  final String authToken = Prefs.getString(Prefs.token);

  BCashOptionBloc(this.amount,{this.listOfTripId});

  paymentMode(){
    _payMode = !_payMode;
    notifyListeners();
  }

  get payMode => _payMode;

}
