
import 'package:customer/networking/api_response.dart';
import 'package:flutter/foundation.dart';

class BaseBloc with ChangeNotifier{
  var isPageDisposed=false;
  bool _shouldShowErrorPage=false;
  bool get shouldShowErrorPage => _shouldShowErrorPage;
  String errorMessage="nothing";

  set shouldShowErrorPage(bool value) {
    if(_shouldShowErrorPage!=value) {
      print(this.runtimeType.toString()+value.toString());
      _shouldShowErrorPage = value;
      notifyListeners();
    }
  }

  var _isLoading=false;

  get isLoading => _isLoading;

  set isLoading(value) {
    print('success');
    if(isLoading!=value) {
      _isLoading = value;
      notifyListeners();
    }
  }
  checkResponse(ApiResponse response,{Function successCallback,Function errorCallback}){
    isLoading=false;
    print("response"+response.apiResponse.toString());
    if(response.status==Status.COMPLETED){
      if(successCallback!=null) {
          successCallback();
        }
    }else{
      if(errorCallback!=null) {
        errorCallback(response);
      }
      baseErrorCallback(response);
    }

  }

  baseErrorCallback(ApiResponse response){}

  @override
  void notifyListeners({shouldNotifyDirectly=false}) {
    if(!isPageDisposed||shouldNotifyDirectly)
      super.notifyListeners();
  }

  @override
  void dispose() {
    isPageDisposed=true;
    print(this.runtimeType.toString()+": disposed");
    super.dispose();
  }

  takeDecisionShowingError(ApiResponse response ){
    if(isApiError(response)) {
      errorMessage=response.message;
      shouldShowErrorPage = true;
    }
    else
      shouldShowErrorPage=false;
  }
  bool isApiError(ApiResponse response)=>response==null||response.status==Status.ERROR;
}
