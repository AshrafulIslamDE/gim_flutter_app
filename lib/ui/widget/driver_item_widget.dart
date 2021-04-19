import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/trip/trip_detail_response.dart';
import 'package:customer/styles.dart';
import 'package:customer/ui/review/view_review_page.dart';
import 'package:customer/ui/trip/booking_detail/booking_detail_page.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverWidget extends StatelessWidget {
  final bool isEnterprise;
  final TRIP_STATUS tripStatus;
  final TripDetailResponse bookingDetail;

  DriverWidget(this.bookingDetail, this.tripStatus, this.isEnterprise);

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
            bookingDetail.driverImage == null
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
                        url: bookingDetail.driverImage),
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
                                Text(translate(context, "txt_driver"),
                                    style: Styles.bookingDetailHeading),
                                Visibility(
                                  visible: tripStatus == TRIP_STATUS.COMPLETED,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: ratingWidget(
                                          bookingDetail.tripDriverRating),
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Visibility(
                          visible: (tripStatus == TRIP_STATUS.COMPLETED) &&
                              (bookingDetail.tripDriverRating != null),
                          child: GestureDetector(
                            onTap: () {
                              navigateNextScreen(
                                  context,
                                  ViewReviewPage(
                                      translate(context, "txt_driver_rev_ttl"),
                                      label: bookingDetail.driverName,
                                      rating: bookingDetail.tripDriverRating,
                                      subLabel:
                                          bookingDetail.tripDriverReview));
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  AppTranslations.of(context)
                                      .text("txt_review"),
                                  style: Styles.blueSmallTextBold,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: ColorResource.colorMarineBlue,
                                  size: responsiveSize(14),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    isNullOrBlank(bookingDetail.driverName)
                        ? buildNotProvided(context)
                        : AutoSizeText(
                            bookingDetail.driverName ?? '',
                            style: Styles.bookingDetailLabel,
                          ),
                    SizedBox(height: 4.0),
                    Visibility(
                        visible: !isNullOrEmpty(bookingDetail.driverContact) &&
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
                                    bookingDetail.driverContact ?? '',
                                    maxLines: 1,
                                    style: Styles.bookingDetailSubLabel),
                              ),
                            ],
                          ),
                          onTap: () {
                            call('tel:${bookingDetail.driverContact}');
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
