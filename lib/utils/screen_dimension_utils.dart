import 'package:flutter_screenutil/flutter_screenutil.dart';

responsiveSize(double value){
 return customHandling(value);
}
responsiveTextSize(double value){
 return customHandling(value);
}
responsiveDefaultTextSize(){
  return responsiveTextSize(14.0);
}

customHandling(double value){
  var scaling=ScreenUtil().scaleWidth;
  /*if(scaling>1.9 && scaling<2.15)
    return value*1.9;
 else*/ if(scaling>=2.15 && scaling<2.30)
    return value*2.00;
 else if(scaling>=2.30 && scaling<2.45)
    return value*2.15;
  else
   return ScreenUtil().setWidth(value);
}