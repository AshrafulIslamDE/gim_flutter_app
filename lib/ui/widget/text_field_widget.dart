import 'package:customer/ui/widget/platform_specific_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget
    extends PlatformSpecificWidget<CupertinoTextField, TextField> {
  final TextEditingController tec;
  final String prefTxt;
  final Icon suffixIcon;

  TextFieldWidget({this.tec, this.prefTxt, this.suffixIcon});

  @override
  TextField androidWidget(BuildContext context) {
    return TextField(
        autocorrect: false,
        controller: tec,
        readOnly: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "PICK UP TIME*",
            prefixText: prefTxt,
            suffixIcon: suffixIcon));
  }

  @override
  CupertinoTextField iosWidget(BuildContext context) {
    return CupertinoTextField(
      autocorrect: false,
      controller: tec,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        borderRadius: BorderRadius.all(Radius.circular(4.0))
      ),
      placeholder: prefTxt,
      placeholderStyle: TextStyle(
        fontSize: 12.0
      ),
    );
  }
}
