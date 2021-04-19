import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewItemWidget extends StatelessWidget {
  final String name;
  final double rating;
  final String review;
  final int reviewedOn;

  ReviewItemWidget({this.name, this.rating, this.review, this.reviewedOn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:18.0,right:18.0,top: 18.0 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Text(name,
                  style: TextStyle(
                      fontSize: responsiveTextSize(16),
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w500,
                      color: ColorResource.colorMarineBlue),
                ),
              )),
              Text(
                convertTimestampToDateTime(dateFormat: AppDateFormat, timestamp: reviewedOn),
                style: TextStyle(
                    fontSize: responsiveDefaultTextSize(),
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w700,
                    color: ColorResource.colorMarineBlue),
              ),
            ],
          ),
          _buildRating(rating),
          Visibility(
            visible:!isNullOrEmpty(review) ,
            child: SizedBox(
              height: 5.0,
            ),
          ),
          Visibility(
            visible: !isNullOrEmpty(review),
            child: Text(
              review??"",
              style: TextStyle(
                  fontSize: responsiveTextSize(16),
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w500,
                  color: ColorResource.colorMarineBlue),
            ),
          ),
        ],
      ),
    );
  }

  _buildRating(rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        RatingBarIndicator(
          itemCount: 5,
          rating: rating,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: ColorResource.colorMariGold,
          ),
          itemSize: responsiveSize(20),
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          localize('number_decimal_count',dynamicValue: rating.toString(),symbol: "%f"),
          style: TextStyle(
              fontSize: responsiveDefaultTextSize(),
              fontFamily: 'roboto',
              fontWeight: FontWeight.w500,
              color: ColorResource.colorMarineBlue),
        )
      ],
    );
  }
}
