
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppStepper extends StatefulWidget{
  int activeStepNumber;
  int totalStepNumber =3;
  AppStepper({Key key,this.activeStepNumber=2,this.totalStepNumber=3}):super(key:key);

  @override
  _AppStepperState createState() => _AppStepperState();
}

class _AppStepperState extends State<AppStepper> {
  int activeStepNumber;
  GlobalKey titleKey = GlobalKey();
  var stepTitle=['mobile_verification','personal_information','national_id_text'];

  @override
  Widget build(BuildContext context) {
    final stepNumber=widget.totalStepNumber;
    activeStepNumber=widget.activeStepNumber;
      WidgetsBinding.instance.addPostFrameCallback((_)=>afterBuild(context));
     return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for(int i=0;i<stepNumber-1;i++)
          Expanded(child: Row(
           children: <Widget>[
             getCircularIndicatorWidget(i+1, stepTitle[i]),
             getLine()
           ],
          ),
          ),
          getCircularIndicatorWidget(stepNumber, stepTitle[stepNumber-1])
        ],
      ),

    );


  }


  void afterBuild(BuildContext context){
   // getSizes();
  }

  getCircularIndicatorWidget(int stepNumber,String title){
      return Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color:stepNumber<=activeStepNumber?ColorResource.colorMariGold:ColorResource.colorMarineBlue ,
              shape: BoxShape.circle,
              border: new Border.all(
                  color: ColorResource.colorMariGold,
                  width: 1.0,
                  style: BorderStyle.solid
              ),
            ),
            child: Padding(
              padding: getResponsiveDimension(const EdgeInsets.all(10.0)),
              child: Text(stepNumber.toString(),style: TextStyle(color: stepNumber<=activeStepNumber?
                ColorResource.colorMarineBlue:ColorResource.colorMariGold,
                  fontSize: responsiveSize(18.0),fontWeight: FontWeight.normal),),
            ),
          ),
          Text(translate(context, title),style: TextStyle(color: stepNumber<=activeStepNumber?
          ColorResource.colorMariGold:ColorResource.colorWhite,fontSize: responsiveSize(13.0))
            , textAlign: TextAlign.center,)
        ],
      );
  }

  getLine(){
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: responsiveSize(25)),
        height: 1.5,
        decoration: BoxDecoration(
          color: ColorResource.colorMariGold,
        ),
      ),
    );
  }
  getSizes() {
    final RenderBox renderBoxRed = titleKey.currentContext.findRenderObject();
    final sizeRed = renderBoxRed.size;
    print("SIZE of Red: $sizeRed");
  }

}

getStepperWidget(int activeStep,{totalStepNumber=3}){
   double unsafeAreaSize=MediaQuery.of(getGlobalContext()).padding.top;
  if(unsafeAreaSize>0 && unsafeAreaSize>18)unsafeAreaSize=unsafeAreaSize-18;
 return Container(
    width: double.infinity,
    constraints: BoxConstraints(
        minHeight: kToolbarHeight*1.4+unsafeAreaSize
    ),
    decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('images/stepsbacking.webp'),
        )
    ),
    alignment: Alignment.center,
    child: Padding(
      padding:  EdgeInsets.fromLTRB(18.0,5.0,18.0,5.0+unsafeAreaSize),
      child: AppStepper(activeStepNumber: activeStep,totalStepNumber: totalStepNumber,),
    ),
  );
}



