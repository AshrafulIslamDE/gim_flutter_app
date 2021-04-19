import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/utils/app_data_ui_utils.dart';
import 'package:package_info/package_info.dart';

class LegalBloc extends BaseBloc{
  var version="";

  getVersionInfo() async{
    PackageInfo packageInfo= await PackageInfo.fromPlatform();
     version=packageInfo.version;
     notifyListeners();
  }
}