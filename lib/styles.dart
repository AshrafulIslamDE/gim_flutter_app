import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

abstract class Styles {
  static  TextStyle hintTextStyle = TextStyle(
    color: Color.fromRGBO(221, 221, 221, 1.0),
    fontSize: responsiveDefaultTextSize(),
    fontFamily: "roboto",
    fontWeight: FontWeight.w500,
  );

  static  TextStyle tripDetailAddress = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1.0),
    fontSize: responsiveDefaultTextSize(),
    fontFamily: "roboto",
    fontWeight: FontWeight.w300,
  );

  static  TextStyle tripDetailLabel = TextStyle(
    color: Color.fromRGBO(100, 100, 100, 1.0),
    fontSize: responsiveDefaultTextSize(),
    fontFamily: "roboto",
    fontWeight: FontWeight.w300,
  );

  static  TextStyle tripDetailValue = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1.0),
    fontSize: responsiveTextSize(16.0),
    fontFamily: "roboto",
    fontWeight: FontWeight.w500,
  );

  static  TextStyle bookingDetailHeading = TextStyle(
    color: Color.fromRGBO(0, 50, 80, 1.0),
    fontSize: responsiveTextSize(16.0),
    fontFamily: "roboto",
    fontWeight: FontWeight.w900,
  );

  static  TextStyle bookingDetailLabel = TextStyle(
    color: Color.fromRGBO(0, 50, 80, 1.0),
    fontSize: responsiveTextSize(20.0),
    fontFamily: "roboto",
    fontWeight: FontWeight.w300,
  );

  static  TextStyle bookingDetailSubLabel = TextStyle(
    color: Color.fromRGBO(0, 50, 80, 1.0),
    fontSize: responsiveTextSize(18.0),
    fontFamily: "roboto",
    fontWeight: FontWeight.w300,
  );

  static  TextStyle totalTextStyle = TextStyle(
    color: Color.fromRGBO(255, 189, 0, 1.0),
    fontSize: responsiveTextSize(24.0),
    fontFamily: "roboto",
    fontWeight: FontWeight.w700,
  );

  static  TextStyle amountTextStyle = TextStyle(
    color: Color.fromRGBO(0, 50, 82, 1.0),
    fontSize: responsiveTextSize(24.0),
    fontFamily: "roboto",
    fontWeight: FontWeight.w700,
  );

  static  TextStyle blueMedTextBold = TextStyle(
    color: Color.fromRGBO(0, 50, 80, 1.0),
    fontSize: responsiveTextSize(16.0),
    fontFamily: "roboto",
    fontWeight: FontWeight.w700,
  );

  static  TextStyle blueBigTextBold = TextStyle(
    color: Color.fromRGBO(0, 50, 80, 1.0),
    fontSize: responsiveTextSize(20.0),
    fontFamily: "roboto",
    fontWeight: FontWeight.w700,
  );

  static  TextStyle textStyleGreenMed = TextStyle(
    color: Color.fromRGBO(0, 170, 75, 1.0),
    fontSize: responsiveTextSize(16),
    fontFamily: "roboto",
    fontWeight: FontWeight.w500,
  );

  static  TextStyle textStyleRedMed = TextStyle(
    color: Color.fromRGBO(234, 22, 84, 1.0),
    fontSize: responsiveTextSize(16),
    fontFamily: "roboto",
    fontWeight: FontWeight.w500,
  );

  static  TextStyle blueSmallTextBold = TextStyle(
    color: Color.fromRGBO(0, 50, 80, 1.0),
    fontSize: responsiveTextSize(12),
    fontFamily: "roboto",
    fontWeight: FontWeight.w500,
  );

  static  TextStyle hintLabelBrownish = TextStyle(
    color: Color.fromRGBO(100, 100, 100, 1.0),
    fontSize:responsiveTextSize(12),
    fontFamily: "roboto",
    fontWeight: FontWeight.w300,
  );

  static  TextStyle brownishValueBlack = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1.0),
    fontSize: responsiveTextSize(16),
    fontFamily: "roboto",
    fontWeight: FontWeight.w500,
  );

  static  TextStyle txtStyleBlackNormal = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1.0),
    fontSize: responsiveTextSize(16),
    fontFamily: "roboto",
    fontWeight: FontWeight.w300,
  );

  static  TextStyle tripNoStyle = TextStyle(
    color: Color.fromRGBO(155, 155, 155, 1.0),
    fontSize: responsiveTextSize(12),
    fontWeight: FontWeight.w500,
    fontFamily: 'roboto',
  );

  static  TextStyle mapHintTextStyle = TextStyle(
    color: Color.fromRGBO(221, 221, 221, 1.0),
    fontSize: responsiveTextSize(18),
    fontFamily: "roboto",
    fontWeight: FontWeight.w300,
  );

}
