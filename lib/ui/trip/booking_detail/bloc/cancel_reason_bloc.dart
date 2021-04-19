import 'package:customer/data/local/db/customer_trip_cancel_reason.dart';
import 'package:customer/features/master/master_repository.dart';
import 'package:flutter/foundation.dart';

class CancelReasonBloc with ChangeNotifier {
  int _selectedIndex;
  bool _isLoading = true;

  List<CustomerTripCancelReason> _cancelReasons;

  int get selectedIndex => _selectedIndex;

  bool get isLoading => _isLoading;

  get cancelReason => _cancelReasons.elementAt(_selectedIndex);

  List<CustomerTripCancelReason> get cancelReasons => _cancelReasons;

  CancelReasonBloc() {
    loadCancelReasonData();
  }

  set cancelReason(List<CustomerTripCancelReason> value) {
    _cancelReasons = value;
    notifyListeners();
  }

  loadCancelReasonData() async {
    await MasterRepository.getCancelReasons().then((onValue) {
      cancelReason = onValue;
      _isLoading = false;
      notifyListeners();
      print("CancelReasonSize:" + _cancelReasons.length.toString());
    });
  }

  onSelected(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
