
import 'package:customer/bloc/referral/referral_dashboard_bloc.dart';
import 'package:customer/bloc/referral/referral_history_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/home/home_drawer_icon.dart';
import 'package:customer/ui/referral/referral_dashboard.dart';
import 'package:customer/ui/referral/referral_history.dart';
import 'package:customer/ui/referral/referral_invitation_screen.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/ui/widget/refresh_config_widget.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ReferralScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MultiProvider(
     providers: [
       ChangeNotifierProvider<ReferralDashboardBloc>(create: (context)=>ReferralDashboardBloc(),),
       ChangeNotifierProvider<ReferralHistoryBloc>(create: (context)=>ReferralHistoryBloc(),)
     ],
     child:ReferralPage() ,
   );
  }

}

class ReferralPage extends StatefulWidget{
  @override
  _ReferralPageState createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> with SingleTickerProviderStateMixin {
  TabController _controller;
   List<String> _tabTitles ;
   final scaffoldState=GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _controller=TabController(length: 2,initialIndex: 0,vsync: this,);
    int previousIndex;
    _controller.addListener(() {
      if (previousIndex != _controller.index){
        previousIndex = _controller.index;
        FireBaseAnalytics().screenViewEvent(ScreenView.REF_SCREENS[previousIndex]);
      }
    });
    super.initState();
  }
  getTabList(){
    List<Widget> tabs = new List.generate(2, (i)=>Padding(
      padding: const EdgeInsets.only(bottom: 10.0,top: 10.0),
      child: FittedBox(fit:BoxFit.fitWidth,child: Text(_tabTitles[i].toUpperCase(),
        style: TextStyle(fontSize: responsiveTextSize(12),fontFamily: 'roboto'),)),
    ));
    return tabs;
  }


  @override
  Widget build(BuildContext context) {
    _tabTitles=[translate(context, 'dashboard'),translate(context, 'history')];

    return SafeArea(
      child: AppRefreshConfiguration(
        child: Scaffold(
          key: scaffoldState,
          appBar: AppBarWidget(title: translate(context, 'referrals'),action: <Widget>[
            GestureDetector(
              onTap: ()=>onInvitationIconClick(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('svg_img/ic_invitation.svg'),
              ),
            ),
          ],
            shouldShowBackButton: false,
            leadingWidget: getDrawerIcon(Scaffold.of(context)),
          ),
          body: Container(
            color: Colors.white,
            height: double.infinity,
            child: Column(
              children: <Widget>[
                TabBar(
                  unselectedLabelColor: ColorResource.colorBrownGrey,
                  indicatorColor: ColorResource.colorMarineBlue,
                  labelColor: ColorResource.colorMarineBlue,
                  labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                  controller: _controller,

                  tabs:getTabList(),
                  // child: ,
                ),
                Divider(height: 1,),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                      children: [
                    ReferralDashboardScreen(),
                    ReferralHistoryScreen(),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  onInvitationIconClick(context) async {
    var pageResult=await navigateNextScreen(context, ReferralInvitationScreen());
    if(pageResult!=null){

      if(_controller.index==0)
        Provider.of<ReferralDashboardBloc>(context,listen: false).reloadList();
      else
        Provider.of<ReferralHistoryBloc>(context,listen: false).reloadList();
    }

  }
}