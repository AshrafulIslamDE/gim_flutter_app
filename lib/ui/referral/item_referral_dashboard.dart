import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/model/referral/referral_response.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';

class ItemReferralDashboard extends BaseItemView<Referral> {
  @override
  Widget build(BuildContext context) {
       return GestureDetector(
           child: Container(
             color: position%2==0?Color.fromRGBO(0, 50, 80, 0.04):Colors.white,
             padding: EdgeInsets.only(left: 5,right: 5),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                 Expanded(flex:1,child: Padding(
                   padding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                   child: AutoSizeText(item.mobileNumber??" ",textAlign:TextAlign.left,
                     style:TextStyle(color: Colors.black,fontSize:responsiveTextSize(14),fontFamily: 'roboto') ,),
                 )),
                 SizedBox(height: 35, child: VerticalDivider(color: ColorResource.divider_color,width: 1,)),
                 Expanded(flex:1,child: Padding(
                   padding: const EdgeInsets.only(left:15.0),
                   child: AutoSizeText(convertTimestampToDateTime(timestamp: item.registrationDate,dateFormat: AppDateFormat),textAlign:TextAlign.left,style:TextStyle(color: Colors.black,fontSize:responsiveTextSize(14),fontFamily: 'roboto') ,),
                 )),
                 SizedBox(height: 35, child: VerticalDivider(color: ColorResource.divider_color,width: 1,)),
                 Expanded(flex:1,child: Padding(
                   padding: const EdgeInsets.only(left:15.0),
                   child: AutoSizeText(item.formattedUserRole().toString(),textAlign:TextAlign.left,style:TextStyle(color: Colors.black,fontSize:responsiveTextSize(14),fontFamily: 'roboto') ,),
                 )),
               ],
             ),
           ));
  }
}