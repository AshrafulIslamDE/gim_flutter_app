import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/model/referral/referral_history_response.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class ItemRewardEarned extends BaseItemView<ReferralHistoryItem> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        //color: position % 2 == 0 ? Color.fromRGBO(0, 50, 80, 0.04) : Colors.white,
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                  child: AutoSizeText(convertTimestampToDateTime(timestamp: item.rewardDate, dateFormat: AppDateFormat),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontSize: 14, fontFamily: 'roboto'),),
                ),
              ),
            ),
            Container(height:90,child: VerticalDivider(width: 0,color: ColorResource.divider_color,)),
            Expanded(flex: 1, child: Padding(
              padding: const EdgeInsets.only(left: 15.0,bottom: 5,top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(item.rewardMessage??" ", textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.black, fontSize: 14, fontFamily: 'roboto'),),
                  SizedBox(height: 10,),
                  Text(item.rewardReason??" ", textAlign: TextAlign.center, style: TextStyle(
                      color: ColorResource.greyish_brown, fontSize: 14, fontFamily: 'roboto'),),
                ],
              ),
            )),
            Container(height:90,child: VerticalDivider(width: 0,color: ColorResource.divider_color,)),
            Expanded(flex: 1, child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: AutoSizeText(amountWithCurrencySign(item.rewardAmount, shouldShowCurrencySign: true),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black, fontSize: 14, fontFamily: 'roboto'),),
            )),
          ],
        ),
      ),
    );
  }
}