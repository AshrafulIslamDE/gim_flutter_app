import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/data/repository/referral_repository.dart';
import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/model/referral/referral_invitation.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/networking/network_common.dart';
import 'package:customer/utils/firebase_dynamiclink.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';

class ReferralInvitationBloc extends BaseBloc{
 var mobileNumber="";
 bool inviteAsCustomer=true;
 var partnerUrl=FlavorConfig.instance.values.PARTNER_INVITE_URL;
 var customerUrl=FlavorConfig.instance.values.CUSTOMER_INVITE_URL;

 buildShortLink()async{
    isLoading=true;
    ApiResponse response;
    try {
      var offline=await isOffline();
      if(offline)
      showCustomSnackbar(localize('network_error_message'),bgColor: ColorResource.pink_red);
      var shortUrl = await FireBaseDynamicLink.buildShareLink(
          Prefs.getStringWithDefaultValue(Prefs.PREF_USER_MOBILE),
          inviteAsCustomer ? FlavorConfig.instance.values.APP_PACKAGE : FlavorConfig.instance.values.PARTNER_APP_PACKAGE,
          uriPrefix: inviteAsCustomer ? customerUrl : partnerUrl);
      print(shortUrl);
       response = await ReferralRepository.sendReferralInvitation(
          ReferralInvitationRequest(
              mobileNumber, inviteAsCustomer ? 5 : 3, shortUrl));
      checkResponse(response);
    }catch(ex){
      print(ex.toString());
    }
    isLoading=false;
    return response;
 }
}
