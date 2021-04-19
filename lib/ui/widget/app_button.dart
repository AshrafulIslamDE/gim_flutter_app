import 'package:customer/utils/screen_dimension_utils.dart';
import "package:flutter/material.dart";
import '../../utils/ui_constant.dart';
class FilledColorButton extends StatefulWidget{
   String  buttonText;
   final isFilled;
   Color textColor=ColorResource.colorMariGold;
   //NOTE: Please make sure to set onPressed with non null return otherwise it will keep on showing blue background color.
   var backGroundColor;
   VoidCallback onPressed;
   var isFullwidth;
   var borderColor;
   bool shouldHaveLeftRightMargin=true;
   final double fontSize;
   final double innerPadding;
   final double verticalMargin;
   final double horizonatalMargin;
   final fontWeight;
   FilledColorButton({Key key,this.buttonText="Button",this.isFilled=true,this.onPressed, this.fontWeight=FontWeight.bold,
     this.fontSize=18, this.isFullwidth=true,this.shouldHaveLeftRightMargin=true,this.textColor,this.innerPadding=20,this.verticalMargin=8,
     this.horizonatalMargin=0.0,this.backGroundColor=ColorResource.colorMarineBlue,this.borderColor=ColorResource.colorMarineBlue}):super(key:key){

     if(!isFilled){
       if(textColor==null)
       textColor=ColorResource.colorMarineBlue;
       if(backGroundColor==ColorResource.colorMarineBlue)
       backGroundColor=Colors.white;
     }
     if(textColor==null)
       textColor=ColorResource.colorMariGold;
     if(this.buttonText.isEmpty)
       this.buttonText="Button";
   }
  @override
  State<StatefulWidget> createState() =>_FilledColorButton();
}

class _FilledColorButton extends State<FilledColorButton>{
  @override
  Widget build(BuildContext context) {
    var width;
    if(widget.isFullwidth)
      width= double.infinity ;
    else
      width=null;
      var  leftRightMargin=0.0;
      if(widget.shouldHaveLeftRightMargin)
        leftRightMargin=DimensionResource.leftMargin;
      return SizedBox(
      width: width,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: responsiveSize(widget.horizonatalMargin),vertical:responsiveSize(widget.verticalMargin)),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(responsiveSize(7.0))),
            side: BorderSide(color: isDisabled()?Colors.transparent:widget.borderColor,width: responsiveSize(1.0)),

          ),
          onPressed: widget.onPressed,
          child: FittedBox(child: Text(widget.buttonText.toUpperCase(),style: TextStyle( fontSize: responsiveTextSize(widget.fontSize),fontWeight: widget.fontWeight),),fit: BoxFit.fitWidth),
          padding: EdgeInsets.all(responsiveSize(widget.innerPadding)),
          textColor: widget.textColor,
          disabledColor: ColorResource.semi_transparent_color_light,
          color: isDisabled()? ColorResource.colorMarineBlueLight:widget.backGroundColor,
          disabledTextColor: ColorResource.marigold_opacity_20,
        ),
      ),
    );
  }
 isDisabled()=>widget.onPressed==null;
}

class CustomButton extends StatelessWidget{
  var prefixIcon;
  var suffixIcon;
  String text;
  var padding;
  var textColor;
  var borderColor;
  var bgColor;
  VoidCallback onPressed;
  var drawablePadding;
  bool isForwardButton;
  bool isRoundedCorner;
  bool isAllCaps=true;
  double fontSize;
  double borderRadius;
  FontWeight fontWeight;
  final layoutAlignment;
  CustomButton({Key key,
    this.text,
    this.suffixIcon,
    this.prefixIcon,
    this.padding,
    this.fontSize=14,
    this.borderColor=ColorResource.colorMarineBlue,
    this.bgColor=Colors.white,
    this.onPressed,
    this.drawablePadding=10.0,
    this.fontWeight=FontWeight.w500,
    this.borderRadius=5.0,
    this.isForwardButton=false,
    this.isRoundedCorner=true,
    this.isAllCaps=true,
    this.layoutAlignment=MainAxisAlignment.start,
    this.textColor}):super(key:key){
    if(textColor==null) textColor=ColorResource.colorMarineBlue;
    if(suffixIcon!=null && suffixIcon is IconData)
      suffixIcon=Icon(suffixIcon,color: textColor, size: responsiveSize(12),);
    if(prefixIcon!=null && prefixIcon is IconData)
      prefixIcon=Icon(prefixIcon,color: textColor,size: responsiveSize(12),);
    if(padding==null)
      padding=EdgeInsets.only(left: responsiveSize(5),right: responsiveSize(5),
        top: responsiveSize(3),bottom: responsiveSize(3));

  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        width: isForwardButton?double.infinity:null,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: isRoundedCorner?BorderRadius.circular(responsiveSize(borderRadius)):BorderRadius.circular(0.0),
          color: bgColor,
          border:Border.all(color: borderColor,width: 1),
        ),
        child: Row(
          children: <Widget>[
            SizedBox( width: responsiveSize(5)),
            prefixIcon==null?Container():prefixIcon,
            SizedBox(width:prefixIcon==null?0:responsiveSize(drawablePadding)),
            Text(isAllCaps?text.toUpperCase():text,style: TextStyle(color: textColor,fontSize: responsiveTextSize(fontSize),
                fontFamily: 'roboto',fontWeight:fontWeight ),),
            SizedBox(width:suffixIcon==null?responsiveSize(5):responsiveSize(drawablePadding)),
            suffixIcon==null?Container():isForwardButton?Expanded(child: Align(child: suffixIcon,alignment: Alignment.centerRight,)):suffixIcon
          ],
        ),
      ),
    );
  }

}


