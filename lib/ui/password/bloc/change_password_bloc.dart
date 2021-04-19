import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/password/change_password_request.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/password/repo/change_password_repo.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/validationUtils.dart';
class ChangePasswordBloc extends BaseBloc {
  String _errorMsg;
  bool isValidated = false;


  get errorMsg => _errorMsg;


  get buttonColor => isValidated ? HexColor("#003250") : HexColor("#96003250");

  changePassword(ChangePassWordRequest cpr) async {
    isLoading = true;
    notifyListeners();
    ApiResponse apiResponse;
    try {
      apiResponse = await ChangePasswordRepo.changePassword(cpr);
      isLoading = false;
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
    return apiResponse;
  }

  validate(List<String> values){
    RegExp regex = RegExp(PASSWORD_REGEX);
    for(int index = 0 ; index < 3 ; index++){
      if (!regex.hasMatch(values[index])) {
        isValidated = false;
        notifyListeners();
        return;
      }
    }
    if(values[2].isNotEmpty && values[2].length > 5 && values[1].isNotEmpty && values[1].compareTo(values[2]) != 0){
      _errorMsg = localize('password_mismatch');
      isValidated = false;
    }else{
      _errorMsg = null;
      isValidated = true;
    }
    notifyListeners();
  }

}
