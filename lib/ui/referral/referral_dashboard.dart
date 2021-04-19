import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/bloc/referral/referral_dashboard_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/referral/item_referral_dashboard.dart';
import 'package:customer/ui/widget/adapter.dart';
import 'package:customer/ui/widget/optimized_adapter.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReferralDashboardScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider<ReferralDashboardBloc>(create: (context) => ReferralDashboardBloc(),)],
      child:ReferralDashboardPage() ,
    );
  }

}

class ReferralDashboardPage extends StatefulWidget {
  @override
  _ReferralDashboardPageState createState() => _ReferralDashboardPageState();
}

class _ReferralDashboardPageState extends State<ReferralDashboardPage> {
   final scaffoldState=GlobalKey<ScaffoldState>();
   ReferralDashboardBloc bloc;
  @override
  void initState() {
    bloc=Provider.of<ReferralDashboardBloc>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((callback){
      bloc.getListFromApi();
    });    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        key:scaffoldState ,
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Consumer<ReferralDashboardBloc>(builder:(context,bloc,_)=> GestureDetector(
                            onTap: ()=>bloc.referralFilter=ReferralDashboardBloc.REGISTERED_USER_WITH_REFERRAL,
                            child: Container(
                              color: isRegisteredUser()?ColorResource.very_light_blue:Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(translate(context, 'no_registered_user').toUpperCase(),textAlign: TextAlign.center,style: TextStyle(fontSize:responsiveTextSize(13),color: ColorResource.colorMarineBlue,fontFamily:'roboto',fontWeight: FontWeight.w900),),
                                    SizedBox(height: 8,),
                                     AutoSizeText(bloc.registeredUserCount.toString(),style:
                                    TextStyle(color: ColorResource.colorMarineBlue,fontSize:responsiveTextSize(25),fontFamily: 'roboto'),textAlign: TextAlign.center,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 84, child: VerticalDivider(color: ColorResource.divider_color,width: 1,)),
                      Expanded(
                        child: Consumer<ReferralDashboardBloc>(builder:(context,bloc,_)=> GestureDetector(
                            onTap: ()=>bloc.referralFilter=ReferralDashboardBloc.UNREGISTERED_USER_WITH_REFERRAL,
                            child: Container(
                              color: !isRegisteredUser()?ColorResource.very_light_blue:Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(translate(context, 'no_of_pening_invitation').toUpperCase(),textAlign: TextAlign.center,style: TextStyle(fontSize:responsiveTextSize(13),color: ColorResource.colorMarineBlue,fontFamily:'roboto',fontWeight: FontWeight.w900),),
                                    SizedBox(height: 8,),
                                     AutoSizeText(bloc.pendingUserCount.toString(),style:
                                    TextStyle(color: ColorResource.colorMarineBlue,fontSize:responsiveTextSize(25),fontFamily: 'roboto'),maxLines: 1,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                   Divider(height: 0,thickness: 1,),
                   getListViewHeader(),
                  getList<ReferralDashboardBloc>(bloc,()=>ItemReferralDashboard())

                ],
              ),
            ),
            showLoaderWithNonItemMessage<ReferralDashboardBloc>(bloc),
          ],
        ),
      ),
    );
  }
   getListViewHeader(){
     List<String> headerItems=isRegisteredUser()?[translate(context, 'mobile_no'),translate(context, 'date_reg'),translate(context, 'reg_as'),]
         :[translate(context, 'mobile_no'),translate(context, 'date_of_invitation'),translate(context, 'invite_as')];

     return Container(
       color: Color.fromRGBO(0, 50, 80, 0.086),
       padding: EdgeInsets.only(left: 5,right: 5),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.start,
         children: <Widget>[
           Expanded(flex:1,child: Padding(
             padding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
             child: AutoSizeText(headerItems[0].toUpperCase(),textAlign:TextAlign.center, style:headerTextStyle),
           )),
           SizedBox(height: 30, child: VerticalDivider(color: ColorResource.divider_color,width: 1,)),
           Expanded(flex:1,child: AutoSizeText(headerItems[1].toUpperCase(),textAlign:TextAlign.center, style:headerTextStyle)),
           SizedBox(height: 30, child: VerticalDivider(color: ColorResource.divider_color,width: 1,)),
           Expanded(flex:1,child: AutoSizeText(headerItems[2].toUpperCase(),textAlign:TextAlign.center, style:headerTextStyle)),
         ],
       ),
     );
   }
   isRegisteredUser()=>Provider.of<ReferralDashboardBloc>(context).referralFilter==ReferralDashboardBloc.REGISTERED_USER_WITH_REFERRAL;

   final headerTextStyle= TextStyle(fontFamily: 'roboto',
       fontSize:responsiveTextSize(12), color: ColorResource.colorMarineBlue,fontWeight: FontWeight.w900
   );
}