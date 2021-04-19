import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/trip/trip_detail_response.dart';
import 'package:customer/styles.dart';
import 'package:customer/ui/review/view_review_page.dart';
import 'package:customer/ui/trip/booking_detail/booking_detail_page.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/app_data_ui_utils.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TruckWidget extends StatelessWidget {
  final bool isEnterprise;
  final TRIP_STATUS tripStatus;
  final TripDetailResponse bookingDetail;

  TruckWidget(this.bookingDetail, this.tripStatus, this.isEnterprise);

  @override
  Widget build(BuildContext context) {
    var subLabel = isNullOrEmpty(bookingDetail.truckType) || isNullOrBlank(bookingDetail.partnerTruckSize) ? null : '${isBangla() ? bookingDetail.truckTypeInBn ??  bookingDetail.truckType : bookingDetail.truckType}'
        ', ${localize('number_decimal_count', dynamicValue: bookingDetail.partnerTruckSize.toString(), symbol: "%f")}'
        '${translate(context, "txt_ton")}';
    return Container(
        padding: EdgeInsets.only(
            left: 20.0,
            top: responsiveSize(10.0),
            right: 10.0,
            bottom: responsiveSize(10.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            bookingDetail.truckImage == null
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
                  size: responsiveSize(64.0), url: bookingDetail.truckImage),
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
                                Text(translate(context, "txt_truck"),style: Styles.bookingDetailHeading),
                                setTrackerImageVisibility(bookingDetail),
                                Visibility(
                                  visible: tripStatus == TRIP_STATUS.COMPLETED,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: ratingWidget(bookingDetail.tripTruckRating),
                                      ),
                                  ),
                                )
                              ],
                            )),
                        Visibility(
                          visible: tripStatus == TRIP_STATUS.COMPLETED && (bookingDetail.tripTruckRating != null),
                          child: GestureDetector(
                            onTap: () {
                              navigateNextScreen(
                                  context,
                                  ViewReviewPage(
                                    translate(context, "txt_truck_rev_ttl"),
                                    label: bookingDetail.truckRegNo,
                                    rating: bookingDetail.tripTruckRating,
                                    subLabel: bookingDetail.tripTruckReview,
                                    tripReviewImage: bookingDetail.tripReviewImage,
                                  ));
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
                    isNullOrBlank(bookingDetail.truckRegNo)
                        ? buildNotProvided(context)
                        : AutoSizeText(
                      bookingDetail.truckRegNo ?? '',
                      style: Styles.bookingDetailLabel,
                    ),
                    SizedBox(height: 4.0),
                    Visibility(
                        visible: !isNullOrEmpty(bookingDetail.truckRegNo),
                        child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Visibility(
                                  visible:!isNullOrEmpty(bookingDetail.truckRegNo) ,
                                  child: Row(
                                    children: <Widget>[
                                      getNetworkImage(context,
                                          url: bookingDetail?.truckIcon,
                                          width: responsiveSize(
                                              DimensionResource
                                                  .trip_widget_right_margin),
                                          height: responsiveSize(18),
                                          placeHolderImage: SvgPicture.asset(
                                              'svg_img/ic_truck.svg',
                                              width: responsiveSize(
                                                  DimensionResource
                                                      .trip_widget_right_margin),
                                              height: responsiveSize(18))),
                                      SizedBox(width: responsiveSize(4.0))
                                    ],
                                  )),
                              Visibility(
                                visible: !isNullOrEmpty(subLabel),
                                child: Expanded(
                                  child: AutoSizeText(subLabel ?? '',
                                      maxLines: 1,
                                      style: Styles.bookingDetailSubLabel),
                                ),
                              ),
                            ],
                          ),
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
