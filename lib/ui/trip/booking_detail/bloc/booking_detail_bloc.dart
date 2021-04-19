import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/data/local/db/database_controller.dart';
import 'package:customer/data/repository/trip_repository.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/trip/booking_detail/booking_detail_page.dart';
import 'package:customer/data/repository/booking_detail_repo.dart';
import 'package:customer/model/trip/trip_detail_response.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/prefs.dart';

class BookingDetailBloc extends BaseBloc {
  String truckTypeInBn;
  TripDetailResponse _tripDetail;

  TripDetailResponse get bookingDetail => _tripDetail;

  set tripResult(TripDetailResponse value) {
    _tripDetail = value;
    notifyListeners();
  }

  BookingDetailBloc(truckInBn){
    truckTypeInBn = truckInBn;
  }

  apiResult(ApiResponse value, TRIP_STATUS tripStatus)async {
    if (tripStatus == null) {
      tripResult = TripDetailResponse.fromJson(value.data);
      _tripDetail.truckTypeInBn = truckTypeInBn;
      if(isNullOrEmpty(truckTypeInBn))
      await filterInBanglaTruckType([_tripDetail],bloc: this);
    }
  }

  Future<ApiResponse> getTripDetail(
    final int tripId, TRIP_STATUS tripStatus) async {
    isLoading = true;
    ApiResponse response;
    switch (tripStatus) {
      case TRIP_STATUS.BOOKED:
        response = await TripRepository.getBookedTripDetail({'tripId': tripId});
        break;
      case TRIP_STATUS.RUNNING:
        response = await TripRepository.getRunningTripDetail(tripId);
        break;
      case TRIP_STATUS.COMPLETED:
        response = await TripRepository.getCompletedTripDetail(tripId);
        break;
      default:
        break;
    }
    return _manipulateResponse(response, null);
  }

  ApiResponse _manipulateResponse(response, TRIP_STATUS tripStatus) {
    isLoading = false;
    switch (response.status) {
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        apiResult(response, tripStatus);
        break;
      case Status.ERROR:
        break;
    }
    return response;
  }

  Future<ApiResponse> startTrip(int tripId, TRIP_STATUS tripStatus) async {
    isLoading = true;
    return _manipulateResponse(
        await TripDetailRepository.startTrip(tripId), tripStatus);
  }

  Future<ApiResponse> cancelTrip(int tripId, int tripReasonId, TRIP_STATUS tripStatus) async {
    isLoading = true;
    return _manipulateResponse(await TripDetailRepository.cancelTrip(tripReasonId, tripId), tripStatus);
  }

  Future<ApiResponse> endTrip(int tripId, TRIP_STATUS tripStatus) async {
    isLoading = true;
    return _manipulateResponse(
        await TripDetailRepository.endTrip(tripId), tripStatus);
  }

  bool isEnterpriseUser()  => Prefs.getBoolean(Prefs.PREF_IS_ENTERPRISE_USER);

}
