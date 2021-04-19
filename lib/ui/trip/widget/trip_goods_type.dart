
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';

class TripGoodsTypeWidget extends StatelessWidget{
  var item;
  TripGoodsTypeWidget(this.item);
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.only(left:responsiveSize(28.0+8.0)),
          child: Text(translate(context,'tdp_goods_type').toUpperCase(),
              style: TextStyle(
                  color: ColorResource.colorFadedBlue,
                  fontSize: responsiveTextSize(14.0),
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 0,
        ),
        Padding(
          padding:  EdgeInsets.only(left:responsiveSize(28.0+8.0)),
          child: Text(
            isBangla() ? item.goodsTypeInBn ?? item.goodsType : item.goodsType,
            style: TextStyle(
                fontSize: responsiveSize(14.0),
                color: ColorResource.colorBlack,
                fontFamily: 'roboto'),
          ),
        ),
      ],
    );
  }

}