import 'package:customer/bloc/base_bloc.dart';

class LoaderBloc extends BaseBloc{
  LoaderBloc(value){
   print("constructor");
   isLoading=value;
  }
  set isLoading(value) {
    print('loader');
    super.isLoading=value;
    notifyListeners();
  }
}