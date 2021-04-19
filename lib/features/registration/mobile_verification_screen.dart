import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/editfield.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/mandatory_field_note_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:customer/features/registration/stepper_widget.dart';
import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/webview/web_redirection_screen.dart';
import 'package:customer/utils/validationUtils.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mobile_verification_bloc.dart';
import 'model/otp_generation_response.dart';
import 'model/sign_up_request.dart';
import 'otp_verification_screen.dart';

class MobileVerificationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MobileVerificationBloc>(
      create: (context)=>MobileVerificationBloc(),
      child:MobileVerification() ,
    );
  }

}

class MobileVerification extends StatefulWidget{
  @override
  _MobileVerificationScreenState createState() => _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerification> {
  final Trace trace = FirebasePerformance.instance.newTrace
    ('sign_up_mob_verification');
  final mobileNumberController=TextEditingController();
  final formState=GlobalKey<FormState>();
  final scaffoldState=GlobalKey<ScaffoldState>();
  MobileVerificationBloc bloc;

  @override
  void initState() {
    trace.start();
    bloc=Provider.of<MobileVerificationBloc>(context,listen: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final termUseClickGetrure=TapGestureRecognizer()..onTap=(){navigateNextScreen(context, WebRedirectionScreen(title: translate(context, 'term_use'),webViewUrl: FlavorConfig.instance.values.TERMS,));};
    final privacyPolicyClickGetrure=TapGestureRecognizer()..onTap=(){navigateNextScreen(context, WebRedirectionScreen(title: localize('privacy_policy'),webViewUrl: FlavorConfig.instance.values.PRIVACY,));};
    var paddingValue=const EdgeInsets.only(left: 18,right: 18);

    return GestureDetector(
      onTap: ()=>hideSoftKeyboard(context),
      child: Scaffold(
        key: scaffoldState,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBarWidget(title:translate(context, 'create_my_account'),shouldShowDivider: false,),
        body: Container(
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: paddingValue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(translate(context, 'sign_up_description'),
                      textAlign: TextAlign.justify,style: TextStyle(color:ColorResource.greyish_brown,
                          fontSize: responsiveSize(15) ), ),

                    SizedBox(height: 40,),

                    Text(translate(context, 'step_1_mobile_verification'),
                      style: TextStyle(color:ColorResource.colorMarineBlue,fontWeight: FontWeight.bold,
                          fontSize: responsiveSize(18) ), ),

                    SizedBox(height: 15,),

                    Text(translate(context, 'mobile_description'), textAlign: TextAlign.justify,
                      style: TextStyle(color:ColorResource.greyish_brown,fontFamily: 'roboto',fontSize: responsiveSize(15) ), ),

                    SizedBox(height: 15,),


                    Form(
                      key: formState,
                      child: TextEditText(labelText: translate(context, 'mobile_number_').toUpperCase(),hintText: '01xxxxxxxxx',textEditingController: mobileNumberController,
                          onChanged: (text)=>bloc.mobileNumber=text,
                          validationMessageRegexPair: {MOBILE_NUMBER_REGEX:localize('invalid_entered_mobile_number')},keyboardType: TextInputType.number,maxlength: 11),
                    ),

                    SizedBox(height: 15,),

                    Row(children: <Widget>[
                      Transform.scale(
                        scale: responsiveSize(1.0),
                        child: Checkbox(value: bloc.isTermConditionAccepted,onChanged: (value)=>bloc.isTermConditionAccepted=value,
                          checkColor: ColorResource.colorWhite,activeColor: ColorResource.colorMarineBlue,
                        ),
                      ),
          RichText(
                                      text: TextSpan(
                                        style: TextStyle(color: ColorResource.greyish_brown,fontSize: 15,),
                                        children:[
                                      TextSpan(text: localize('i_accept')),
                                    TextSpan(text:localize('term_yes'),style: TextStyle(color: ColorResource.colorMarineBlue,fontWeight:FontWeight.bold,decoration: TextDecoration.underline),
                                        recognizer: termUseClickGetrure),
                                    TextSpan(text: localize('and')+'\n'),
                                    TextSpan(text:localize('term_privacy_yes'),style: TextStyle(color: ColorResource.colorMarineBlue,fontWeight:FontWeight.bold,decoration: TextDecoration.underline),
                                        recognizer: privacyPolicyClickGetrure),
                                    TextSpan(text:'*',style: TextStyle(color: Colors.red)),
                                    TextSpan(text: localize('ekmot')),

                            ]
                        ),
                      )
                    ],),

                  ],
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    MandatoryFieldNote(),
                    FilledColorButton(isFullwidth: true,horizonatalMargin: 18.0,
                      isFilled: true,buttonText: translate(context, 'send_verification_sms'),
                      fontWeight: FontWeight.normal,
                      onPressed:Provider.of<MobileVerificationBloc> (context).shouldActivateButton()? ()async{
                      if(formState.currentState.validate()) {
                        if(bloc.isTermConditionAccepted) {
                          submitDialog(context);
                          var response = await bloc.verifyMobileNumber(
                              mobileNumberController.text);
                          Navigator.pop(context);
                          onMobileVerification(response);
                        }else
                          showSnackBar(scaffoldState.currentState,'Please accept term and condition');
                      }
                      else
                        formState.currentState.reset();
                     // Provider.of<CustomerRegistrationBloc>(context,listen: false).registrationStep=1;
                      }:null,

                    ),
                    getStepperWidget(1),
                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
  onMobileVerification(ApiResponse response){
    if(!bloc.isApiError(response)){
       showToast(response.message);
       RegistrationSingleton.instance.request.mobileNumber=mobileNumberController.text;
       var otpgenerationResponse = OtpGenerationResponse.fromJson(response.data);
       navigateNextScreen(scaffoldState.currentContext,OtpVerificationScreen(otpGenerationResponse: otpgenerationResponse,));
       trace.stop();
       FireBaseAnalytics().logEvent(AnalyticsEvents.SIGN_UP_MOBILE_VERIFICATION, null);
    } else{
      showSnackBar(scaffoldState.currentState, response.message);
    }
  }
}