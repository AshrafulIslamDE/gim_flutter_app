import 'package:customer/ui/widget/platform_specific_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Header extends PlatformSpecificWidget<ObstructingPreferredSizeWidget, AppBar> implements ObstructingPreferredSizeWidget {

  final Widget leading;
  final Widget title;

  Header({
    this.leading,
    this.title,
  });

  @override
  AppBar androidWidget(BuildContext context) => AppBar(
        leading: leading,
        title: title,
      );

  @override
  ObstructingPreferredSizeWidget iosWidget(BuildContext context) =>
      CupertinoNavigationBar(
        leading: leading,
        middle: title,
      );

  @override
  bool get fullObstruction => true;

  @override
  Size get preferredSize {
    return new Size.fromHeight(44.0);
  }

  @override
  bool shouldFullyObstruct(BuildContext context) {
    // TODO: implement shouldFullyObstruct
    return null;
  }
}
