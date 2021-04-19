import 'package:customer/bloc/base_pagination_bloc.dart';
import 'package:customer/data/repository/payment_repository.dart';
import 'package:customer/model/base.dart';
import 'package:customer/model/payment/payment_item.dart';

class PaymentBloc extends BasePaginationBloc<PaymentItem>{
  int get size => 20;

  double _paidAmount=0;

  double get paidAmount => _paidAmount;

  set paidAmount(double value) {
    _paidAmount = value;
  }

  getListFromApi({callback})async{
     isLoading=true;
     var response=await PaymentRepository.getPayment(getBaseQueryParam());
     checkResponse(response,successCallback: (){
     paidAmount = response.data['totalPaidAmount'];
     var paymentResponse = PaymentResponse.fromJson(response.data);

       if(paymentResponse.customerPayments.contentList.isNotEmpty) {
         setPaginationItem(paymentResponse.customerPayments);
       }else {
         paidAmount=0.0;
       }

     });
     takeDecisionShowingError(response);
     return response;
   }

  setContentList(contentList)  {
    itemList = convertDynamicListToStaticList<PaymentItem>(contentList);
  }

   @override
  reloadList({additionalQueryParam,callback}) {
    return super.reloadList(additionalQueryParam: additionalQueryParam);
  }
}