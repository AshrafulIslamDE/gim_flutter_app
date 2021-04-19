import 'package:customer/bloc/base_pagination_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

showEmptyWidget<T extends BasePaginationBloc>({warning_msg}){
  return Consumer<T>(
    builder: (context, bloc, _) =>Visibility(
      visible: bloc.itemList?.isEmpty&& !bloc.isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 50,right: 50,top: 50),
            child: AspectRatio(
                aspectRatio: 468/144,
                child: Image.asset('images/trip_welcome.webp',)),
          ),
          SizedBox(height: 30,),
          Text(translate(context, warning_msg??'no_trip'),style:
          TextStyle(fontSize: responsiveSize(18),color: ColorResource.semi_transparent_color_light),)
        ],
      ),
    ),
  );
}

showEmptyMsg<T extends BasePaginationBloc>({warning_msg}){
  return Consumer<T>(
    builder: (context, bloc, _) =>Visibility(
      visible: bloc.itemList?.isEmpty&& !bloc.isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 100,),
          Text(translate(context, warning_msg??'no_record_found'),style:
          TextStyle(fontSize: responsiveSize(18),color: ColorResource.semi_transparent_color_light),)
        ],
      ),
    ),
  );
}
