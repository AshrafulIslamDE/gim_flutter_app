import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/auth/login_response.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/password/bloc/forgot_password_bloc.dart';
import 'package:customer/ui/password/reset_password_otp_verification_page.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/editfield.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ForgotPasswordBloc>(
            create: (_) => ForgotPasswordBloc()),
      ],
      child: ForgotPasswordPage(),
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => hideSoftKeyboard(context),
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: Consumer<ForgotPasswordBloc>(
              builder: (context, bloc, _) => Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.all(10.0),
                    // color: ColorResource.colorMarineBlue,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/bg_signin.webp'),
                    )),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                          AppBarWidget(
                            title: translate(context, 'ttl_fgt_pwd'),
                            shouldShowBackButton: true,
                            shouldShowDivider: false,
                            backgroundColor: ColorResource.colorTransparent,
                            appbarContentColor: ColorResource.colorWhite,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left:30.0,
                                top: 20.0, right: 30.0),
                            child: Text(
                              translate(context, 'fpl_emn'),
                              style: TextStyle(color: Colors.white,
                                  fontSize: responsiveDefaultTextSize()),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextEditText(
                              hintText: translate(context, 'hint_pem'),
                              labelText:
                                  translate(context, 'lbl_contact') + '*',
                              enableBorderColor: ColorResource.colorWhite,
                              textColor: ColorResource.colorWhite,
                              labelTextColor: Colors.white,
                              focusedBorderColor: ColorResource.colorWhite,
                              keyboardType: TextInputType.number,
                              maxlength: 11,
                              textEditingController: mobileNumberController,
                              onChanged: bloc.validate,
                              hintTextColor: ColorResource.grey_white,
                              labelTextBgColor: ColorResource.colorMarineBlue,
                            ),
                          ),
                        ])),
                  ),
                  Align(
                      child: Container(
                        padding:
                            EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 60.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            FilledColorButton(
                                buttonText:
                                    translate(context, "txt_send_otp"),
                                textColor: bloc.buttonTextColor,
                                backGroundColor: bloc.buttonBgColor,
                                onPressed: () async {
                                  {
                                    if (bloc.isValidated) {
                                      submitDialog(context,
                                          dismissible: false);
                                      ApiResponse response =
                                          await bloc.requestOtpApp(
                                              mobNum: mobileNumberController
                                                  .text
                                                  .toString());
                                      manipulateResponse(bloc, response);
                                    }
                                  }
                                })
                          ],
                        ),
                      ),
                      alignment: Alignment.bottomCenter),
                ],
              ),
            )));
  }

  manipulateResponse(bloc, ApiResponse apiRes) {
    Navigator.pop(context);
    if (bloc.isApiError(apiRes)) {
      showToast(apiRes.message ?? translate(context, 'something_went_wrong'));
      return;
    }
    var verificationResponse = LoginResponse.fromJson(apiRes.data);
    navigateNextScreen(
        context,
        ResetPasswordOtpVerificationScreen(
            mobileNumberController.text.toString(),
            verificationResponse.isEnterpriseUser()));
  }
}
