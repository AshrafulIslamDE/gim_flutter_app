import 'package:customer/bloc/base_pagination_bloc.dart';
import 'package:customer/data/local/db/database_controller.dart';
import 'package:customer/data/repository/bid_repository.dart';
import 'package:customer/model/base.dart';
import 'package:customer/model/bid/bid_item.dart';
import 'package:customer/model/trip/trip_id.dart';
import 'package:customer/networking/api_response.dart';

class ViewBidListBloc extends BasePaginationBloc<BidItem>{
   int tripNumber;
  getListFromApi({callback})async{
      isLoading=true;
      queryParam['tripId']=tripNumber.toString();
    ApiResponse response=await BidRepository.getBidLisOfTrip(getBaseQueryParam());
    isLoading=false;
    if(response.status==Status.COMPLETED){
      var pagination=BasePagination<BidItem>.fromJson(response.data);
      filterInBanglaTruckType(pagination.contentList,bloc: this);
      setPaginationItem(pagination);
    }
  }
}