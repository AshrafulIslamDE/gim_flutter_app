import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/dashboard/dashboard_trip.dart';
import 'package:customer/model/payment/payment_item.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemPayment extends BaseItemView<PaymentItem>{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: position%2==0?Color.fromRGBO(0, 50, 80, 0.04):Colors.white,
        padding: EdgeInsets.only(left: 5,right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex:2,child: Padding(
              padding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
              child: AutoSizeText(convertTimestampToDateTime(timestamp: item
                  .paymentDate,dateFormat: AppDateFormat),textAlign:TextAlign
                  .center,
                style:TextStyle(color: Colors.black,fontSize:
                responsiveTextSize(10.0),fontFamily: 'roboto') ,),
            )),
            SizedBox(height: 35, child: VerticalDivider(color: ColorResource.divider_color,width: 1,)),
            Expanded(flex:2,child: Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: AutoSizeText(item.transactionId,textAlign:TextAlign.center,
                style:TextStyle(color: Colors.black,fontSize:
                responsiveTextSize(10.0),fontFamily: 'roboto') ,),
            )),
            SizedBox(height: 35, child: VerticalDivider(color: ColorResource.divider_color,width: 1,)),
            Expanded(flex:2,child: Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: AutoSizeText(item.paymentMode,textAlign:TextAlign.center,
                style:TextStyle(color: Colors.black,fontSize:
                responsiveTextSize(10.0),fontFamily: 'roboto') ,),
            )),
            SizedBox(height: 35, child: VerticalDivider(color: ColorResource.divider_color,width: 1,)),
            Expanded(flex:1,child: Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: AutoSizeText(amountWithCurrencyFormatting(item.amount,
                  shouldShowCurrencySign: false),textAlign:TextAlign.center,
                style:TextStyle(color: Colors.black,fontSize:
                responsiveTextSize(10.0),fontFamily: 'roboto') ,),
            )),
          ],
        ),
      ),
    );
  }
}