import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/data/local/db/app_database.dart';
import 'package:customer/data/local/db/database_controller.dart';
import 'package:customer/data/local/db/goods_type.dart';
import 'package:customer/data/local/db/truck_types.dart';
import 'package:customer/data/repository/customer_repository.dart';
import 'package:customer/model/base.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/date_time_utils.dart';

class DashboardFilterBloc extends BaseBloc{
  List<GoodsType>_goodsList=[];

  List<GoodsType> get goodsList => _goodsList;

  set goodsList(List<GoodsType> value) {
    _goodsList = value;
    notifyListeners();
  }
  String fromDate;
  String toDate;
  int goodsTypeId;
  String goodsTypeText;

  getGoodsTypeList()async{
    ApiResponse response=await CustomerRepository.getGoodsTypeList();
    checkResponse(response,successCallback: (){
      goodsList=convertDynamicListToStaticList<GoodsType>(response.data);
      filterInBanglaGoodsType(goodsList,isTrip: false);
      print("length"+goodsList.length.toString());
    });
  }

  /*filterInBanglaGoodsType()async{
    if(!isBangla()) return;
    if(isNullOrEmptyList(goodsList)) return;
    for(var item in goodsList){
       if(item.text.isNotEmpty){
         AppDatabase dbItem=await openDatabase();
         var searchedItem=await dbItem.goodsTypeDao.findGoodsBanglaName(item.text);
         if(searchedItem!=null && !isNullOrEmpty(searchedItem.textBn)){
           item.text=searchedItem.textBn;
         }
       }

    }
    }
*/


  getQueryParamater(){
    Map queryMap=Map<String,String>();
    print(fromDate.toString());
    if(!isNullOrEmpty(fromDate))
      queryMap['fromPickupDate']=getFormattedDate(fromDate,originalFormat: AppDateFormat,presentationFormat: ISOFormat);
    if(!isNullOrEmpty(toDate))
      queryMap['toPickupDate']=getFormattedDate(toDate,originalFormat: AppDateFormat,presentationFormat: ISOFormat);;
    if(goodsTypeId!=null)
      queryMap['goodsType']=goodsTypeId.toString();
      queryMap['goodsTypeText']=goodsTypeText;
      queryMap['fromDate']=fromDate;
      queryMap['toDate']=toDate;

    return queryMap;
  }

}