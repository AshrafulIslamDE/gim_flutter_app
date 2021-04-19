import 'package:customer/bloc/base_pagination_bloc.dart';
import 'package:customer/data/repository/customer_repository.dart';
import 'package:customer/model/base.dart';
import 'package:customer/model/dashboard/dashboard_trip.dart';
import 'package:floor/floor.dart';

class DashboardBloc extends BasePaginationBloc<DashboardTrip>{
  int get size => 20;

  int _grandTotalTrip=0;

  int get grandTotalTrip => _grandTotalTrip;

  set grandTotalTrip(int value) {
    _grandTotalTrip = value;
  }

  int _totalTrip=0;
  double _totalAmountPaid=0.0;
  var _isFilterApplied=false;

  get isFilterApplied => _isFilterApplied;

  set isFilterApplied(value) {
    _isFilterApplied = value;
  }

  int get totalTrip => _totalTrip;

  set totalTrip(int value) {
    _totalTrip = value;
    if(!isFilterApplied)
      grandTotalTrip=totalTrip;
  }
  getListFromApi({callback})async{
     isLoading=true;
     var response=await CustomerRepository.getDashboardTripList(getBaseQueryParam());
     checkResponse(response,successCallback: (){
       var pagination=BasePagination<DashboardContent>.fromJson(response.data);
       if(pagination.contentList.isNotEmpty) {
         totalTrip = pagination.contentList[0].totalTripTaken;
         totalAmountPaid = pagination.contentList[0].totalAmountPaid;
         setPaginationItem(pagination);
       }else {
         totalTrip = 0;
         totalAmountPaid=0.0;
       }

     });
     takeDecisionShowingError(response);
     return response;
   }

  double get totalAmountPaid => _totalAmountPaid;

  set totalAmountPaid(double value) {
    _totalAmountPaid = value;
      }
  setContentList(contentList)  {
    itemList=contentList[0].dashboardTripModels;
  }
   @override
  reloadList({additionalQueryParam,callback}) {
    if(additionalQueryParam==null)isFilterApplied=false;
    return super.reloadList(additionalQueryParam: additionalQueryParam);
  }
}