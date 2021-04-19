import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:customer/bloc/home/homebloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/create_trip/create_trip_page.dart';
import 'package:customer/ui/dashboard/dashboard_page.dart';
import 'package:customer/ui/home/home_drawer_icon.dart';
import 'package:customer/ui/legal/legal_page.dart';
import 'package:customer/ui/notification/notification_list.dart';
import 'package:customer/ui/payment/payment_screen.dart';
import 'package:customer/ui/profile/profile_page.dart';
import 'package:customer/ui/referral/referral_screen.dart';
import 'package:customer/ui/tracker/view_tracker_page.dart';
import 'package:customer/ui/trip/mytrip_page.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/caller_layout.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'drawer_menu_item_construction.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<HomeBloc>(create: (_) => HomeBloc()),
    ], child: MyHome());
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends BasePageWidgetState<MyHome, HomeBloc> {
  var isTransitionHappened = false;
  var isDialogShowing = FlagWrapper(false);
  final List<String> bottomNavigationTitles = [
    "create_trip",
    "my_trip",
    "ntf",
  ];
  DateTime currentBackPressTime;
  OverlayEntry myTripOverlay;
  //onWillPop detect device backbutton and appbar backbutton
  @override
  onWillPop() async {
    print("willpop ${bloc.homePageIndex} ");
    /*check whether existing page is drawer items page, so on backbutton pressed
    it will go back to home page*/
    if (bloc.homePageIndex > 2) {
      /*it will go to the home page page where it previously had,
      like if it is in notification page and go to referral page and pressed backbutton
       it will go to homepage with notification menu selected
       */
      bloc.onBottomNavigationItemTapped(bloc.bottomNavigationSelectedIndex);
      bloc.title = bottomNavigationTitles[bloc.homePageIndex];
      return false;
    } else if (Platform.isAndroid) {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        showSnackBar(scaffoldState.currentState, "Press again to exit app");
        return false;
      }
      return true;
    }
  }

  @override
  getAppbar() => shouldShowRootAppbar()
      ? AppBarWidget(
          title: translate(context, bloc.title),
          shouldShowBackButton: false,
          shouldShowDivider: false,
          leadingWidget: Builder(
              builder: (context) => getDrawerIcon(Scaffold.of(context))))
      : null;

  bool shouldShowRootAppbar() {
    //only for my trips and notification we will show HomePage own appbar
    var pageIndex = [1, 2];
    for (var index in pageIndex) {
      if (index == Provider.of<HomeBloc>(context).homePageIndex) return true;
    }
    return false;
  }

  @override
  getBottomNaviagtionBar() => _buildBottomNavigationBar();

  @override
  getNavigationDrawer() => _buildDrawer();

  @override
  getFloatingActionButton() => CallerWidget();

  Widget getOverlayWidget() {
    return Positioned(
      bottom: 10,
      child: Stack(
        children: <Widget>[
          SvgPicture.asset('svg_img/trip_highlight_bg.svg'),
          Positioned(
              bottom: 25,
              left: 30,
              child: SvgPicture.asset('svg_img/ic_truck_highlight.svg'))
        ],
      ),
    );
  }

  Widget getBottomHighligtedWidget() {
    return Stack(
      children: <Widget>[
        SvgPicture.asset(
          'svg_img/trip_highlight_bg.svg',
          height: 35,
        ),
        Positioned(
            top: 10,
            left: 4,
            child: SvgPicture.asset(
              'svg_img/ic_truck_highlight.svg',
              height: 20,
            ))
      ],
    );
  }

  @override
  List<Widget> getPageWidget() {
    return [Consumer<HomeBloc>(builder: (context, bloc, _) => HomeBody())];
  }

  // when  home page view rendered fully we call profile info and notificationcount api
  @override
  onBuildCompleted() {
    bloc.getProfileInfo();
    bloc.getNotificationCount();
    appUpdateDialog(context, isDialogShowing, () => SystemNavigator.pop());
  }

  _buildBottomNavigationBar() {
    const navigationItemTextSize = 13.0;
    const navigationIconSize = 24.0;
    final iconScale = 0.3;
    return Stack(
      children: <Widget>[
        Consumer<HomeBloc>(
            builder: (consumerContext, bloc, _) => Theme(
                data: Theme.of(context).copyWith(
                    // sets the background color of the `BottomNavigationBar`
                    canvasColor: ColorResource.colorMarineBlue,
                    // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                    primaryColor: ColorResource.colorMarineBlue,
                    textTheme: Theme.of(context)
                        .textTheme
                        .copyWith(caption: new TextStyle(color: Colors.white))),
                child: BottomNavigationBar(
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: bloc.hasAnyTrip || bloc.homePageIndex != 1
                          ? Image.asset(
                              'images/ic_create_trip.png',
                              color: bloc.navIconColor(0),
                              width: responsiveSize(navigationIconSize + 5),
                              fit: BoxFit.fitWidth,
                            )
                          : getBottomHighligtedWidget(),
                      title: Text(
                        translate(context, 'create_trip'),
                        style: TextStyle(
                            fontSize:
                                responsiveTextSize(navigationItemTextSize)),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'images/ic_mytrips.png',
                        color: bloc.navIconColor(1),
                        width: responsiveSize(navigationIconSize),
                        fit: BoxFit.fitWidth,
                      ),
                      title: Text(
                        translate(context, 'my_trip'),
                        style: TextStyle(
                            fontSize:
                                responsiveTextSize(navigationItemTextSize)),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: Stack(
                        fit: StackFit.loose,
                        overflow: Overflow.visible,
                        children: <Widget>[
                          SvgPicture.asset(
                            'svg_img/ic_notification_show.svg',
                            color: bloc.navIconColor(2),
                            width: responsiveSize(navigationIconSize),
                            fit: BoxFit.fitWidth,
                          ),
                          Visibility(
                            // visible: bloc.notificationCount > 0,
                            child: Positioned(
                              right: -7,
                              top: -2,
                              child: Container(
                                padding: EdgeInsets.all(1),
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 15,
                                  minHeight: 15,
                                ),
                                child: Center(
                                  child: Text(
                                    localize('number_count',
                                        dynamicValue:
                                            bloc.notificationCount.toString()),
                                    style: TextStyle(
                                        color: ColorResource.colorMarineBlue,
                                        fontSize: responsiveTextSize(10),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      title: Text(
                        translate(context, 'ntf'),
                        style: TextStyle(
                            fontSize:
                                responsiveTextSize(navigationItemTextSize)),
                      ),
                    ),
                  ],
                  currentIndex: bloc.bottomNavigationSelectedIndex,
                  selectedItemColor: ColorResource.colorMariGold,
                  onTap: _validateApproval,
                  type: BottomNavigationBarType.fixed,
                ))),
        // Container(color:Colors.white,height:kBottomNavigationBarHeight+40,child: getOverlayWidget())
      ],
    );
  }

  _validateApproval(itemIndex) {
    if (itemIndex == 0) {
      if (!Prefs.getBoolean(Prefs.IS_APPROVED_USER, defaultValue: true))
        showThreeLabelSpannableDialog(context, "txt_apl_msg");
      else
        _handleBottomMenuOnTap(itemIndex);
    } else
      _handleBottomMenuOnTap(itemIndex);
  }

  _handleBottomMenuOnTap(itemIndex) {
    bloc.onBottomNavigationItemTapped(itemIndex);
    bloc.title = bottomNavigationTitles[itemIndex];
  }

  Widget _buildDrawer() {
    var drawerWidth = MediaQuery.of(context).size.width * 0.80;
    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Consumer<HomeBloc>(
              builder: (context, bloc, _) => Container(
                width: drawerWidth,
                height: drawerWidth / 1.9,
                child: DrawerHeader(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(children: [
                      getCircleImage(
                          radius: responsiveSize(30),
                          url: bloc.profileInfo?.pic),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          //  bloc.homePageIndex = 3;
                          // bloc.title = translate(context, 'my_profile');
                          try {
                            // Navigator.pop(context);
                          } catch (ex) {
                            print(ex.toString());
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: responsiveSize(10.0)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                    '${bloc.isDistributor() ? bloc.profileInfo.distributorCompanyName ?? '' : bloc.profileInfo.name ?? ''}',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: responsiveTextSize(14),
                                        color: ColorResource.colorWhite),
                                    textAlign: TextAlign.left),
                                Container(
                                  child: AutoSizeText(
                                    '${bloc.isDistributor() ? 'Distributor' : 'Customer'} (${bloc?.appStatus})'
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: responsiveTextSize(14),
                                        color: ColorResource.colorWhite),
                                  ),
                                )
                              ]),
                        ),
                      ))
                    ]),
                  ),
                  decoration: BoxDecoration(
                      color: ColorResource.colorMarineBlue,
                      image: DecorationImage(
                          image: AssetImage(
                            'images/account_switcher.webp',
                          ),
                          fit: BoxFit.fill)),
                ),
              ),
            ),
            ...HomeDrawerMenu(context).constructMenu(bloc)
          ],
        ),
      ),
    );
  }

  @override
  didChangeLifeCycle(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed ){
      bloc.getNotificationCount();
      if(!isDialogShowing.isDialogShowing) appUpdateDialog(context, isDialogShowing, () => SystemNavigator.pop());
    }
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.only(left:DimensionResource.leftMargin,right: DimensionResource.rightMargin),
        color: ColorResource.colorWhite,
        child: getBodyWidget(
            Provider.of<HomeBloc>(context, listen: true).homePageIndex));
  }
}

Widget getBodyWidget(int position) {
  FireBaseAnalytics().screenViewEvent(ScreenView.DRAWER_SCREENS[position]);
  switch (position) {
    case 0:
      return CreateTripPageContainer();
    case 1:
      return MyTripStatusTypeScreen();
    case 2:
      return NotificationScreen();
    case 3:
      return ProfilePageContainer();
    case 4:
      return MyDashboardScreen();
    case 5:
      return ReferralScreen();
    case 6:
      return PaymentScreen();
    case 7:
      return LegalScreen();
    case 8:
      return TrackerScreen();
  }
}

class FlagWrapper {
  bool isDialogShowing = false;

  FlagWrapper(this.isDialogShowing);
}
