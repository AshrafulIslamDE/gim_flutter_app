import 'package:customer/ui/trip/base_trip_list_bloc.dart';
import 'package:customer/data/repository/trip_repository.dart';
import 'package:floor/floor.dart';

class BookedTripBloc extends BaseTripListBloc {
 @override
  getListFromApi({callback})async {
   isLoading=true;
   var response=await TripRepository.getBookedTripList(getBaseQueryParam());
   onTripListResponse(response,callback: callback);
   takeDecisionShowingError(response);
  }
}