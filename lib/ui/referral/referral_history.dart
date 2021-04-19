import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/bloc/referral/referral_history_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/referral/item_referral_paid_amount.dart';
import 'package:customer/ui/referral/item_referral_reward_earned.dart';
import 'package:customer/ui/widget/adapter.dart';
import 'package:customer/ui/widget/optimized_adapter.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReferralHistoryScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ReferralHistoryBloc>(create: (context)=>ReferralHistoryBloc(),)
      ],
      child:ReferralHistoryPage() ,
    );
  }

}

class ReferralHistoryPage extends StatefulWidget {
  @override
  _ReferralDashboardPageState createState() => _ReferralDashboardPageState();
}

class _ReferralDashboardPageState extends State<ReferralHistoryPage> {
  final scaffoldState=GlobalKey<ScaffoldState>();
  ReferralHistoryBloc bloc;
  @override
  void initState() {
    bloc=Provider.of<ReferralHistoryBloc>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((callback){
      bloc.getListFromApi();
    });
    super.initState();
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
                        child: Consumer<ReferralHistoryBloc>(builder:(context,bloc,_)=> GestureDetector(
                          onTap: ()=>bloc.userEarningFilter=ReferralHistoryBloc.reward_earned,
                          child: Container(
                            color: isTotalAmountEarnedSection()?ColorResource.lightBlue:Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(translate(context, 'total_amount_earned').toUpperCase(),textAlign: TextAlign.center,style: TextStyle(fontSize:responsiveTextSize(13),color: ColorResource.colorMarineBlue,fontFamily:'roboto',fontWeight: FontWeight.w900),),
                                  SizedBox(height: 8,),
                                  AutoSizeText(amountWithCurrencySign(bloc.totalEarnedAmount),maxLines:1,style:
                                  TextStyle(color: ColorResource.colorMarineBlue,fontSize:responsiveTextSize(25),fontFamily: 'roboto'),textAlign: TextAlign.center,)
                                ],
                              ),
                            ),
                          ),
                        ),
                        ),
                      ),
                      SizedBox(height: 85, child: VerticalDivider(color: ColorResource.divider_color,width: 1,)),
                      Expanded(
                        child: Consumer<ReferralHistoryBloc>(builder:(context,bloc,_)=> GestureDetector(
                          onTap: ()=>bloc.userEarningFilter=ReferralHistoryBloc.paid_amount,
                          child: Container(
                            color: !isTotalAmountEarnedSection()?ColorResource.lightBlue:Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(translate(context, 'total_amount_paid').toUpperCase(),textAlign: TextAlign.center,style: TextStyle(fontSize:responsiveTextSize(13),color: ColorResource.colorMarineBlue,fontFamily:'roboto',fontWeight: FontWeight.w900),),
                                  SizedBox(height: 8,),
                                  AutoSizeText(amountWithCurrencySign(bloc.totalPaidAmount),style:
                                  TextStyle(color: ColorResource.colorMarineBlue,fontSize:responsiveTextSize(25),fontFamily: 'roboto'),maxLines: 1,)
                                ],
                              ),
                            ),
                          ),
                        ),
                        ),
                      ),
                      SizedBox(height: 85, child: VerticalDivider(color: ColorResource.divider_color,width: 1,)),
                      Expanded(
                        child: Consumer<ReferralHistoryBloc>(builder:(context,bloc,_)=> GestureDetector(
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(translate(context, 'total_outstanding').toUpperCase(),textAlign: TextAlign.center,style: TextStyle(fontSize:responsiveTextSize(13),
                                      color: HexColor("b3d3cf"),fontFamily:'roboto',fontWeight: FontWeight.w900),),
                                  SizedBox(height: 8,),
                                  AutoSizeText(amountWithCurrencySign(bloc.totalOutstandingAmount),style:
                                  TextStyle(color: HexColor("b3d3cf"),fontSize:responsiveTextSize(25),fontFamily: 'roboto'),maxLines: 1,)
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
                  getList<ReferralHistoryBloc>(bloc,()=>getListLayout())
                ],
              ),
            ),
            showLoaderWithNonItemMessage<ReferralHistoryBloc>(bloc),
          ],
        ),
      ),
    );
  }

  bool isTotalAmountEarnedSection()=>Provider.of<ReferralHistoryBloc>(context).userEarningFilter==ReferralHistoryBloc.reward_earned;
  getListLayout(){
   return isTotalAmountEarnedSection()?ItemRewardEarned():ItemReferralPaidAmount();
  }
  getListViewHeader(){
    List<String> headerItems=isTotalAmountEarnedSection()?[translate(context, 'date_of_reward'),translate(context, 'reward_reason'),translate(context, 'reward_amount'),]
        :[translate(context, 'date_of_payment'),translate(context, 'bkash_ref_no'),translate(context, 'paid_amount')];
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
  final headerTextStyle= TextStyle(fontFamily: 'roboto',
      fontSize:responsiveTextSize(11), color: ColorResource.colorMarineBlue,fontWeight: FontWeight.w900
  );
}