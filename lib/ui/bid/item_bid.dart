import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/bid/bid_item.dart';
import 'package:customer/styles.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/utils/app_data_ui_utils.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ItemBid extends BaseItemView<BidItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onItemClick(item),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Commented
          /*Padding(
            padding: const EdgeInsets.only(left:18.0,right: 18,top: 18),
            child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              Expanded(
                child: AutoSizeText(
                  item.fleetOwnerName,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: ColorResource.colorMarineBlue,
                      fontFamily: 'roboto',
                      fontSize: responsiveTextSize(18)),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: ColorResource.colorMarineBlue,
                size: responsiveSize(24.0),
              ),
            ]),
          ),*/
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.all(responsiveSize(12.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          translate(context, 'txt_driver').toUpperCase(),
                          style: TextStyle(
                              fontSize: responsiveTextSize(12),
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w700,
                              color: ColorResource.colorMarineBlue),
                        ),
                        isNullOrBlank(item.driverId)
                            ? buildNotProvided(context)
                            : buildDriverRating(item),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                translate(context, 'txt_truck').toUpperCase(),
                                style: TextStyle(
                                    fontSize: responsiveTextSize(12),
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.w700,
                                    color: ColorResource.colorMarineBlue),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            setTrackerImageVisibility(item)
                          ],
                        ),
                        isNullOrEmpty(item.truckRegistrationNumber)
                            ? buildNotProvided(context)
                            : _buildTruckRating(item),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        height: responsiveSize(80),
                        child: VerticalDivider(
                          color: ColorResource.divider_color,
                          thickness: 1,
                        )),
                  ],
                ),
                _buildAmountWidget(context, item),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildAmountWidget(context, BidItem item) {
  var bidAmount = RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: TextStyle(fontSize: responsiveDefaultTextSize()),
      children: <TextSpan>[
        TextSpan(
            text: translate(context, "bid").toUpperCase() + " ",
            style: Styles.totalTextStyle),
        TextSpan(
            text: '${amountWithCurrencySign(item.totalAmount)}',
            style: Styles.amountTextStyle)
      ],
    ),
  );
  var advanceAmount = RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: "",
      style: DefaultTextStyle.of(context).style,
      children: <TextSpan>[
        TextSpan(
            text: AppTranslations.of(context).text("txt_adv") + " ",
            style: Styles.bookingDetailLabel),
        TextSpan(
            text: '${amountWithCurrencySign(item.advanceAmount)}',
            style: Styles.blueBigTextBold),
      ],
    ),
  );
  return Expanded(
    child: Align(
      alignment: Alignment.centerRight,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[bidAmount, advanceAmount],
            ),
            SizedBox(
              width: responsiveSize(6.0),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorResource.warm_grey,
              size: responsiveSize(24.0),
            )
          ],
        ),
      ),
    ),
  );
}

_buildTruckRating(item) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      RatingBarIndicator(
        itemCount: 5,
        rating: double.parse(item.truckRating),
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: ColorResource.colorMariGold,
        ),
        itemSize: responsiveSize(18),
      ),
      SizedBox(width: 5),
      Text(
        localize('number_decimal_count',
            dynamicValue: item.truckRating.toString(), symbol: "%f"),
        style: TextStyle(
            fontSize: responsiveTextSize(11),
            fontFamily: 'roboto',
            fontWeight: FontWeight.w500,
            color: ColorResource.colorMarineBlue),
      )
    ],
  );
}

buildDriverRating(item) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      RatingBarIndicator(
        itemCount: 5,
        rating: double.parse(item.driverRating),
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: ColorResource.colorMariGold,
        ),
        itemSize: responsiveSize(18),
      ),
      SizedBox(
        width: 5,
      ),
      Text(
        localize('number_decimal_count',
            dynamicValue: item.driverRating.toString(), symbol: "%f"),
        style: TextStyle(
            fontSize: responsiveTextSize(11),
            fontFamily: 'roboto',
            fontWeight: FontWeight.w500,
            color: ColorResource.colorMarineBlue),
      )
    ],
  );
}

buildNotProvided(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text(
        translate(context, 'tdp_np_lbl'),
        style: TextStyle(
            fontSize: responsiveTextSize(14),
            fontFamily: 'roboto',
            fontWeight: FontWeight.w300,
            color: ColorResource.colorBlack),
      )
    ],
  );
}
