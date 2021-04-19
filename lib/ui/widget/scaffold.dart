import 'package:customer/ui/widget/platform_specific_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ScaffoldLayout
    extends PlatformSpecificWidget<CupertinoPageScaffold, Scaffold> {

  final Widget header;
  final Widget body;
  final Widget navigationBar;
  final Widget floatingActionButton;

  ScaffoldLayout(
      {this.header, this.body, this.navigationBar, this.floatingActionButton});

  @override
  Scaffold androidWidget(BuildContext context) {
    return Scaffold(
      appBar: header,
      body: body,
      bottomNavigationBar: navigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  @override
  CupertinoPageScaffold iosWidget(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: header,
      child: body,
    );
  }
}
