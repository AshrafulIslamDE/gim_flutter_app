import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/home/home_drawer_icon.dart';
import 'package:customer/ui/payment/bloc/payment_due_bloc.dart';
import 'package:customer/ui/payment/bloc/payment_paid_bloc.dart';
import 'package:customer/ui/payment/payment_due_screen.dart';
import 'package:customer/ui/payment/payment_paid_screen.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/refresh_config_widget.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PaymentDueBloc>(create: (context)=>PaymentDueBloc(),),
        ChangeNotifierProvider<PaymentPaidBloc>(create: (context)=>PaymentPaidBloc(),)
      ],
      child:PaymentPage() ,
    );
  }

}

class PaymentPage extends StatefulWidget{
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends BasePageWidgetState<PaymentPage, PaymentDueBloc> with SingleTickerProviderStateMixin {
  TabController _controller;
  List<String> _tabTitles ;
  final scaffoldState = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _controller=TabController(length: 2,initialIndex: 0,vsync: this,);
    int previousIndex;
    _controller.addListener(() {
      if (previousIndex != _controller.index){
        previousIndex = _controller.index;
        FireBaseAnalytics().screenViewEvent(ScreenView.PAY_SCREENS[previousIndex]);
      }
    });
    super.initState();
  }
  getTabList(){
    List<Widget> tabs = new List.generate(2, (i)=>Padding(
      padding: const EdgeInsets.only(bottom: 16.0,top: 16.0),
      child: FittedBox(fit:BoxFit.fitWidth,child: Text(_tabTitles[i].toUpperCase(),
        style: TextStyle(fontSize: responsiveTextSize(12),fontFamily: 'roboto'),)),
    ));
    return tabs;
  }


  @override
  Widget build(BuildContext context) {
    _tabTitles=[translate(context, 'due'),translate(context, 'paid')];

    return SafeArea(
      child: AppRefreshConfiguration(
        child: Scaffold(
          key: scaffoldState,
          appBar: AppBarWidget(title: translate(context, 'payment'),
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
                        PaymentDueScreen(),
                        PaymentPaidScreen(),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}