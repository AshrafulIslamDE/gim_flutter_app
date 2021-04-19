import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TruckInfoWidget extends StatelessWidget {
  var item;

  TruckInfoWidget(this.item);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        getNetworkImage(context,
            url: item.truckIcon,
            width: responsiveSize(DimensionResource.trip_widget_right_margin),
            height: responsiveSize(18),
            placeHolderImage: SvgPicture.asset('svg_img/ic_truck.svg')),
        SizedBox(
          width: responsiveSize(10),
        ),
        Text(
          item.getTruckTypeWithSize(),
          style: TextStyle(
            fontSize: responsiveTextSize(14.0),
            color: ColorResource.colorMarineBlue,
            fontWeight: FontWeight.w500,
            fontFamily: 'roboto',
          ),
        ),
      ],
    );
  }
}
