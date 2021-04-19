import 'package:customer/ui/trip/base_trip_list_bloc.dart';
import 'package:customer/data/repository/trip_repository.dart';
import 'package:customer/networking/api_response.dart';

class HistoryTripBloc extends BaseTripListBloc {
  @override
  getListFromApi({callback})async{
     queryParam={'size':size.toString(),'page':currentPage.toString(),};
    isLoading=true;
    ApiResponse response=await TripRepository.getCompletedTripList(queryParam: queryParam);
    onTripListResponse(response,callback: callback);
    takeDecisionShowingError(response);
    return response;
  }

}