import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:flutter/material.dart';

class MandatoryFieldNote extends StatelessWidget {
  final textColor;

  const MandatoryFieldNote({Key key, this.textColor=ColorResource.colorMarineBlue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
            margin: EdgeInsets.only(right: 16.0, bottom: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "*",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w300,
                      fontSize: responsiveTextSize(18.0),
                      color: textColor),
                ),
                Text(
                  AppTranslations.of(context).text("ct_mandatory_note"),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w300,
                      fontSize: responsiveTextSize(14.0),
                      color: textColor),
                ),
              ],
            )));
  }
}
