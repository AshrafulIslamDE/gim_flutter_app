import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppRefreshConfiguration extends StatelessWidget{
  var child;
  AppRefreshConfiguration({this.child});
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
        enableLoadingWhenFailed: true,
        headerBuilder: () => WaterDropMaterialHeader(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        headerTriggerDistance: 80.0,        // header trigger refresh trigger distance
        springDescription:SpringDescription(stiffness: 170, damping: 16, mass: 1.9),         // custom spring back animate,the props meaning see the flutter api
        maxOverScrollExtent :100, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
        maxUnderScrollExtent:0, // Maximum dragging range at the bottom
        enableScrollWhenRefreshCompleted: true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
        hideFooterWhenNotFull: false, // Disable pull-up to load more functionality when Viewport is less than one screen
        enableBallisticLoad: true,
        child:child ,
      autoLoad: true,
      enableScrollWhenTwoLevel:true ,
        skipCanRefresh:true
    );
  }

}