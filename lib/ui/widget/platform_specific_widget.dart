import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class PlatformSpecificWidget<I extends Widget, A extends Widget>
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return iosWidget(context);
    } else if (Platform.isAndroid) {
      return androidWidget(context);
    } else
      return Container(
        child: Center(
          child: Text("Platform not supported."),
        ),
      );
  }

  I iosWidget(BuildContext context);

  A androidWidget(BuildContext context);
}
