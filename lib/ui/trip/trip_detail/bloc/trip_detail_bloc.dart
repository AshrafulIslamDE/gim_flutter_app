import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/data/local/db/database_controller.dart';
import 'package:customer/model/trip/trip_detail_response.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/trip/trip_detail/repo/trip_detail_repo.dart';
import 'package:customer/utils/prefs.dart';

class TripDetailBloc extends BaseBloc {
  TripDetailResponse _tripDetail;

  TripDetailResponse get tripDetail => _tripDetail;

  set tripDetailResponse(ApiResponse apiResponse)  {
    isLoading = false;
    if (apiResponse.status == Status.COMPLETED) {
      _tripDetail = TripDetailResponse.fromJson(apiResponse.data);
      fetchBanglaInformation();
    }
    notifyListeners();
  }
  fetchBanglaInformation() async {
    if(isBangla()) {
      await filterInBanglaTruckType([tripDetail]);
      await filterInBanglaGoodsType([tripDetail]);
      notifyListeners();
    }
  }

  getTripDetail(int tripId) async {
    isLoading = true;
    ApiResponse apiResponse = await TripDetailRepo.getTripDetail({'tripId': tripId});
    tripDetailResponse = apiResponse;
    isLoading = false;
    return apiResponse;
  }

  Future<ApiResponse> cancelTrip(int tripId) async {
    isLoading = true;
    notifyListeners();
    return await TripDetailRepo.cancelTrip(0, tripId);
  }

  bool isEnterpriseUser() => Prefs.getBoolean(Prefs.PREF_IS_ENTERPRISE_USER);
  bool isDistributor() => Prefs.getBoolean(Prefs.IS_DISTRIBUTOR);
}
