import 'package:customer/bloc/base_pagination_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class Adapter<T,U extends BasePaginationBloc> extends StatefulWidget{
  List<T> itemList;
   Function onItemPressed;
  VoidCallback loadMoreItem;
  var widgetType;
  int totalPage=1;
  int currentPage=1;
  LoadStatus status;
  VoidCallback onRefresh;
  final dividerColor;
  U basePaginationBloc;
  Adapter({Key key,
    this.widgetType,
    this.onItemPressed,
    this.basePaginationBloc,
    this.dividerColor=ColorResource.divider_color,
    this.status=LoadStatus.normal}):super(key:key){
    this.itemList=basePaginationBloc.itemList;
    this.currentPage=basePaginationBloc.currentPage;
    this.totalPage=basePaginationBloc.totalPage;
  }
  @override
  State<StatefulWidget> createState() {
    return _AdapterBuilder<U>();
  }

}

class _AdapterBuilder<U extends BasePaginationBloc> extends  State<Adapter>{
  ScrollController controller;
  RefreshController _refreshController;
  @override
  void initState() {
    super.initState();
    _refreshController=RefreshController(initialRefresh: false);}

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  bool shouldLoadMore(){
    print('${widget.currentPage.toString()+","+ widget.totalPage.toString()}');
    return widget.currentPage<=widget.totalPage;
  }
  @override
  Widget build(BuildContext context) {

    _refreshController=RefreshController(initialRefresh: false);

    return Expanded(
        child: Selector<U, int>(
        selector: (context, bloc) => bloc.itemList.length,
    builder: (context, list, _) =>SmartRefresher(
      enablePullUp: true,
      footer: !shouldLoadMore()? CustomFooter( height:0,loadStyle: LoadStyle.HideAlways,builder:(context,mode)=>Text('') ,):ClassicFooter(loadStyle: LoadStyle.ShowAlways),
      onRefresh:()async{
        widget.status=LoadStatus.loading;
        widget.basePaginationBloc.reloadList();
        _refreshController.refreshCompleted(resetFooterState: true);
      } ,
      onLoading:() {
        if(!shouldLoadMore()) {
          _refreshController.loadNoData();

        } else {
          if(widget.status!=LoadStatus.loading) {
            widget.status = LoadStatus.loading;
            widget.basePaginationBloc.getListFromApi();
          }
        }
      },
      controller: _refreshController,
      child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: widget.dividerColor,height: 0,thickness: 0.5,),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.itemList.length,
          controller: controller,

          itemBuilder:(context,index){
            final item = widget.itemList[index];
            var child=widget.widgetType();
            child.item=item;
            child.position=index;
            if(widget.onItemPressed!=null)child.onItemClick=widget.onItemPressed;
            return child;

          }
      ),
    )
        )

    );
  }
  getListViewChild(){
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: widget.dividerColor,height: 0,thickness: 0.5,),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.itemList.length,
        controller: controller,

        itemBuilder:(context,index){
          final item = widget.itemList[index];
          var child=widget.widgetType();
          child.item=item;
          child.position=index;
          if(widget.onItemPressed!=null)child.onItemClick=widget.onItemPressed;
          return child;

        }
    );
  }

  getScrolledPositionedList(){}
}

enum LoadStatus {
  normal,
  error,
  loading,
  completed,
}

showNonItemsMsg<T extends BasePaginationBloc>({msg,textColor=ColorResource.colorMarineBlue}) {

  return Center(
    child: Consumer<T>(
        builder: (context, bloc, _) => Visibility(
            visible: isNullOrEmptyList(bloc.itemList) && !bloc.isLoading,
            child: Text(msg??localize('no_record_found'),
            style: TextStyle(color:textColor ,fontSize: responsiveTextSize(20),
                fontFamily:'roboto',fontWeight: FontWeight.w500),)
        ),
  )
  );
}
showLoaderWithNonItemMessage<T extends BasePaginationBloc>(T bloc,{msg,textColor=ColorResource.colorMarineBlue}){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        showNonItemsMsg<T>(msg: msg,textColor: textColor),
        SizedBox(height: 10,),
        showLoader<T>(bloc)
      ],
    ),
  );
}

