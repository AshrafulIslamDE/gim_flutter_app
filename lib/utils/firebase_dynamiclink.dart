import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/utils/prefs.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class FireBaseDynamicLink {
  retrieveDynamicLink() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;
      if (deepLink != null && deepLink.hasFragment) {
        String param = deepLink.fragment.substring(
            (deepLink.fragment.lastIndexOf('/') + 1), deepLink.fragment.length);
        Prefs.setString(Prefs.INVITE_REFERRAL_CODE, param);
        print(param);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
    Future.delayed(Duration(seconds: 2)).asStream().listen((_) async {
      final PendingDynamicLinkData data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri deepLink = data?.link;
      if (deepLink != null && deepLink.hasFragment) {
        String param = deepLink.fragment.substring(
            (deepLink.fragment.lastIndexOf('/') + 1), deepLink.fragment.length);
        Prefs.setString(Prefs.INVITE_REFERRAL_CODE, param);
        print(param);
      }
    });
  }

  static buildShareLink(String inviteSuffix, String appPackage,
      {uriPrefix}) async {
    var shareUrl =
        FlavorConfig.instance.values.SHARE_URL + "/#/invite/" + inviteSuffix;
    var dynamicParameter = DynamicLinkParameters(
      uriPrefix: uriPrefix,
      link: Uri.parse(shareUrl),
      androidParameters: AndroidParameters(
        packageName: appPackage,
        //  minimumVersion: 125,
      ),
      iosParameters: IosParameters(
        bundleId: appPackage,
        appStoreId: '1498060269',
      ),
      googleAnalyticsParameters: GoogleAnalyticsParameters(
        campaign: 'refferal_campaign',
        medium: 'mobile_app',
        source: 'customer_app',
      ),
      /*itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
       providerToken: '123456',
       campaignToken: 'example-promo',
     ),*/
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'জিম - প্রতি ট্রিপেই বোনাস',
        description:
            'যে কোন ট্রাক মালিককে ট্রিপ নেয়ার জন্য রেফার করুন আর প্রতি ট্রিপে পেতে থাকুন বোনাস।',
        imageUrl: Uri.parse(
            'https://s3-ap-southeast-1.amazonaws.com/ejogajog-prod/link_image_bangla.jpg'),
      ),
    );
    final ShortDynamicLink shortDynamicLink =
        await dynamicParameter.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;
    print(shortUrl.toString());
    return shortUrl.toString();
  }
}
