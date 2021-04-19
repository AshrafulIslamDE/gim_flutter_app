import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/widget/expanded_tile.dart';
import 'package:customer/ui/widget/refresh_config_widget.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BaseItemView<T> extends StatelessWidget{
  T item;
  Function onItemClick;
  int position;
  BaseItemView({Key key,this.item,this.onItemClick,this.position}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

Widget networkErrorBuilder(BuildContext context) {
  var width=MediaQuery.of(context).size.width;
  var statusBarWidth=MediaQuery.of(context).padding.top;
  return  Positioned(
    top: statusBarWidth,
    left: 0.0,
    child: new Material(
        color: ColorResource.pink_red,
        child: Container(height:kToolbarHeight,width:width,
            child: Center(child: Text(translate(context, 'network_error_message'),style: TextStyle(color: ColorResource.colorWhite),)))
    ),
  );
}
 Widget networkErrorWithRetry(BuildContext context,VoidCallback onPressed,{msg}){
  var width=MediaQuery.of(context).size.width;
  var height=MediaQuery.of(context).size.height;
  return Container(
    width: width,
    height: height,
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset('svg_img/ic_warning.svg',width: responsiveSize(50.0),),
        SizedBox(height: 10,),
        Text(msg??translate(context, 'something_went_wrong').toUpperCase(),style:
        TextStyle(color:HexColor("e93e53",),fontSize: responsiveDefaultTextSize() ),),
        SizedBox(height: 10,),
        RaisedButton(
          padding: EdgeInsets.only(left:8.0,right: 8.0,top: 15.0,bottom: 15.0),
          color: ColorResource.colorMarineBlue,
          onPressed:(){onPressed();},
          child: Text(localize('retry').toUpperCase(),style: TextStyle(color: ColorResource.colorMariGold,fontSize: responsiveTextSize(16)),),
        )
      ],
    ),
  );
}
abstract class BasePageWidgetState<T extends StatefulWidget,V extends BaseBloc> extends State<T> with WidgetsBindingObserver{
  final scaffoldState=GlobalKey<ScaffoldState>();
  bool isOffline = false;
  StreamSubscription _connectionChangeStream;
  OverlayEntry myOverlay;
  V bloc;

  @override
  initState() {
    super.initState();
    bloc = Provider.of<V>(context, listen: false);
    WidgetsBinding.instance.addObserver(this);
    if(!Platform.isIOS)
    _connectionChangeStream = Connectivity().onConnectivityChanged.listen(connectionChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) =>onBuildCompleted());
  }
  onBuildCompleted()=>null;

  void connectionChanged(ConnectivityResult result) {
    print("networkconnection");
    isOffline = result.index==ConnectivityResult.none.index;
      if(isOffline){
        if(Platform.isIOS)
          return showToast(localize('network_error_message'));
        myOverlay=showOverLay(context,networkErrorBuilder);
      }else if(!Platform.isIOS && myOverlay!=null) {
        try {
          myOverlay?.remove();
        }catch(ex){}
      }
    print("isOffline: ${isOffline}");


  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    didChangeLifeCycle(state);
   // print("State:"+state.toString());
  }
  @override
  void dispose() {
    if(!Platform.isIOS)
       _connectionChangeStream?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    beforeBuildStarted();
    return  GestureDetector(
      onTap: ()=>hideSoftKeyboard(context),
      child: Scaffold(
        key: scaffoldState,

        appBar: getAppbar(),
        resizeToAvoidBottomInset: isResizeToBottomInset(),
        backgroundColor:scaffoldBackgroundColor() ,
        bottomNavigationBar: getBottomNaviagtionBar(),
        drawer: getNavigationDrawer(),
        floatingActionButton: getFloatingActionButton(),
        body: SafeArea(
          child: AppRefreshConfiguration(
            child: WillPopScope(
              onWillPop:onWillPop ,
              child: Container(
                padding: getContainerPadding(),
                height: double.maxFinite,
                width: double.infinity,
                decoration: getContainerDecoration(),
                child: Stack(
                  children: [
                    ...getPageWidget(),
                    Consumer<V>(
                      builder: (context,bloc,_)=> Visibility(
                        child: networkErrorWithRetry(context,onRetryClick,msg: bloc.errorMessage),
                        visible: bloc.shouldShowErrorPage,)),

                  ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  beforeBuildStarted(){
    //print("build:"+this.runtimeType.toString());
  }
  getContainerPadding()=>EdgeInsets.all(0.0);
  getContainerDecoration()=>null;
  Future<bool> onWillPop()async=> true;
  List<Widget> getPageWidget()=>null;
   getAppbar()=>null;
  isResizeToBottomInset()=>false;
  scaffoldBackgroundColor()=>Colors.white;
  Widget getBottomNaviagtionBar()=>null;
  Widget getNavigationDrawer()=>null;
  Widget getFloatingActionButton()=>null;
  onRetryClick(){
    bloc.shouldShowErrorPage=false;
  }
  didChangeLifeCycle(AppLifecycleState state) => null;
}

