import 'dart:io';

import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class TextConst{
  static const String PAY_TYPE_INV = 'Invoice';
  static const String PAY_TYPE_CASH = 'Cash';
  static const String PAY_TYPE_B_CASH = 'bKash';
  static const String CURRENT_LOCATION = 'Set Current Location';
}

class ColorResource {
  static const colorPrimary = Color.fromRGBO(0, 50, 80, 1.0);
  static var colorMariGold = Color.fromRGBO(255, 200, 0, 1.0);
  static var colorWhite = HexColor("ffffff");
  static var divider_light = HexColor("fafafa");
  static var colorAccent = HexColor("002439");
  static var colorPrimaryDark = HexColor("003250");
  static var colorLightMarineBlue = HexColor("006789");
  static const divider_color = Color.fromRGBO(198, 202, 209, 1.0);
  static const orange_yellow = Color.fromRGBO(255, 189, 39, 1.0);
  static const colorMarineBlue = Color.fromRGBO(0, 50, 80, 1.0);
  static const colorMarineBlueAlpha = Color.fromRGBO(0, 50, 80, 0.7);
  static const dark_yellow = Color.fromRGBO(181, 152, 36, 1.0);
  static const colorMarineBlueLight = Color.fromRGBO(0, 162, 255, 1);
  static var colorMariGoldTran = Color.fromRGBO(255, 200, 0, 0.7);
  static const brownish_grey = Color.fromRGBO(100, 100, 100, 1);
  static const light_grey = Color.fromRGBO(230,230, 230, 1);
  static const light_white=Color.fromRGBO(232, 232, 232, 1.0);
  static var warm_grey = HexColor("9b9b9b");
  static var colorFadedBlue = HexColor("609aba");
  static const colorBrownGrey = Color.fromRGBO(168, 168, 168, 1);
  static var colorBlack = HexColor("#000000");
  static var ColorDropOffBlue = HexColor("#609aba");
  static var colorTransparent = HexColor("00FFFFFF");
  static var marigold_opacity_20 = HexColor("#90ffc800");
  static var greyish_brown = HexColor("#ff4a4a4a");
  static var marigold_alpha = HexColor("ffffc800");
  static var labelColor = HexColor("#646464");
  static var greyIshBrown = HexColor("#4a4a4a");
  static var veryLightPink = HexColor("#dddddd");
  static var dropOffBlue = HexColor("#609aba");
  static var lightBlue = HexColor("#e8eff3");
  static var warmGrey = HexColor("#9b9b9b");
  static var lightBlueGrey = HexColor("#c6cad1");
  static var marigold_two = HexColor("#ffbd00");
  static var marigoldAlpha = HexColor("#90ffbd00");
  static var semi_transparent_color_light = HexColor('96003250');
  static var white_gray = HexColor('f4f4f4');
  static var marine_blue_two = HexColor('79003250');
  static var grey_white = HexColor('f6f6f6');
  static const not_read_notification = Color.fromRGBO(216, 223, 227, 1);
  static var dark_gray = HexColor('ff808080');
  static const colorLightBlueGrey = Color.fromRGBO(198, 202, 209, 1);
  static var very_light_blue = HexColor('e6ebee');
  static var pink_red = HexColor('ea1654');
  static var off_white = Color.fromRGBO(255, 255, 226, 1);
  static var lightBlu = Color.fromRGBO(136, 170, 203, 1);
}

class DimensionResource {
  static const leftMargin = 18.0;
  static const rightMargin = 18.0;
  static const formFieldContentPadding =
      EdgeInsets.only(left: 15, top: 23, right: 10, bottom: 23);
  static const filterFormFieldContentPadding =
      EdgeInsets.only(left: 15, top: 18, right: 5, bottom: 18);
  static const hPad = 20.0;
  static const screenPadding =
      EdgeInsets.only(left: 18, top: 18, right: 18, bottom: 5);
  static const trip_widget_right_margin=26.0;
}

getResponsiveDimension(EdgeInsets inset){
  return EdgeInsets.only(left: responsiveSize(inset.left),right: responsiveSize(inset.right),
      top:responsiveSize(inset.top),bottom: responsiveSize(inset.bottom));
}
class RouteConstants {
  static const String authErrorRoute = '/autherror';
  static const String addARatingRoute = '/addRating';
  static const String tripDetailRoute = '/tripDetail';
  static const String viewBidListRoute = '/viewBidList';
  static const String bookingDetailRoute = '/bookingDetail';
  static const String homeRoute = '/home';

}

class AppConstants {
  static bool iSiOS13 = true;
  static final int customerRoleId = 5;
  static String storeURL =  Platform.isIOS ? 'https://apps.apple.com/app/id1498060269' : 'https://play.google.com/store/apps/details?id=com.gim.customer';
  static String gProdApiKey = Platform.isIOS ? 'AIzaSyBhgphoSDhLGeFIgvzwYSSizM_xW4_3HAk' : 'AIzaSyA5eoutEPXPK9s07jsyhi5_E-FZP9IEQZE';
  static String gDebugApiKey = Platform.isIOS ? 'AIzaSyAMRNqkZCuD7CYSWQzcvNWxCvOJ44lNJ3U' : 'AIzaSyCg_vhbK1URhQj9NkWV57KeLzjUCEW7Hlo';
}
