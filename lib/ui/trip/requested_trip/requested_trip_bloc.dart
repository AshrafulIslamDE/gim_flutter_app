import 'package:customer/data/local/db/database_controller.dart';
import 'package:customer/ui/trip/base_trip_list_bloc.dart';
import 'package:customer/data/repository/trip_repository.dart';
import 'package:customer/model/base.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/model/trip/trip.dart';
import 'package:floor/floor.dart';

class RequestedTripBloc extends BaseTripListBloc {
   var filterId;
   getRequestedTripList({callback})async{
    isLoading=true;
    queryParam={'size':size.toString(),'page':currentPage.toString(),
      "requestedTrip":filterId.toString(),'isApp':"true"};
    ApiResponse response=await TripRepository.getTripList( queryParam);
    print("data arrived");
    onTripListResponse(response,callback: callback);
    takeDecisionShowingError(response);
  }
  @override
  getListFromApi({callback}) {
    getRequestedTripList(callback: callback);
  }

}

enum RequestedTripFilter{WaitingForBid,BidReceived}
getEnumValue(var filter){
 return filter.toString().split('.').last;
}


