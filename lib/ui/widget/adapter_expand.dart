import 'package:customer/bloc/base_pagination_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class ListViewBuilder<T> extends StatefulWidget{
  List<T> itemList;
   Function onItemPressed;
  VoidCallback loadMoreItem;
  var widgetType=()=>BaseItemView<T>();
  int totalPage;
  int currentPage;
  LoadStatus status;
  VoidCallback onRefresh;
  final dividerColor;
  final totalNoOfItems;
  final bool shouldKeepDefaultDivider;
  ListViewBuilder({Key key,
    @required this.itemList,
    this.widgetType,
    this.onItemPressed,
    this.loadMoreItem,
    this.currentPage=1,
    this.totalPage=1,
    this.onRefresh,
    this.totalNoOfItems,
    this.dividerColor=ColorResource.divider_color,
    this.shouldKeepDefaultDivider=false,
    this.status=LoadStatus.normal}):super(key:key){
  }
  @override
  State<StatefulWidget> createState() {
    return _ListViewBuilder();
  }

}

class _ListViewBuilder extends  State<ListViewBuilder>{
  ScrollController controller;
  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    //print("listview adapter init state");
    _refreshController=RefreshController(initialRefresh: false);
    //controller =  ScrollController()..addListener(_scrollListener);
    /*if(!shouldLoadMore())
      _refreshController.loadComplete();
*/  }
  void _scrollListener(){
   // print(controller.position.extentAfter);
    if(controller.position.extentAfter<60 && widget.status!=LoadStatus.loading
    && widget.totalPage>=widget.currentPage)
     if(widget.loadMoreItem!=null) {
       widget.loadMoreItem();
       widget.status=LoadStatus.loading;
     }
  }
  @override
  void dispose() {
    super.dispose();
   // controller.dispose();
    _refreshController.dispose();
   // print("listview adapter disposed");

  }

  bool shouldLoadMore(){
    //print('${widget.currentPage.toString()+","+ widget.totalPage.toString()}');
    return widget.currentPage<=widget.totalPage;
  }
  @override
  Widget build(BuildContext context) {

     //_refreshController=RefreshController(initialRefresh: false);

    return SmartRefresher(
      enablePullUp: true,
      footer: shouldLoadMore()? ClassicFooter(loadStyle: LoadStyle.ShowAlways):CustomFooter( height:0,loadStyle: LoadStyle.HideAlways,builder:(context,mode)=>Text('') ,),
      onRefresh:()async{
        widget.status=LoadStatus.loading;
        if(widget.onRefresh!=null)
          widget.onRefresh();
       _refreshController.refreshCompleted(resetFooterState: true);
        } ,
      onLoading:() {
       if(shouldLoadMore() && widget.loadMoreItem!=null&&widget.status!=LoadStatus.loading) {
         widget.status=LoadStatus.loading;
          widget.loadMoreItem();
        }
       _refreshController.loadComplete();
        },
      controller: _refreshController,
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: widget.dividerColor,height: 0,thickness: 0.0,),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.itemList == null ? 1 : widget.itemList.length+1,
          controller: controller,
          itemBuilder:(context,index){
            if (index == 0) {
              return new Container(
                color: ColorResource.lightBlue,
                padding: EdgeInsets.all(12.0),
                child: Text(translate(context,'lst_of_bid').toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  color: ColorResource.colorMarineBlue,
                  fontSize: responsiveTextSize(16.0),
                  fontFamily: "roboto",
                  fontWeight: FontWeight.w700,
                )),
              );
            }
            index -= 1;
            if(index >= widget.totalNoOfItems){
              return Container();
            }
            final item = widget.itemList[index];
            BaseItemView child=widget.widgetType();
            child.item=item;
            child.position=index;
            child.onItemClick=widget.onItemPressed;
            return Container(
              //padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration( //                    <-- BoxDecoration
                  border: Border(bottom: BorderSide(color: widget.dividerColor)),
                ),
                child: child);

          }
      ),
    );
  }

}

enum LoadStatus {
  normal,
  error,
  loading,
  completed,
}

getList<T extends BasePaginationBloc>(T paginationBloc, itemWidget,
    {onItemClicked,apiCallback,isSingleParameterCallback=true,shouldKeepDefaultDivider=false}) {
  return Expanded(
    child: Selector<T, int>(
        selector: (context, bloc) => bloc.itemList.length,
        builder: (context, list, _) =>
            ListViewBuilder(
              onRefresh: () {
                paginationBloc.reloadList(callback: apiCallback);
              },
              itemList: paginationBloc.itemList,
              currentPage: paginationBloc.currentPage,
              totalPage: paginationBloc.totalPage,
              shouldKeepDefaultDivider: shouldKeepDefaultDivider,
              widgetType: () => itemWidget(),
              totalNoOfItems: paginationBloc.totalNumberOfItems,
              onItemPressed:isSingleParameterCallback? (item){
                if(onItemClicked!=null)onItemClicked(item);
              } :(item,position){
                if(onItemClicked!=null)onItemClicked(item,position);
              },
              loadMoreItem: () async {
                paginationBloc.getListFromApi(callback: apiCallback);
              },
            )),
  );
}
