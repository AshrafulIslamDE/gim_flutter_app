import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchWidget extends StatefulWidget {
  bool defaultValue;
  Function (bool) onChangedValue;
  var activeColor;
  var inactiveColor;

  SwitchWidget({Key key,
  this.defaultValue=false,
  this.onChangedValue,
  this.activeColor,
  this.inactiveColor=ColorResource.light_grey,

  }):super(key:key){
    //print("rebuild");
  }

  @override
  State<StatefulWidget> createState() => SwitchWidgetState();
}

class SwitchWidgetState extends State<SwitchWidget> {




  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SwitchBloc>(
      create: (context)=>SwitchBloc(widget.defaultValue,widget.onChangedValue),
      child: Consumer<SwitchBloc>(
        builder: (context,bloc,_)=> GestureDetector(
          onTap: () => bloc.toggleSwitch(!bloc.switchControl),
          child: Transform.scale( scale: responsiveSize(1.0),
            child:  SizedBox(
              height: 20.0,
              child: Switch.adaptive(
                value: bloc.switchControl,
                activeColor: widget.activeColor,
                inactiveTrackColor: widget.inactiveColor,
                onChanged: (value) {
                  bloc.toggleSwitch(value);
                  widget.defaultValue=value;
                },
            ),
          ),
            ),
        ),
      ),
    );
  }
}

class SwitchBloc extends BaseBloc{
  bool switchControl=false;
  Function (bool) onChangedValue;
  SwitchBloc(this.switchControl,this.onChangedValue);
  toggleSwitch(value){
    switchControl=value;
    if(onChangedValue!=null)onChangedValue(value);
    notifyListeners();
  }
}