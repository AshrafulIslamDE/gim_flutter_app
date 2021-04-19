import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/payment/model/item_due_payment.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';

class ItemPaymentPaid extends BaseItemView<PaymentDueItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: AutoSizeText(
                    convertTimestampToDateTime(
                        timestamp: item.paymentTime, dateFormat: AppDateFormat),
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                )),
            SizedBox(
                height: 35,
                child: VerticalDivider(
                  color: ColorResource.divider_color,
                  width: 1,
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: AutoSizeText(
                    localize('number_count',
                        dynamicValue: item.tripNumber.toString()),
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                )),
            SizedBox(
                height: 35,
                child: VerticalDivider(
                  color: ColorResource.divider_color,
                  width: 1,
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: AutoSizeText(
                    amountWithCurrencySign(item.amount),
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                )),
            SizedBox(
                height: 35,
                child: VerticalDivider(
                  color: ColorResource.divider_color,
                  width: 1,
                )),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: AutoSizeText(
                    item.transactionId,
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  var textStyle = TextStyle(
      color: Colors.black,
      fontSize: responsiveTextSize(12),
      fontFamily: 'roboto');
}
