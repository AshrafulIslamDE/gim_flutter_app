import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/model/base.dart';
import 'package:customer/networking/api_response.dart';
import 'package:floor/floor.dart';

class BasePaginationBloc<T> extends BaseBloc{
  int _currentPage=1;
  int _size=10;

  int get size => _size;

  set size(int value) {
    _size = value;
  }

  int _totalPage=0;
  int _totalNumberOfItems=0;
  Map<String,String> queryParam=Map();
  List<T>_itemList=[];
  List<T> get itemList => _itemList;

  set itemList(List<T> value) {
    if(value!=null && value.isNotEmpty)
      _itemList.addAll(value);
    print(this.runtimeType.toString()+":"+itemList.length.toString());
    notifyListeners();
  }

  int get totalNumberOfItems => _totalNumberOfItems;

  set totalNumberOfItems(int value) {
    if(value!=null)
    _totalNumberOfItems = value;
  }
  
  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
  }

  int get totalPage => _totalPage;

  set totalPage(int value) {
    _totalPage = value;
  }

  Map getBaseQueryParam(){
    queryParam['size']=size.toString();
    queryParam['page']=currentPage.toString();
    return queryParam;
  }

  resetList(){
    currentPage=1;
    queryParam.clear();
    getBaseQueryParam();
    itemList.clear();
    itemList=[];
  }

  setPaginationItem(BasePagination pagination){
   if(isLoading==true) isLoading=false;
    currentPage++;
    totalNumberOfItems=pagination.numberOfResults;
    totalPage=pagination.totalPages;
    print("totalpage:"+pagination.totalPages.toString());
    totalNumberOfItems=pagination.numberOfResults;
     setContentList(pagination.contentList);
  }
  setContentList(contentList){
    itemList=contentList;
  }
  getListFromApi({callback}) async{}


  reloadList({additionalQueryParam,callback}){
    resetList();
    if(additionalQueryParam!=null) queryParam.addAll(additionalQueryParam);
    getListFromApi(callback: callback);
  }
}