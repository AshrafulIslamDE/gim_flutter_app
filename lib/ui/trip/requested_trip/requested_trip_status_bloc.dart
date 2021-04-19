import 'package:customer/ui/trip/mytripbloc.dart';
import 'package:customer/data/repository/trip_repository.dart';
import 'package:customer/model/base.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/model/trip/requested_trip_status.dart';

class RequestedTripStatusBloc extends MyTripStatusBloc{
  RequestedTripStatusResponse _tripStatus;

  RequestedTripStatusResponse get tripStatus => _tripStatus;

  set tripStatus(RequestedTripStatusResponse value) {
    _tripStatus = value;
    notifyListeners();
  }

  set tripItemCount(value){}
  getRequestedTripStatus(Function (BaseTrip) onResponse) async{
    isLoading=true;
    ApiResponse response=await TripRepository.getStatusOfRequestedTrips();
    isLoading=false;
    if(response.status==Status.COMPLETED){
       tripStatus=RequestedTripStatusResponse.fromJson(response.data);
      onResponse(getTripCount());

    }
    takeDecisionShowingError(response);

  }

  BaseTrip getTripCount(){
    return BaseTrip.counter(
        bookedTripCount: tripStatus.bookedDisplayModel.value,
        completedTripCount: tripStatus.completedDisplayModel.value,
        liveTripCount: tripStatus.liveDisplayModel.value,
        requestedTripCount: tripStatus.unbiddedDisplayModel.id+tripStatus.biddedDisplayModel.id);

  }
}

