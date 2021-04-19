
import 'package:customer/bloc/referral/referral_invitation_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/editfield.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:customer/utils/validationUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReferralInvitationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ReferralInvitationBloc>(create: (context)=>ReferralInvitationBloc(),)
      ],
      child: ReferralInvitationPage(),
    );
  }

}

class ReferralInvitationPage extends StatefulWidget{
  @override
  _ReferralInvitationPageState createState() => _ReferralInvitationPageState();
}

class _ReferralInvitationPageState extends State<ReferralInvitationPage> {
  ReferralInvitationBloc bloc;
  final mobileTextEditController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    bloc=Provider.of<ReferralInvitationBloc>(context,listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>hideSoftKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldkey,
        backgroundColor: Colors.white,
        appBar: AppBarWidget(title: translate(context, 'invitation'),),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                padding: DimensionResource.screenPadding,
                child: Column(
                  children: <Widget>[
                    Text(translate(context, 'referral_invitation_msg'),textAlign: TextAlign.center,
                      style: TextStyle(color: ColorResource.greyish_brown,fontSize: responsiveDefaultTextSize()),),
                    SizedBox(height: 5,),
                    Form(
                        key: _formKey,
                      child: TextEditText(labelText: translate(context, 'lbl_contact'), keyboardType: TextInputType.number,maxlength: 11,
                          textEditingController: mobileTextEditController,
                          validationMessageRegexPair:{MOBILE_NUMBER_REGEX:localize('invalid_entered_mobile_number')} ,
                          onChanged:(text)=>bloc.mobileNumber=text),
                    )   ,
                    Expanded(child: Container(),),
                    FilledColorButton(buttonText: translate(context, 'invite_as_customer'),onPressed:()=>invite() ,fontWeight: FontWeight.normal,),
                    FilledColorButton(buttonText: translate(context, 'invite_as_partner'),onPressed:()=>invite(inviteAsCustomer: false) ,fontWeight: FontWeight.normal,)
                  ],
                ),
              ),
              showLoader<ReferralInvitationBloc>(bloc)
            ],
          ),
        ),
      ),
    );
  }
  invite({inviteAsCustomer=true}) async {
    hideSoftKeyboard(context);
   // showSuccessDialog("success");
    if (_formKey.currentState.validate()) {
        bloc.inviteAsCustomer=inviteAsCustomer;
      ApiResponse response=  await bloc.buildShortLink();
      if(response?.status==Status.COMPLETED) {
        FireBaseAnalytics().logEvent(AnalyticsEvents.EVENT_REFERRAL_INVITE,null);
        showSuccessDialog(response?.message);
      }
      else {
        showSnackBar(_scaffoldkey.currentState, response?.message);
      }
    }else{
      _formKey.currentState.reset();
    }
  }
  showSuccessDialog(content){
    showAlertWithDefaultAction(context,positiveBtnTxt: translate(context, 'ok'),
        title: translate(context, 'success'),content:content,callback: ()=>Navigator.pop(context,true) );
  }
}
