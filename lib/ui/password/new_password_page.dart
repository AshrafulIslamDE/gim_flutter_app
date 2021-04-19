import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/onboard/onboard_screen.dart';
import 'package:customer/ui/password/bloc/forgot_password_bloc.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/editfield.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:customer/utils/validationUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatelessWidget {
  final int userId;

  NewPasswordScreen({this.userId});

@override
Widget build(BuildContext context) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<ForgotPasswordBloc>(
          create: (_) => ForgotPasswordBloc()),
    ],
    child: NewPasswordPage(userId: userId,),
  );
}}

class NewPasswordPage extends StatefulWidget {
  final int userId;
  NewPasswordPage({this.userId});
  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var passwordEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
            onTap: () => hideSoftKeyboard(context),
            child: Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: false,
                body: Consumer<ForgotPasswordBloc>(
                  builder: (context, bloc, _) =>
                      Stack(
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
                                        title: translate(context, 'rmp_hdr'),
                                        shouldShowBackButton: true,
                                        shouldShowDivider: false,
                                        backgroundColor: ColorResource
                                            .colorTransparent,
                                        appbarContentColor: ColorResource
                                            .colorWhite,
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        translate(context, 'rmp_lbl'),
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: TextEditText(
                                            labelText: translate(
                                                context, 'rmp_cap')
                                                .toUpperCase(),
                                            textEditingController:
                                            passwordEditController,
                                            validationMessageRegexPair: {
                                              PASSWORD_REGEX: localize('txt_pwd_msg')
                                            },
                                            textColor: ColorResource.colorWhite,
                                            labelTextColor: Colors.white,
                                            hintTextColor: ColorResource.grey_white,
                                            hintText: translate(context, 'hnt_msc'),
                                            labelTextBgColor: ColorResource.colorMarineBlue,
                                            obscured: true,
                                            onChanged: (text) {
                                              bloc.password = text;
                                              bloc.validatePassword(text);
                                            }),
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
                                        buttonText: translate(
                                            context, 'rmp_hdr'),
                                        textColor: bloc.buttonTextColor,
                                        backGroundColor: bloc.buttonBgColor,
                                        onPressed: () {
                                          if (bloc.isValidated) {
                                            submitDialog(context,
                                                dismissible: false);
                                            bloc.updatePassword(widget.userId).then((
                                                apiRes) {
                                              Navigator.pop(context);
                                              onResponse(bloc, apiRes);
                                            });
                                          }
                                        })
                                  ],
                                ),
                              ),
                              alignment: Alignment.bottomCenter),
                        ],
                      ),
                ))));
  }

  onResponse(bloc, apiRes) {
    if (bloc.isApiError(apiRes)) {
      showToast(apiRes.message ?? translate(context, 'something_went_wrong'));
      return;
    }
    showAlertWithDefaultAction(context,
        content: apiRes.message,
        positiveBtnTxt: translate(context, "txt_ok"), callback: () {
          navigateNextScreen(context, OnboardScreen(),
              shouldFinishPreviousPages: true);
        });
  }
}
