import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewReviewPage extends StatelessWidget {
  final String label;
  final double rating;
  final String subLabel;
  final String titleText;
  final String tripReviewImage;

  ViewReviewPage(this.titleText,
      {this.rating, this.label, this.subLabel, this.tripReviewImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: titleText,
        shouldShowBackButton: true,
      ),
      body: Container(
        color: ColorResource.colorWhite,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(
              height: 1.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: responsiveTextSize(18.0),
                  fontFamily: "roboto",
                  fontWeight: FontWeight.w300,
                  color: ColorResource.colorMarineBlue),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: ratingWidget(rating),
              ),
            ),
            Text(
              subLabel,
              style: TextStyle(
                  fontSize: responsiveDefaultTextSize(),
                  fontFamily: "roboto",
                  fontWeight: FontWeight.w300,
                  color: ColorResource.colorMarineBlue),
            ),
            SizedBox(
              height: 10.0,
            ),
            tripReviewImage == null
                ? Container()
                : Container(
                    height: 180.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    child: Container(
                      decoration: new BoxDecoration(
                        color: const Color(0xff7c94b6),
                        borderRadius:
                            new BorderRadius.all(const Radius.circular(4.0)),
                      ),
                      child: Stack(fit: StackFit.loose, children: [
                        AspectRatio(
                          aspectRatio: 16 / 8,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: CachedNetworkImage(
                              imageUrl: tripReviewImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      ]),
                    )),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Divider(
                height: 1.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
