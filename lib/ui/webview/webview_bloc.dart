import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/networking/network_common.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';

class WebviewBloc extends BaseBloc{
  var orginalUrl;
  var offlineUrl=Uri.dataFromString( '<html><body><h1>Network Unavailble</h1></body></html>',
      mimeType: 'text/html')
      .toString();

  var _url="";

  get url => _url;

  set url(value) {
    if(url!=value) {
      _url = value;
      notifyListeners();
    }
  }

  checkInternet()async {
    isLoading=true;
    var offline=await isOffline();
    if(offline) {
      showCustomSnackbar(localize('network_error_message'), bgColor: ColorResource.pink_red);
      shouldShowErrorPage=true;
    }
    isLoading=false;
  }

  onPageFinished() {
    Future.delayed(const Duration(milliseconds: 500), () {
          isLoading=false;
        });
  }
}