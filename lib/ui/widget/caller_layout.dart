import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CallerWidget extends StatefulWidget {
  final double extSpacing;
  final bool autoAlignment;
  final heroTag;

  CallerWidget(
      {this.autoAlignment = true,
      this.extSpacing = 27.0,
      this.heroTag = "callButton"});

  @override
  _CallerWidgetState createState() => _CallerWidgetState(
      autoAlignment: autoAlignment, extSpacing: extSpacing, heroTag: heroTag);
}

class _CallerWidgetState extends State<CallerWidget> {
  final double extSpacing;
  final bool autoAlignment;
  final heroTag;
  bool isIosVer13 = false;

  _CallerWidgetState({this.autoAlignment, this.extSpacing, this.heroTag});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isIos13().then((ios13) {
        setState(() {
          isIosVer13 = ios13;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: autoAlignment
          ? null
          : EdgeInsets.only(bottom: kBottomNavigationBarHeight + (!isIosVer13 ? extSpacing : extSpacing+50.0)),
      child: Visibility(
        visible: !isIosVer13,
        child: FloatingActionButton(
          heroTag: heroTag,
          backgroundColor: ColorResource.colorMariGoldTran,
          child: SvgPicture.asset(
            'svg_img/ic_dialer_btn.svg',
            height: 30, // responsiveSize(30),
            width: 30, //responsiveSize(30),
          ),
          onPressed: () => call('tel:${translate(context, "txt_apl_no")}'),
        ),
      ),
    );
  }
}
