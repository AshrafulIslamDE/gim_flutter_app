import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/auth/login_response.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/editfield.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:customer/features/registration/national_id_screen.dart';
import 'package:customer/features/registration/personal_info_bloc.dart';
import 'package:customer/features/registration/stepper_widget.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/utils/validationUtils.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalInfoScreen extends StatelessWidget {
  LoginResponse verificationResponse;
  PersonalInfoScreen(this.verificationResponse);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider<PersonalInfoBloc>(
        create: (context) => PersonalInfoBloc(),
        child: PersonalInfo(verificationResponse));
  }
}

class PersonalInfo extends StatefulWidget {
  LoginResponse verificationResponse;
  PersonalInfo(this.verificationResponse);
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final Trace trace = FirebasePerformance.instance.newTrace('sign_up_otp_verification');
  var passwordEditController = TextEditingController();
  var emailEditController = TextEditingController();
  var referralEditController = TextEditingController();
  var formState = GlobalKey<FormState>();
  var scaffoldState = GlobalKey<ScaffoldState>();
  var paddingValue=const EdgeInsets.only(left: 20,right: 20);
  PersonalInfoBloc bloc;

  @override
  void initState() {
    trace.start();
    bloc=Provider.of<PersonalInfoBloc>(context,listen: false);
    referralEditController.text = Prefs.getString(Prefs.INVITE_REFERRAL_CODE);
    super.initState();
  }

  verifyReferral()async{
    submitDialog(context);
    ApiResponse response=await bloc.verifyReferralNumber();
    Navigator.pop(context);
    if(bloc.isApiError(response))
    showAlertWithDefaultAction(context,content: bloc.referralCodeVerificationMsg,positiveBtnTxt: localize('txt_ok'),);
    hideSoftKeyboard(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyWidget = Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorResource.colorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:paddingValue,
            child: Text(
              translate(context, 'step_2_personal_information'),
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: ColorResource.colorMarineBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: responsiveTextSize(18)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: formState,
                child: Padding(
                  padding:paddingValue,
                  child: Column(
                    children: <Widget>[
                      TextEditText(
                        labelText: translate(context, 'create_password').toUpperCase(),
                        textEditingController: passwordEditController,
                        validationMessageRegexPair: {
                          PASSWORD_REGEX: translate(context, 'txt_pwd_msg')
                        },
                        hintText: translate(context, 'hnt_msc'),
                        obscured: true,
                        onChanged: (text)=>bloc.password=text,

                      ),
                      TextEditText(
                        labelText: translate(context, 'txt_ur_mail').toUpperCase(),
                        textEditingController: emailEditController,
                        isOptionalFieldWithValidation: true,
                        validationMessageRegexPair: {
                          EMAIL_REGEX: EMAIL_MSG
                        },
                        hintText: translate(context, 'txt_hint_pem'),
                        onChanged: (text)=>bloc.email=text,
                      ),
                      TextEditText(
                        labelText: translate(context, 'referral_mobile_number').toUpperCase(),
                        textEditingController: referralEditController,
                        isOptionalFieldWithValidation: true,
                        maxlength: 11,
                        keyboardType: TextInputType.number,
                        validationMessageRegexPair: {
                          MOBILE_NUMBER_REGEX: MOBILE_NUMBER_MSG
                        },
                        hintText: '01xxxxxxxxx',
                        onChanged: (text){
                          bloc.referralNumber=text;
                          if(isValidField(MOBILE_NUMBER_REGEX, bloc.referralNumber))
                            verifyReferral();
                        },

                      ),
                      SizedBox(height: 10.0,),
                      Text(translate(context, 'referral_insertion_msg'),textAlign:TextAlign.start,
                        style: TextStyle(color: ColorResource.colorMarineBlue,fontSize: responsiveTextSize(13.0)),)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:paddingValue,
            child: FilledColorButton(
              buttonText: translate(context, 'txt_next'),
              fontWeight: FontWeight.normal,
              onPressed: ()async {
                if (formState.currentState.validate()) {
                  bloc.verifyReferralNumber();
                  if(bloc.verifyStatus) {
                    trace.stop();
                    FireBaseAnalytics().logEvent(AnalyticsEvents.SIGN_UP_PERSONAL_INFO, null);
                    navigateNextScreen(
                        context, NationalIdScreen(widget.verificationResponse));
                  }
                  else
                    showAlertWithDefaultAction(context,content: bloc.referralCodeVerificationMsg,positiveBtnTxt: localize('txt_ok'),);
                } else {
                  formState.currentState.reset();
                }
              },
            ),
          ),
          getStepperWidget(2)
        ],
      ),
    );
    return GestureDetector(
      onTap: ()=>hideSoftKeyboard(context),
      child: Scaffold(
        key: scaffoldState,
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget(
          title: translate(context, 'create_my_account'),
          shouldShowDivider: false,
        ),
        body: bodyWidget,
      ),
    );
  }
}
