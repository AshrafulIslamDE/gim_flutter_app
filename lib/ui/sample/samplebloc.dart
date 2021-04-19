import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class SampleBloc with ChangeNotifier{

  String _buttonText="Button1";

  String get buttonText => _buttonText;

  set buttonText(String value) {
    _buttonText = value;
    notifyListeners();
  }

   onButtonClick(){
    notifyListeners();
   }

}

