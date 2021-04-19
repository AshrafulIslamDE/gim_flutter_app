
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';

class TripAddressInfoWidget extends StatelessWidget{
  var item;
  TripAddressInfoWidget(this.item);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.asset(
              "images/pickuparrow.png",
              height: responsiveSize(24),
              width:responsiveSize(18.0+8.0) ,
            ),
            SizedBox(
              width: responsiveSize(10),
            ),
            Text(translate(context, 'tdp_pick_lbl').toUpperCase(),
                style: TextStyle(
                    color: ColorResource.colorMarineBlue,
                    fontSize: responsiveTextSize(14),
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.bold)),
            SizedBox(
              width: responsiveSize(5),
            ),
            Text(
              convertTimestampToDateTime(timestamp: item.pickupDateTimeUtc),
              style: TextStyle(
                fontSize: responsiveTextSize(14.0),
                color: ColorResource.colorMarineBlue,
                fontStyle: FontStyle.normal,
                fontFamily: 'roboto',
              ),
            )
          ],
        ),
        SizedBox(
          height: 0,
        ),
        Padding(
          padding:  EdgeInsets.only(left: responsiveSize(28.0+8.0)),
          child: Text(
            item.pickupAddress,
            style: TextStyle(
                fontSize: responsiveTextSize(14),
                color: ColorResource.colorBlack,
                fontFamily: 'roboto'),
          ),
        ),
        SizedBox(
          height: responsiveSize(5),
        ),
        Row(
          children: <Widget>[
            Image.asset(
              "images/dropoffarrow.png",
              height: responsiveSize(24),
              width: responsiveSize(18.0+8.0),
            ),
            SizedBox(
              width: responsiveSize(10.0),
            ),
            Text(translate(context,'tdp_drop_lbl').toUpperCase(),
                style: TextStyle(
                    color: ColorResource.colorFadedBlue,
                    fontSize: responsiveTextSize(14),
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(
          height: 0,
        ),
        Padding(
          padding:  EdgeInsets.only(left:responsiveSize(28.0+8.0)),
          child: Text(
            item.dropoffAddress,
            style: TextStyle(
                fontSize: responsiveTextSize(14.0),
                color: ColorResource.colorBlack,
                fontFamily: 'roboto'),
          ),
        ),
        SizedBox(
          height: responsiveTextSize(5.0),
        ),

      ],
    );
  }

}