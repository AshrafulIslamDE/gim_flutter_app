import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_app.dart';
import 'flavor_config.dart';

Future<void> main() async {
  FlavorConfig(
      flavor: Flavor.QA,
      values: FlavorValues(
          baseUrl: "https://test.gim.com.bd",
          API_URL: 'https://test.gim.com.bd/ejogajog/api',
          SHARE_URL: "https://test.gim.com.bd/application",
          TERMS: '/english/terms-of-use',
          TERMS_BANGLA: '/bangla/terms-of-use',
          PRIVACY: '/english/privacy-policy',
          PRIVACY_BANGLA: '/bangla/privacy-policy',
          HELP_CENTER: '/english/help-desk',
          HELP_CENTER_BANGLA: '/bangla/help-desk',
          ABOUT_US: '/english/about-us',
          ABOUT_US_BANGLA: '/bangla/about-us',
          GOOGLE_API_KEY: AppConstants.gDebugApiKey,
          CUSTOMER_INVITE_URL: 'https://mobiledev.gim.com.bd/customer',
          PARTNER_INVITE_URL: 'https://mobiledev.gim.com.bd/partner'));
  Provider.debugCheckInvalidValueType = null;
  await initializeFirebase();
  runApp(MyApp());
}
