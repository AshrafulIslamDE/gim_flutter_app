import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/styles.dart';
import 'package:customer/ui/receipt/view_receipt_page.dart';
import 'package:customer/ui/trip/booking_detail/booking_detail_page.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TripInfoWidget extends StatelessWidget {
  final int tripId;
  final String address;
  final String amountInfo;
  final String totalAmount;
  final String advanceAmount;
  final TRIP_STATUS tripStatus;

  TripInfoWidget(this.tripId,
      {this.address,
      this.amountInfo,
      this.totalAmount,
      this.advanceAmount,
      this.tripStatus});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Visibility(
              visible: tripStatus == TRIP_STATUS.COMPLETED,

              child: Row(mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  CustomButton(prefixIcon: Icon(
                    Icons.description,
                    size: responsiveSize(20.0),
                    color: Colors.white,
                  ),
                    text:translate(context,'receipt'),
                    bgColor: ColorResource.colorMarineBlue,
                    textColor: Colors.white,
                    fontSize: 16.0,
                    onPressed: ()=>navigateNextScreen(context, ViewReceiptScreen(tripId)),
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            visible: address != null,
            child: Text(
              address != null ? address : "",
              style: Styles.bookingDetailLabel,
              textAlign: TextAlign.center,
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "",
              style:TextStyle(fontSize: responsiveDefaultTextSize()),
              children: <TextSpan>[
                TextSpan(
                    text: tripStatus == TRIP_STATUS.COMPLETED
                        ? AppTranslations.of(context).text("txt_total_paid")
                        : AppTranslations.of(context).text("txt_total"),
                    style: Styles.totalTextStyle),
                TextSpan(
                    text: ' $totalAmount', style: Styles.amountTextStyle)
              ],
            ),
          ),
          Visibility(
            visible: tripStatus != TRIP_STATUS.COMPLETED,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "",
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: AppTranslations.of(context).text("txt_adv"),
                      style: Styles.bookingDetailLabel),
                  TextSpan(
                      text: ' $advanceAmount',
                      style: Styles.blueBigTextBold),
                ],
              ),
            ),
          ),
          Visibility(
              visible: tripStatus == TRIP_STATUS.BOOKED,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(amountInfo, style: Styles.blueMedTextBold,textAlign: TextAlign.center,),
              ))
        ],
      ),
    );
  }
}
