import 'package:customer/bloc/home/homebloc.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/remote_config.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget getDrawerIcon(ScaffoldState state){
  /*
  * this method is used to provide drawer in every pages
  * which share same bottom navigation menu and drawer

  * We will call appStatus api on opening drawer every time to check
  * whether customer is approved or not
   */
  return GestureDetector(
      onTap: () async{
        state?.openDrawer();
        var bloc=Provider.of<HomeBloc>(state.context,listen: false);
        bloc.getUserStatus();
        if((bloc.isDistributor()&& isNullOrEmpty(bloc.profileInfo.distributorCompanyName)))
          bloc.getProfileInfo();
        FireBaseRemoteConfig.instance.setPaymentId(Prefs.getString(Prefs.PREF_USER_MOBILE));
      },
      child: Padding(
        padding: const EdgeInsets.only(left:8.0),
        child: Icon(
          Icons.dehaze,
          color: ColorResource.colorMarineBlue,
          size: responsiveSize(24.0),
        ),
      ));
}