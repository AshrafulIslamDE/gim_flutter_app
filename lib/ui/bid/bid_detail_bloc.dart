import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/data/local/db/database_controller.dart';
import 'package:customer/data/repository/bid_repository.dart';
import 'package:customer/model/bid/bid_accept_request.dart';
import 'package:customer/model/bid/bid_detail_response.dart';
import 'package:customer/networking/api_response.dart';

class BidDetailBloc extends BaseBloc{
  int bidId;
  BidDetailResponse _bidDetailResponse;

  BidDetailResponse get bidDetailResponse => _bidDetailResponse;

  set bidDetailResponse(BidDetailResponse value) {
    _bidDetailResponse = value;
    notifyListeners();
  }

  getBidDetail()async{
    var param={'bidId':bidId};
    isLoading=true;
    var response=await BidRepository.getBidDetails(param);
    isLoading=false;
    if (response.status==Status.COMPLETED){
      bidDetailResponse=BidDetailResponse.fromJson(response.data);
       filterInBanglaTruckType([bidDetailResponse],bloc: this);
      //print("value"+bidDetailResponse.toJson().toString());
    }
  }
  placeBid()async{
   var response=await BidRepository.acceptBid(BidAcceptRequest(bidId));
   checkResponse(response,successCallback: (){

   });
   return response;
  }

}