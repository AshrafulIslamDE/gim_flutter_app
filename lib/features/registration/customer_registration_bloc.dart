
import 'package:flutter/cupertino.dart';

class CustomerRegistrationBloc with ChangeNotifier{
  int _registrationStep=0;

  int get registrationStep => _registrationStep;

  set registrationStep (int value) {
    print('registrationstep:'+registrationStep.toString());
    _registrationStep = value;
    notifyListeners();
    print('registrationstep:'+registrationStep.toString());
  }
  decreaseStepNumber(){
    registrationStep=--registrationStep;
    notifyListeners();
    print('registrationstep:'+registrationStep.toString());

  }

}