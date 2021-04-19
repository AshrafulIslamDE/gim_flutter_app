import 'package:customer/ui/home/homepage.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:flutter/cupertino.dart';

class NavigationSplashScreen extends StatefulWidget{
  @override
  _NavigationSplashScreenState createState() => _NavigationSplashScreenState();
}

class _NavigationSplashScreenState extends State<NavigationSplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      navigateNextScreen(context, Home(),shouldReplaceCurrentPage: true);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}