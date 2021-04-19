import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/widget/create_trip_stepper_widget.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';

class CreateTripHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int currentStep;
  final leadingWidget;
  final double titleSpacing;
  final bool isShowBackButton;
  final Color appbarContentColor;

  CreateTripHeader({
    this.title,
    this.titleSpacing,
    this.currentStep,
    this.leadingWidget,
    this.isShowBackButton,
    this.appbarContentColor = ColorResource.colorPrimary,
  });

  /* @override
  _CreateTripHeaderState createState() => _CreateTripHeaderState();
*/
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight/2+responsiveSize(kToolbarHeight/2) + 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        AppBar(
          iconTheme: IconThemeData(color: appbarContentColor),
          leading: isShowBackButton
              ? IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: responsiveSize(20.0),
                )
              : leadingWidget,
          titleSpacing: titleSpacing ?? 0.0,
          title: Text(
            (title ?? translate(context, "create_a_trip")).toUpperCase(),
            style: TextStyle(
              fontFamily: "roboto",
              fontWeight: FontWeight.w700,
              color: appbarContentColor,
              fontSize: responsiveDefaultTextSize(),
            ),
          ),
          actions: <Widget>[
            TripStepper(
              currentStep: currentStep,
            ),
          ],
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}

/*
class _CreateTripHeaderState extends State<CreateTripHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        AppBar(
          iconTheme: IconThemeData(color: ColorResource.colorMarineBlue),
          leading: widget.isShowBackButton
              ? IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: Icon(Icons.arrow_forward),
                )
              : null,
          titleSpacing: widget.titleSpacing ?? 0.0,
          title: Text(
            (widget.title ?? translate(context, "create_a_trip")).toUpperCase(),
            style: TextStyle(
              fontFamily: "roboto",
              fontWeight: FontWeight.w700,
              color: ColorResource.colorMarineBlue,
              fontSize: 18.0,
            ),
          ),
          actions: <Widget>[
            TripStepper(
              currentStep: widget.currentStep,
            ),
          ],
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
*/
