import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/features/registration/otp_verification_bloc.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/password/dob_nid_page.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

import 'new_password_page.dart';

class ResetPasswordOtpVerificationScreen extends StatelessWidget {
  final String mobileNumber;
  final bool isEnterpriseUser;

  ResetPasswordOtpVerificationScreen(this.mobileNumber, this.isEnterpriseUser);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OtpVerificationBloc>(
      create: (_) => OtpVerificationBloc(),
      child: OtpVerificationPage(mobileNumber, isEnterpriseUser),
    );
  }
}

class OtpVerificationPage extends StatefulWidget {
  final String mobileNumber;
  final bool isEnterpriseUser;

  OtpVerificationPage(this.mobileNumber, this.isEnterpriseUser);

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var pinWidth = screenWidth / 4 - 22;
    var bloc = Provider.of<OtpVerificationBloc>(context, listen: false);
    TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () async {
        submitDialog(context);
        controller.text = "";
        ApiResponse apiResponse =
            await bloc.resendOtp(mobile: widget.mobileNumber, signUp: false);
        Navigator.pop(context);
        showToast(apiResponse.message);
      };

    return SafeArea(
        child: GestureDetector(
            onTap: () => hideSoftKeyboard(context),
            child: Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: false,
                body: Consumer<OtpVerificationBloc>(
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
                                title: translate(context, 'ovp_evc'),
                                shouldShowBackButton: true,
                                backgroundColor: ColorResource.colorTransparent,
                                appbarContentColor: ColorResource.colorWhite,
                                shouldShowDivider: false,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: translate(context, 'ovp_vcs') +
                                          ' \n' +
                                          translate(context, 'ovp_cht'),
                                      style: TextStyle(
                                          color: ColorResource.colorWhite,
                                          fontSize: 15,
                                          fontFamily: 'roboto')),
                                  TextSpan(
                                      text: translate(context, 'ovp_rvc'),
                                      recognizer: tapGestureRecognizer,
                                      style: TextStyle(
                                          color: ColorResource.colorMariGold,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16))
                                ]),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Text(
                                translate(context, 'ovp_pvc').toUpperCase(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: ColorResource.colorWhite,
                                    fontSize: 13,
                                    fontFamily: 'roboto'),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              PinCodeTextField(
                                wrapAlignment: WrapAlignment.center,
                                pinBoxWidth: pinWidth,
                                autofocus: true,
                                maxLength: 4,
                                controller: controller,
                                isCupertino: false,
                                pinTextStyle: TextStyle(
                                    fontSize: 40,
                                    color: ColorResource.colorWhite),
                                hasError: false,
                                highlight: true,
                                highlightColor: Colors.blue,
                                defaultBorderColor: ColorResource.divider_color,
                                hasTextBorderColor: ColorResource.divider_color,
                                onDone: (text) {
                                  bloc.hasOTPEntered = true;
                                  hideSoftKeyboard(context);
                                },
                                onTextChanged: (text) {
                                  bloc.otp = text;
                                },
                              ),
                            ])),
                      ),
                      Align(
                          child: Container(
                            padding:
                                EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                FilledColorButton(
                                    buttonText: localize('txt_next'),
                                    textColor: bloc.buttonTextColor,
                                    backGroundColor:
                                        ColorResource.colorMariGold,
                                    onPressed: () => {_verifyOtp(bloc)})
                              ],
                            ),
                          ),
                          alignment: Alignment.bottomCenter),
                    ],
                  ),
                ))));
  }

  _verifyOtp(OtpVerificationBloc bloc) async {
    if (bloc.hasOTPEntered) {
      submitDialog(context, dismissible: false);
      ApiResponse response =
          await bloc.verifyOtpApp(mobile: widget.mobileNumber);
      Navigator.pop(context);
      if (bloc.isApiError(response)) {
        controller.text = "";
        showSnackBar(_scaffoldKey.currentState,
            response.message ?? translate(context, 'something_went_wrong'));
        return;
      }
      navigateNextScreen(
          context,
          widget.isEnterpriseUser != null && !widget.isEnterpriseUser
              ? DobNidScreen(userId: response.data)
              : NewPasswordScreen(
                  userId: response.data,
                ));
    }
  }
}
