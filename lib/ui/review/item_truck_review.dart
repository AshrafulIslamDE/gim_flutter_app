import 'package:customer/model/review/truck_review_response.dart';
import 'package:customer/ui/review/review_item_widget.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';

class ReviewTruckItem extends BaseItemView<TruckReviewItem> {
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
            ReviewItemWidget(
                name: item.truckRegistrationNumber,
                rating: item.truckRating,
                review: item.truckReview,
                reviewedOn: item.reviewedAt),
            SizedBox(height: 15,)
          ],
        ),
      ),
    );
  }
}
