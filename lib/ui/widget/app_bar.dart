import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  var title;
  var backgroundColor;
  var appbarContentColor;
  bool shouldShowBackButton;
  final List<Widget> action;
  final automaticallyImplyLeading;
  final leadingWidget;
  bool shouldShowDivider = false;
  var setResultVal;

  AppBarWidget(
      {Key key,
      this.title,
      this.shouldShowDivider = true,
      this.backgroundColor = Colors.white,
      this.automaticallyImplyLeading = true,
      this.leadingWidget,
      this.appbarContentColor = ColorResource.colorPrimary,
      this.shouldShowBackButton = true,
      this.action,
      this.setResultVal})
      : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        AppBar(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          centerTitle: true,
          brightness: Brightness.dark,
          automaticallyImplyLeading: automaticallyImplyLeading,
          iconTheme: IconThemeData(color: appbarContentColor),
          leading: shouldShowBackButton
              ? IconButton(
                  onPressed: () => Navigator.maybePop(context,setResultVal),
                  icon: Icon(Icons.arrow_back_ios,
                  size: responsiveSize(20.0),),
                )
              : leadingWidget,
          //IconButton(icon:IconData(Icons.arrow_back_ios),color: ColorResource.colorPrimary, onPressed: () {},),
          title: Text(
            title.toUpperCase(),
            style: TextStyle(
                fontFamily: "roboto",
                fontSize: responsiveDefaultTextSize(),
                fontWeight: FontWeight.w700,
                color: appbarContentColor),
          ),

          actions: action,
        ),
       // SizedBox(height: responsiveSize(value),),
        Positioned.fill(
          bottom: 0.0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Visibility(
                 visible: shouldShowDivider,
                child: Divider(
                    height: responsiveSize(1),
                    thickness: responsiveSize(1),
                    color: shouldShowDivider
                        ? ColorResource.divider_color
                        : Colors.transparent)),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight/2+responsiveSize(kToolbarHeight/2) + 1);
}
