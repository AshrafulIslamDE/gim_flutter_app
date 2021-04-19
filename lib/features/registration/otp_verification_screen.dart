import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/features/registration/model/otp_generation_response.dart';
import 'package:customer/model/auth/login_response.dart';
import 'package:customer/ui/home/homepage.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:customer/features/registration/personal_info_screen.dart';
import 'package:customer/features/registration/stepper_widget.dart';
import 'package:customer/networking/api_response.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

import 'otp_verification_bloc.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpGenerationResponse otpGenerationResponse;
  OtpVerificationScreen({this.otpGenerationResponse});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OtpVerificationBloc>(
      create: (_) => OtpVerificationBloc(),
      child: OtpVerificationPage(otpGenerationResponse: otpGenerationResponse,),
    );
  }
}

class OtpVerificationPage extends StatefulWidget {
  OtpGenerationResponse otpGenerationResponse;
  OtpVerificationPage({this.otpGenerationResponse});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OtpVerificationPage> {
  final Trace trace = FirebasePerformance.instance.newTrace
    ('sign_up_otp_verification');
  TextEditingController controller = TextEditingController();
  var hasMultipleRole=false;
  @override
  void initState() {
    trace.start();
    hasMultipleRole= widget.otpGenerationResponse == null ? hasMultipleRole :
    widget.otpGenerationResponse.twoStep==null?hasMultipleRole:!widget.otpGenerationResponse.twoStep;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var pinWidth = screenWidth / 4 - 22;
    final bloc=Provider.of<OtpVerificationBloc>(context,listen: false);
    TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = ()async {
        submitDialog(context);
        controller.text="";
        ApiResponse apiResponse=await bloc.resendOtp();
        Navigator.pop(context);
        showToast( apiResponse.message);

      };
    return GestureDetector(
      onTap: ()=>hideSoftKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorResource.colorWhite,
        appBar: AppBarWidget(title: translate(context, 'create_my_account'),shouldShowDivider: false,),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(translate(context, 'step_1_mobile_verification'),
                  style: TextStyle(
                      color: ColorResource.colorMarineBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: responsiveTextSize(18)),
                ),
              ),

              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left:20.0,top:2,right: 20.0),
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: translate(context, 'ovp_vcs') +
                                          translate(context, 'ovp_cht'),
                                      style: TextStyle(
                                          color: ColorResource.greyish_brown,
                                          fontSize: responsiveTextSize(18),
                                          fontFamily: 'roboto')),
                                  TextSpan(
                                      text: translate(context, 'ovp_rvc'),
                                      recognizer: tapGestureRecognizer,
                                      style: TextStyle(
                                          color: ColorResource.colorMarineBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: responsiveTextSize(16)))
                                ]),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Text(
                                translate(context, 'ovp_pvc').toUpperCase(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: ColorResource.greyish_brown,
                                    fontSize: responsiveTextSize(15),
                                    fontFamily: 'roboto'),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                               PinCodeTextField(
                                  wrapAlignment: WrapAlignment.spaceBetween,
                                 pinBoxWidth: pinWidth,
                                 autofocus: true,
                                 pinBoxHeight: pinWidth,
                                 maxLength: 4,
                                 controller: controller,
                                 isCupertino: false,
                                 pinTextStyle: TextStyle(fontSize: responsiveTextSize(40),),
                                 hasError: false,
                                 highlight: true,
                                 highlightColor: Colors.blue,
                                 defaultBorderColor: ColorResource.divider_color,
                                 hasTextBorderColor: ColorResource.divider_color,

                                 onDone: (text) {
                                   bloc.hasOTPEntered=true;
                                   hideSoftKeyboard(context);
                                 },
                                 onTextChanged: (text) {
                                   bloc.otp=text;

                                 },
                               ),
                            ])),
                  )
              ),

              Padding(
                padding: const EdgeInsets.only(left:18.0,right: 18.0,bottom: 10),
                child: Consumer<OtpVerificationBloc>(
                  builder: (context,bloc,child)=> FilledColorButton(
                      buttonText: translate(context,!hasMultipleRole? 'txt_next':'finish_and_create_my_account'),
                      onPressed:!bloc.hasOTPEntered?null: ()=>onVerifyOtp(bloc)
                  ),
                ),
              ),
              getStepperWidget(1,totalStepNumber: hasMultipleRole?1:3)
            ],
          ),
        ),
      ),
    );
  }
  onVerifyOtp(OtpVerificationBloc bloc)async{
    submitDialog(context,dismissible: false);
    ApiResponse apiResponse = await bloc.verifyOtp();
    Navigator.pop(context);
    showToast(apiResponse.message);
    if (!bloc.isApiError(apiResponse)) {
      var verificationResponse=LoginResponse.fromJson(apiResponse.data);
      if(verificationResponse.twoStep!=null && verificationResponse.twoStep)
        {
          navigateNextScreen(context, PersonalInfoScreen(verificationResponse));
          trace.stop();
          FireBaseAnalytics().logEvent(AnalyticsEvents.SIGN_UP_OTP_VERIFICATION, null);
        }
      else{
        await bloc.saveUserInfo(verificationResponse);
        showSuccessDialog();
      }

    }
    else
      controller.text="";

  }
  showSuccessDialog(){
    showThreeLabelSpannableDialog(context, 'sign_up_msg',callback:()=>
      navigateNextScreen(context, Home(),shouldFinishPreviousPages: true)
    );
  }
}