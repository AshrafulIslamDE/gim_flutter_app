import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/networking/background_process.dart';
import 'package:customer/ui/home/homepage.dart';
import 'package:customer/ui/password/change_password_page.dart';
import 'package:customer/ui/password/forgot_password_page.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/editfield.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/mandatory_field_note_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/firebase_notifications.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/utils/validationUtils.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen_bloc.dart';

var mainContext;

class LoginScreenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    mainContext = context;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginScreenBloc>(
            create: (_) => LoginScreenBloc()),
      ],
      child: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends BasePageWidgetState<LoginScreen,LoginScreenBloc> {
  final _formKey = GlobalKey<FormState>();
  final mobileNumberController = TextEditingController();
  final passwordController = TextEditingController();
   @override
  List<Widget> getPageWidget() {
    return [
      Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppBarWidget(
            title: translate(context, "login"),
            backgroundColor: ColorResource.colorTransparent,
            appbarContentColor: ColorResource.colorWhite,
            shouldShowDivider: false,
          ),
          SizedBox(
              height: responsiveSize(20.0)
          ),
          Text(
            translate(context, "login_description"),
            style: TextStyle(color: Colors.white,
            fontSize: responsiveDefaultTextSize()),
            textAlign: TextAlign.center,

          ),
          Padding(
            padding:  EdgeInsets.only(left: responsiveSize(20.0),
                top: responsiveSize(20.0), right: responsiveSize(20.0)),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextEditText(
                      labelText: translate(context, 'mobile_number_'),
                      enableBorderColor: ColorResource.colorWhite,
                      textColor: ColorResource.colorWhite,
                      labelTextColor: Colors.white,
                      focusedBorderColor: ColorResource.colorWhite,
                      keyboardType: TextInputType.number,
                      maxlength: 11,
                      behaveNormal: true,
                      textEditingController: mobileNumberController,
                      validationMessageRegexPair: {
                        NOT_EMPTY_REGEX: translate(context, 'empty_error_msg'),
                        MOBILE_NUMBER_REGEX_0: translate(context, 'invalid_mobile_number')
                      },
                      onChanged: (text) => bloc.mobileNumber = text),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextEditText(
                    labelText: translate(context, 'password_'),
                    obscured: true,
                    enableBorderColor: ColorResource.colorWhite,
                    textEditingController: passwordController,
                    labelTextColor: Colors.white,
                    textColor: ColorResource.colorWhite,
                    focusedBorderColor: ColorResource.colorWhite,
                    validationMessageRegexPair: {
                      NOT_EMPTY_REGEX: translate(context, 'empty_error_msg')
                    },
                    onChanged: (text) => bloc.password = text,
                    behaveNormal: true,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: Text(translate(context, 'ttl_fgt_pwd')+"?",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: responsiveDefaultTextSize(),
                            color: ColorResource.colorWhite),
                      ),
                      onTap: () {
                        navigateNextScreen(context, ForgotPasswordScreen());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Align(child: Consumer<LoginScreenBloc>(builder: (context,bloc,_)=>bloc.isLoading? CircularProgressIndicator(backgroundColor: ColorResource.colorMariGold,):Container()),alignment: Alignment.center,),

          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MandatoryFieldNote(
                    textColor: Colors.white,
                  ),
                  FilledColorButton(
                      textColor: ColorResource.colorMarineBlue,
                      buttonText: translate(context, 'login'),
                      backGroundColor: ColorResource.colorMariGold,
                      onPressed: () => onLoginButtonPressed()),
                ],
              )),
        ],
      ),
    ];
  }

  @override
  scaffoldBackgroundColor()=>ColorResource.colorMarineBlue;
 @override
  getContainerPadding()=>EdgeInsets.all(10.0);

  @override
  getContainerDecoration() {
    return BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('images/bg_signin.webp'),
        ));
  }


  onLoginButtonPressed() async {
    hideSoftKeyboard(context);
    if (_formKey.currentState.validate()) {
      submitDialog(context, dismissible: false);
      var response =
      await Provider.of<LoginScreenBloc>(context, listen: false).signIn();
      Navigator.pop(context);
      manipulateResponse(response);
    } else {
      _formKey.currentState.reset();
    }
  }

  manipulateResponse(ApiResponse response) {
    switch (response.status) {
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        navigate(response);
        break;
      case Status.ERROR:
        showSnackBar(scaffoldState.currentState, response.message);
        break;
    }
  }

  navigate(response) async {
    if (response.data['passwordChangeNeeded']) {
      final result = await navigateNextScreen(context, ChangePasswordScreen());
      if (!(result is ApiResponse) && (result.status != Status.COMPLETED || !result.data['status']))
        return;
    }
    await Prefs.setBoolean(Prefs.IS_LOGGED_IN, true);
    FireBaseNotifications().setUpFireBase();
    FireBaseAnalytics().logEvent(AnalyticsEvents.SIGN_IN,AnalyticsParams.USER_ROLE);
    navigateNextScreen(context, Home(),shouldFinishPreviousPages: true);
  }
}
