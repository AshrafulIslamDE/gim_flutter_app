import 'package:customer/splash/navigation_splash_screen.dart';
import 'package:customer/splash/splash.dart';
import 'package:customer/ui/bid/view_bid_list.dart';
import 'package:customer/ui/home/homepage.dart';
import 'package:customer/ui/onboard/onboard_screen.dart';
import 'package:customer/ui/review/add_rating_page.dart';
import 'package:customer/ui/trip/booking_detail/booking_detail_page.dart';
import 'package:customer/ui/trip/trip_detail/trip_detail_page.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';

class Router {
  /* Default route has been used for auth error*/
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.addARatingRoute:
        return new MaterialPageRoute(
            builder: (_) => AddARatingScreen(settings.arguments),
            settings: RouteSettings(name: ScreenView.PARTNER_RATING));
      case RouteConstants.tripDetailRoute:
        return new MaterialPageRoute(
            builder: (_) => TripDetailPageContainer(tripId: settings.arguments),
            settings: RouteSettings(name: ScreenView.TRIP_DETAILS));
      case RouteConstants.viewBidListRoute:
        return new MaterialPageRoute(
            builder: (_) => ViewBidListScreen(settings.arguments),
            settings: RouteSettings(name: ScreenView.BID_LISTING));
      case RouteConstants.bookingDetailRoute:
        Map map = (settings.arguments);
        return new MaterialPageRoute(
            builder: (_) => BookingDetailContainer(
                tripId: map.keys.elementAt(0),
                tripStatus: map.values.elementAt(0)),
            settings: RouteSettings(name: ScreenView.BOOKED_TRIP_DETAILS));
      case RouteConstants.authErrorRoute:
        return MaterialPageRoute(
            builder: (_) => OnboardScreen(),
            settings: RouteSettings(name: ScreenView.ON_BOARD));
      case RouteConstants.homeRoute:
        return MaterialPageRoute(
            builder: (_) => NavigationSplashScreen(),
            settings: RouteSettings(name: ScreenView.SPLASH));
    }
  }
}
