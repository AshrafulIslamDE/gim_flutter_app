import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/bid/bid_item.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/bid/bid_detail_bloc.dart';
import 'package:customer/ui/home/homepage.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ViewBidDetailItem extends StatelessWidget {
  final BidItem item;

  ViewBidDetailItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    item.truckLength = 10.0;
    return ChangeNotifierProvider<BidDetailBloc>(
      create: (context) => BidDetailBloc(),
      child: BidDetailItem(
        item: item,
      ),
    );
  }
}

class BidDetailItem extends StatefulWidget {
  final BidItem item;

  BidDetailItem({Key key, this.item}) : super(key: key);

  @override
  _BidDetailItemState createState() => _BidDetailItemState();
}

class _BidDetailItemState extends State<BidDetailItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: Colors.grey,
          height: 1,
          thickness: 1,
        ),
        _getAdvanceAmount(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:2.0),
                child: SvgPicture.asset('svg_img/ic_driver_id.svg',
                    color: ColorResource.colorMarineBlue, height: 12.0,),
              ),
              SizedBox(width: 4.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildDriverWidget(),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 1,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('svg_img/ic_truck_b.svg',
                  color: ColorResource.colorMarineBlue, height: 12.0),
              SizedBox(width: 4.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildTruckWidget(),
              ),
            ],
          ),
        ),
        FilledColorButton(
            buttonText: translate(context, 'accept_bid'),
            horizonatalMargin: 20,
            verticalMargin: 18,
            onPressed: () => onAcceptBidButtonPressed()),
        Divider(
          color: ColorResource.marigold_two,
          height: 2,
          thickness: 2,
        )
      ],
    );
  }

  _buildTruckWidget() {
    var truckWidget = Text(
      translate(context, 'txt_truck').toUpperCase(),
      style: TextStyle(
          fontSize: responsiveTextSize(12),
          fontFamily: 'roboto',
          fontWeight: FontWeight.w700,
          color: ColorResource.colorMarineBlue),
    );
    return isNullOrEmpty(widget.item.truckRegistrationNumber)
        ? [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                truckWidget,
                SizedBox(height: 5.0),
                Text(
                  translate(context, 'tdp_np_lbl').toUpperCase(),
                  style: TextStyle(
                      fontSize: responsiveTextSize(16),
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w500,
                      color: ColorResource.colorBlack),
                ),
              ],
            )
          ]
        : [
            Row(
              children: [
                truckWidget,
                isNullOrEmpty(widget.item.truckRating) ? Container():
                Row(children: [
                  Icon(
                    Icons.star,
                    color: ColorResource.colorMariGold,
                    size: responsiveTextSize(12),
                  ),
                  Text(
                    localize('number_decimal_count',
                        dynamicValue: widget.item.truckRating.toString(), symbol: "%f").toUpperCase().toUpperCase(),
                    style: TextStyle(
                        fontSize: responsiveTextSize(12),
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w700,
                        color: ColorResource.colorMarineBlue),
                  )
                ],),
              ],
            ),
            SizedBox(height: responsiveSize(5.0)),
            FittedBox(
              child: Text(
                widget.item.truckRegistrationNumber.toUpperCase(),
                style: TextStyle(
                    fontSize: responsiveTextSize(14),
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w500,
                    color: ColorResource.colorBlack),
              ),
            ),
            SizedBox(height: responsiveSize(5.0)),
            Text(
              widget.item.getTruckTypeWithSize().toUpperCase(),
              style: TextStyle(
                  fontSize: responsiveTextSize(14),
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w400,
                  color: ColorResource.colorMarineBlue),
            ),
            SizedBox(height: responsiveSize(5.0)),

            isNullOrBlank(widget.item.truckLength)?Container():
            Text(
              translate(context, 'truck_length')+" "+localize('number_decimal_count',
                  dynamicValue: widget.item.truckLength.toString(), symbol: '%f') +
                  translate(context,'ft_unit'),
              style: TextStyle(
                  fontSize: responsiveTextSize(14),
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w400,
                  color: ColorResource.colorBlack),
            )
          ];
  }

  _buildDriverWidget() {
    var driverWidget = Text(
      translate(context, 'txt_driver').toUpperCase(),
      style: TextStyle(
          fontSize: responsiveTextSize(12),
          fontFamily: 'roboto',
          fontWeight: FontWeight.w700,
          color: ColorResource.colorMarineBlue),
    );
    return isNullOrEmpty(widget.item.driverName)
        ? [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                driverWidget,
                SizedBox(height: 5.0),
                Text(
                  translate(context, 'tdp_np_lbl').toUpperCase(),
                  style: TextStyle(
                      fontSize: responsiveTextSize(16),
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w500,
                      color: ColorResource.colorBlack),
                ),
              ],
            )
          ]
        : [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    driverWidget,
                    isNullOrEmpty(widget.item.driverRating) ? Container():
                    Row(children: [
                      Icon(
                        Icons.star,
                        color: ColorResource.colorMariGold,
                        size: responsiveTextSize(12),
                      ),
                      Text(
                        localize('number_decimal_count',
                            dynamicValue: widget.item.driverRating.toString(), symbol: "%f").toUpperCase(),
                        style: TextStyle(
                            fontSize: responsiveTextSize(12),
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w700,
                            color: ColorResource.colorMarineBlue),
                      )
                    ],),
                  ],
                ),
                Text(
                  translate(context, 'license_expiry').toUpperCase(),
                  style: TextStyle(
                      fontSize: responsiveTextSize(12),
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.colorMarineBlue),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.item.driverName,
                  style: TextStyle(
                      fontSize: responsiveTextSize(12),
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.colorMarineBlue),
                ),
                Text(
                  getFormattedDate(widget.item.driverLicenceNoExpiryDate,
                      originalFormat: 'yyyy-MM-dd',
                      localization: languageCode()),
                  style: TextStyle(
                      fontSize: responsiveTextSize(12),
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w700,
                      color: ColorResource.colorMarineBlue),
                ),
              ],
            )
          ];
  }

  _getAdvanceAmount(){
    return isNullOrBlank(widget.item.advanceAmount)? Container():
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 16.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translate(context,'advance_amount').toUpperCase(),
                style: TextStyle(
                    fontSize: responsiveTextSize(12),
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w500,
                    color: ColorResource.dark_yellow),
              ),
              Text(
                '${amountWithCurrencySign(widget.item.advanceAmount)}',
                style: TextStyle(
                    fontSize: responsiveTextSize(18),
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w500,
                    color: ColorResource.dark_yellow),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 1,
          thickness: 1,
        )
      ]);
  }

  onAcceptBidButtonPressed() async {
    showAlertWithDefaultAction(context,
        title: translate(context, 'accept_bid_dialog_title'),
        positiveBtnTxt: translate(context, 'yes'),
        negativeButtonText: translate(context, 'no'),
        callback: () => callAcceptBidApi());
  }

  callAcceptBidApi() async {
    var bloc = Provider.of<BidDetailBloc>(context, listen: false);
    bloc.bidId = widget.item.bidId;
    submitDialog(context, dismissible: true);
    ApiResponse response = await bloc.placeBid();
    Navigator.pop(context);
    if (!bloc.isApiError(response)) {
      FireBaseAnalytics().logEvent(AnalyticsEvents.EVENT_BID_ACCEPTED, {
        AnalyticsParams.FLEET_OWNER_NAME:
            bloc.bidDetailResponse?.fleetOwnerName ?? ''
      });
      onSuccessfulBid();
    } else {
      showSnackBar(null, response.message);
    }
  }

  onSuccessfulBid() {
    showAlertWithDefaultAction(context,
        title: translate(context, 'success'),
        content: translate(context, 'accept_bid_success_msg'),
        positiveBtnTxt: translate(context, 'txt_ok'), callback: () {
      navigateNextScreen(context, Home(), shouldFinishPreviousPages: true);
    });
  }
}
