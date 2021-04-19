import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/ui/widget/my_app_page.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  FlavorConfig(
      flavor: Flavor.DEV,
      values: FlavorValues(
          baseUrl: "https://dev2.gim.com.bd",
          API_URL: 'https://dev2.gim.com.bd/ejogajog/api',
          SHARE_URL: "https://dev2.gim.com.bd/ejoga",
          TERMS: '/english/terms-of-use',
          TERMS_BANGLA: '/bangla/terms-of-use',
          PRIVACY: '/english/privacy-policy',
          PRIVACY_BANGLA: '/bangla/privacy-policy',
          HELP_CENTER: '/english/help-desk',
          HELP_CENTER_BANGLA: '/bangla/help-desk',
          ABOUT_US: '/english/about-us',
          ABOUT_US_BANGLA: '/bangla/about-us',
      ));
  Provider.debugCheckInvalidValueType = null;
  await initializeFirebase();
  runApp(MyApplication());
}