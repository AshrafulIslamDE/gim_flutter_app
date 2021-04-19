import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/data/local/db/database_controller.dart';
import 'package:customer/model/trip/trip_detail_response.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/receipt/repo/receipt_repo.dart';

class ReceiptBloc extends BaseBloc {
  TripDetailResponse _tripDetail;

  TripDetailResponse get bookingDetail => _tripDetail;

  set tripDetail(apiResponse) {
    isLoading = false;
    _tripDetail = TripDetailResponse.fromJson(apiResponse.data);
    notifyListeners();
  }

  getTripDetail(final int tripId) async {
    isLoading = true;
    await ReceiptRepo.getCompletedTripDetail(tripId).then((apiResponse) {
      if (apiResponse.status == Status.COMPLETED) {
        tripDetail = apiResponse;
        filterInBanglaTruckType([_tripDetail],bloc: this);
      }
    });
  }
}
