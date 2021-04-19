import 'package:customer/model/review/driver_review_response.dart';
import 'package:customer/ui/review/review_item_widget.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewDriverItem extends BaseItemView<DriverReviewItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ColorResource.colorWhite,
      child: InkWell(
        onTap: () => onItemClick(item),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(
              color: ColorResource.divider_color,
              height: 1,
            ),
            ReviewItemWidget(name: item.driverName, rating: item.driverRating, review: item.driverReview, reviewedOn: item.reviewedAt)
          ,SizedBox(height: 15,)
          ],
        ),
      ),
    );
  }
}