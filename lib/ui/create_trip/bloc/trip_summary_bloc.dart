import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/create_trip/model/create_trip_response.dart';
import 'package:customer/ui/create_trip/repo/create_trip_repo.dart';
import 'package:customer/utils/prefs.dart';
class TripSummaryBloc extends BaseBloc {
  var tripNumber=" ";
  createTrip(request) async {
    isLoading = true;
    var response = await CreateTripRepo.createTrip(request);
    isLoading = false;
    switch (response.status) {
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        var createTripResponse = CreateTripResponse.fromJson(response.data);
        tripNumber=createTripResponse.tripNumber.toString();
        break;
      case Status.ERROR:
        break;
    }
    return response;
  }

  bool isEnterpriseUser() => Prefs.getBoolean(Prefs.PREF_IS_ENTERPRISE_USER);
}
