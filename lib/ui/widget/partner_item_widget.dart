import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/trip/trip_detail_response.dart';
import 'package:customer/styles.dart';
import 'package:customer/ui/trip/booking_detail/booking_detail_page.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PartnerWidget extends StatelessWidget {
  final bool isEnterprise;
  final TRIP_STATUS tripStatus;
  final TripDetailResponse bookingDetail;

  PartnerWidget(this.bookingDetail, this.tripStatus, this.isEnterprise);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            left: 20.0,
            top: responsiveSize(10.0),
            right: 10.0,
            bottom: responsiveSize(10.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            bookingDetail.partnerImage == null
                ? Container(
                width: responsiveSize(64.0),
                height: responsiveSize(64.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                      Radius.circular(responsiveSize(6.0))),
                ))
                : ClipRRect(
              borderRadius:
              BorderRadius.all(Radius.circular(responsiveSize(6.0))),
              child: getNetworkImage(context,
                  size: responsiveSize(64.0),
                  url: bookingDetail.partnerImage),
            ),
            Flexible(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(translate(context, "lbl_partner"),
                                    style: Styles.bookingDetailHeading),
                              ],
                            )),
                      ],
                    ),
                    isNullOrBlank(bookingDetail.fleetOwnerName)
                        ? buildNotProvided(context)
                        : AutoSizeText(
                      bookingDetail.fleetOwnerName ?? '',
                      style: Styles.bookingDetailLabel,
                    ),
                    SizedBox(height: 4.0),
                    Visibility(
                        visible: !isNullOrEmpty(bookingDetail.fleetOwnerContact) &&
                            !isEnterprise &&
                            (tripStatus != TRIP_STATUS.COMPLETED),
                        child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                CupertinoIcons.phone_solid,
                                color: ColorResource.colorMariGold,
                                size: responsiveSize(24.0),
                              ),
                              Expanded(
                                child: AutoSizeText(
                                    bookingDetail.fleetOwnerContact ?? '',
                                    maxLines: 1,
                                    style: Styles.bookingDetailSubLabel),
                              ),
                            ],
                          ),
                          onTap: () {
                            call('tel:${bookingDetail.fleetOwnerContact}');
                          },
                        ))
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

buildNotProvided(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text(
        translate(context, 'tdp_np_lbl'),
        style: TextStyle(
            fontSize: responsiveTextSize(16),
            fontFamily: 'roboto',
            fontWeight: FontWeight.w300,
            color: ColorResource.colorBlack),
      )
    ],
  );
}
