import 'package:customer/ui/trip/base_trip_list_bloc.dart';
import 'package:customer/data/repository/trip_repository.dart';
import 'package:customer/networking/api_response.dart';
class LiveTripBloc extends BaseTripListBloc {
  @override
  getListFromApi({callback})async {
    isLoading=true;
    ApiResponse response=await TripRepository.getLiveTripList(getBaseQueryParam());
    onTripListResponse(response,callback: callback);
    takeDecisionShowingError(response);
  }
}