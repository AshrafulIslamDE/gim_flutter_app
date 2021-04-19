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

class InfoWidget extends StatelessWidget {
  final String ttl;
  final String name;
  final String label;
  final String imgUrl;
  final String review;
  final String heading;
  final String subLabel;
  final double tripRating;
  final bool isEnterprise;
  final String tripReviewImage;
  final TRIP_STATUS tripStatus;
  final bool forceCallVisibility;
  final bool forceSubLabelVisibility;
  final bool forceRatingVisibilityOff;
  final bool forceReviewVisibilityOff;
  final TripDetailResponse tripDetail;

  InfoWidget(
      {this.ttl,
      this.heading,
      this.name,
      this.label,
      this.subLabel,
      this.imgUrl,
      this.review,
      this.tripRating,
      this.tripDetail,
      this.isEnterprise = false,
      this.tripReviewImage,
      this.tripStatus,
      this.forceCallVisibility = true,
      this.forceSubLabelVisibility = false,
      this.forceRatingVisibilityOff = true,
      this.forceReviewVisibilityOff = false});

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
            imgUrl == null
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
                        size: responsiveSize(64.0), url: imgUrl),
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
                                Text(heading,
                                    style: Styles.bookingDetailHeading),
                                Visibility(
                                    visible: forceSubLabelVisibility,
                                    child:
                                        setTrackerImageVisibility(tripDetail)),
                                Visibility(
                                  visible: tripStatus == TRIP_STATUS.COMPLETED,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Visibility(
                                      visible: forceRatingVisibilityOff,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: ratingWidget(tripRating),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Visibility(
                          visible: tripStatus == TRIP_STATUS.COMPLETED &&
                              forceReviewVisibilityOff,
                          child: GestureDetector(
                            onTap: () {
                              navigateNextScreen(
                                  context,
                                  ViewReviewPage(
                                    ttl,
                                    label: name,
                                    rating: tripRating,
                                    subLabel: review,
                                    tripReviewImage: tripReviewImage,
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
                    isNullOrBlank(label)
                        ? buildNotProvided(context)
                        : AutoSizeText(
                            label ?? '',
                            style: Styles.bookingDetailLabel,
                          ),
                    SizedBox(height: 4.0),
                    Visibility(
                        visible: forceSubLabelVisibility || isNullOrEmpty(label)
                            ? forceSubLabelVisibility
                            : tripStatus != TRIP_STATUS.COMPLETED,
                        child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Visibility(
                                  visible: (!isEnterprise && forceCallVisibility),
                                  child: Icon(
                                    CupertinoIcons.phone_solid,
                                    color: ColorResource.colorMariGold,
                                    size: responsiveSize(24.0),
                                  )),
                              Visibility(
                                  visible: !forceCallVisibility &&
                                      !isNullOrEmpty(label) ,
                                  child: Row(
                                    children: <Widget>[
                                      getNetworkImage(context,
                                          url: tripDetail?.truckIcon,
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
                                visible: !isNullOrEmpty(subLabel) && !isEnterprise,
                                child: Expanded(
                                  child: AutoSizeText(subLabel ?? '',
                                      maxLines: 1,
                                      style: Styles.bookingDetailSubLabel),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            call('tel:$subLabel');
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
