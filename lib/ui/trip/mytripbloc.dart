import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/data/repository/trip_repository.dart';
import 'package:customer/model/base.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/model/trip/requested_trip_status.dart';
class MyTripStatusBloc extends BaseBloc{
  int _requestedTripCount=0;
  /*check whether we are in Requested trip status page or Requested trip list(waiting,bid received)
   when we wre in Requested Tab under MyTrips Menu*/
  bool _isRequestedTripStatusPage=true;

  bool get isRequestedTripStatusPage => _isRequestedTripStatusPage;
  var requestedTripListFilterId;

  set isRequestedTripStatusPage(bool value) {
    _isRequestedTripStatusPage = value;
    notifyListeners();
  }

  int get requestedTripCount => _requestedTripCount;

  set requestedTripCount(int value) {
    _requestedTripCount = value;
  }

  int _bookedTripCount=0;
  int _liveTripCount=0;
  int _historyTripCount=0;

  int get bookedTripCount => _bookedTripCount;

  set bookedTripCount(int value) {
    _bookedTripCount = value;
  }

  int get liveTripCount => _liveTripCount;

  set liveTripCount(int value) {
    _liveTripCount = value;
  }

  int get historyTripCount => _historyTripCount;

  set historyTripCount(int value) {
    _historyTripCount = value;
  }

  BaseTrip _tripItemCount ;

  BaseTrip get tripItemCount =>
      _tripItemCount;

  set tripItemCount(BaseTrip value) {
    print("tripItemCount:"+value.toJson().toString());
    _tripItemCount = value;
    requestedTripCount=value.requestedTripCount;
    bookedTripCount=value.bookedTripCount;
    liveTripCount=value.liveTripCount;
    historyTripCount=value.completedTripCount;
    notifyListeners();
  }

  getTripStatus() async{
    ApiResponse response=await TripRepository.getStatusOfRequestedTrips();
    if(!isApiError(response)){
      var tripStatus=RequestedTripStatusResponse.fromJson(response.data);
      tripItemCount=BaseTrip.counter(
          bookedTripCount: tripStatus.bookedDisplayModel.value,
          completedTripCount: tripStatus.completedDisplayModel.value,
          liveTripCount: tripStatus.liveDisplayModel.value,
          requestedTripCount: tripStatus.unbiddedDisplayModel.id+tripStatus.biddedDisplayModel.id);
    }
  }

}