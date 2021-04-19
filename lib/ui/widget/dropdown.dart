import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class DropDownWidget<T> extends StatefulWidget{
  var dropDownItems=List<T>();
  Function (T) onItemSelcted;
  final isFilterWidget;
  final labelTextColor;
  final double fontSize;
  final labelTextBgColor;
  var labelText = "";
  final borderColor;
  final hintText;
  final withImg;
  final textColor;
  final isOnlyRightBorder;
  DropDownWidget(
      {Key key,
        this.dropDownItems,
        this.onItemSelcted,
        this.isFilterWidget = false,
        this.labelTextColor = ColorResource.brownish_grey,
        this.labelTextBgColor = Colors.white,
        this.labelText,
        this.fontSize = 14.0,
        this.hintText,
        this.withImg=false,
        this.textColor=Colors.black,
        this.isOnlyRightBorder=false,
        this.borderColor=ColorResource.brownish_grey
      }):super(key:key){
    if(isNullOrEmptyList(dropDownItems))
      dropDownItems=List<T>();
  }
  @override
  State<StatefulWidget> createState() {
    return _DropDownWidget();
  }

}

class _DropDownWidget<T> extends State<DropDownWidget>{
  @override
  void initState() {
   // print("dropdown Init");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<T> items=widget.dropDownItems;
    final double verticalMargin=widget.isOnlyRightBorder?0:6;
   // if(items == null || items.isEmpty  )return Container();
    return ChangeNotifierProvider<DropDownBloc<T>>(
      create:(context)=>DropDownBloc<T>(),
      child: Stack(
        children: <Widget>[
          Container(
            padding: !widget.isFilterWidget? getResponsiveDimension(DimensionResource.formFieldContentPadding):
            getResponsiveDimension(DimensionResource.filterFormFieldContentPadding),
            margin: EdgeInsets.fromLTRB(0, responsiveSize(verticalMargin),  0, responsiveSize(verticalMargin)),
            decoration: (widget.isOnlyRightBorder)?BoxDecoration(
    border: Border(
    right: BorderSide(width: 1.0, color: ColorResource.brownish_grey),
    ),
    ):BoxDecoration(
              borderRadius: BorderRadius.circular(responsiveSize(8.0)),
              border:Border.all(color: widget.borderColor) ,
            ),
            child: Consumer<DropDownBloc<T>>(
              builder: (context,bloc,child)=>Center(
                child: DropdownButton<T>(
                  underline: Container(),
                  icon: Icon(Icons.arrow_drop_down,size: responsiveSize(24.0),),
                  hint: Text(widget.hintText??translate(context,'hint_please_select')),
                  style: TextStyle(fontSize: responsiveTextSize(widget.fontSize), color: ColorResource.colorBlack,fontFamily: 'roboto'),
                  isDense: true,
                  isExpanded: true,

                  value: bloc.dropdownValue,
                  onChanged: (T newValue) {
                    bloc.dropdownValue=newValue;
                    widget.onItemSelcted(newValue);
                  },

                  items: widget.dropDownItems.map((value) {
                    return DropdownMenuItem <T>(
                      value: value,
                      child: Row(children: [
                       widget.withImg && value.image != null ? Padding(
                         padding: const EdgeInsets.only(right:8.0),
                         child: getNetworkImageProvider(
                                  height: responsiveSize(20.0),
                                  width: responsiveSize(35.0),
                                  url: value.image),
                       ):Container(),
                        AutoSizeText(value.toString(),overflow: TextOverflow.visible,)
                      ]),
                    );
                  })
                      .toList(),
                ),
              ),
            ),
          ),
          Visibility(
            visible:!isNullOrEmpty(widget.labelText) ,
            child: Positioned(
                left: responsiveSize(15.0),
                top: 3,
                child: Container(
                    padding: EdgeInsets.only(left: responsiveSize(4.0), right: responsiveSize(4.0)),
                    color: widget.labelTextBgColor,
                    child:Text(
                      widget.labelText==null?"":widget.labelText.toUpperCase(),
                      style: TextStyle(
                        color:widget.labelTextColor,
                        fontSize: responsiveTextSize(12.0),
                        fontFamily: "roboto",
                        fontWeight: FontWeight.w400,
                      ),
                    ))),
          )
        ],
      ),
    );

  }

}

class DropDownBloc<T> with ChangeNotifier{
  T _dropdownValue ;


  T get dropdownValue => _dropdownValue;

  set dropdownValue(T value) {
    _dropdownValue = value;
    notifyListeners();
  }

}