import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IosButtonWidget extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final Function callback;
  final double containerWidth;

  IosButtonWidget(
      {this.text,
      this.textColor,
      this.bgColor,
      this.containerWidth,
      this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(
              Radius.circular(4.0) //                 <--- border radius here
              )),
      child: CupertinoButton(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        color: bgColor,
        borderRadius: new BorderRadius.circular(4.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: new TextStyle(
                color: textColor,
                fontFamily: "roboto",
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
          ),
        ),
        onPressed: () {
          callback();
        },
      ),
    );
  }
}
