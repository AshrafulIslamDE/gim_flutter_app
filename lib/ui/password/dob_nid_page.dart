import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/features/registration/national_id_bloc.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/password/new_password_page.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/editfield.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:customer/utils/validationUtils.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DobNidScreen extends StatelessWidget {
  final int userId;

  DobNidScreen({this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NationalIdBloc>(create: (_) => NationalIdBloc()),
      ],
      child: DobNidScreenPage(userId: userId),
    );
  }
}

class DobNidScreenPage extends StatefulWidget {
  final int userId;

  DobNidScreenPage({this.userId});

  @override
  _DobNidScreenPageState createState() => _DobNidScreenPageState();
}

class _DobNidScreenPageState extends State<DobNidScreenPage> {
  final Trace trace = FirebasePerformance.instance.newTrace('sign_up_nid');
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var nationalIdNumberEditController = TextEditingController();
  var dateOfBirthEditController = TextEditingController();

  @override
  void initState() {
    trace.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => hideSoftKeyboard(context),
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Consumer<NationalIdBloc>(
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
                          child:
                              Column(mainAxisSize: MainAxisSize.max, children: <
                                  Widget>[
                        AppBarWidget(
                          //TODO: Please remove earlier hader label from locale key:lbl_dob_nid
                          title: translate(context, 'dob_nid_lbl'),
                          shouldShowBackButton: true,
                          backgroundColor: ColorResource.colorTransparent,
                          appbarContentColor: ColorResource.colorWhite,
                          shouldShowDivider: false,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          translate(context, 'dob_nid_msg'),
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextEditText(
                            //TODO: Remove earlier constant from locale key:txt_nid_no
                            labelText:
                                translate(context, 'lbl_nid_no').toLowerCase(),
                            textEditingController:
                                nationalIdNumberEditController,
                            keyboardType: TextInputType.text,
                            maxlength: 17,
                            errorMaxLines: 3,
                            validationMessageRegexPair: {
                              NID_PASSPORT_REGEX:
                                  translate(context, 'nid_passport_err_msg')
                            },
                            //TODO: Remove earlier constant from locale key:hnt_enter_nid
                            hintText: translate(context, 'hnt_nid_no'),
                            onChanged: (text) {
                              bloc.nidNumber = text;
                              bloc.validate(text);
                            },
                            textCapitalization: TextCapitalization.characters,
                            labelTextBgColor: ColorResource.colorMarineBlue,
                            labelTextColor: Colors.white,
                            textColor: Colors.white,
                            hintTextColor: ColorResource.grey_white,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextEditText(
                            labelText:
                                translate(context, 'lbl_dob').toUpperCase(),
                            hintText: translate(context, 'sel_dob_msg'),
                            textEditingController: dateOfBirthEditController,
                            readOnly: true,
                            validationMessageRegexPair: {
                              NOT_EMPTY_REGEX: translate(context, 'req_dob_msg')
                            },
                            suffixIcon: Image.asset(
                              "images/calendar.png",
                              height: 18,
                              width: 18,
                            ),
                            onTap: () {
                              print("onTop");
                              showAppDatePicker(context, minYear: -18,
                                  onSelected: (selectedDate) {
                                bloc.dob = selectedDate;
                                dateOfBirthEditController.text = selectedDate;
                                // bloc.notifyListeners();
                              });
                            },
                            labelTextBgColor: ColorResource.colorMarineBlue,
                            textColor: Colors.white,
                            labelTextColor: Colors.white,
                            hintTextColor: ColorResource.grey_white,
                            onChanged: bloc.validate,
                          ),
                        ),
                      ])),
                    ),
                    Align(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 60.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              FilledColorButton(
                                  buttonText: translate(context, "txt_next"),
                                  textColor: bloc.buttonTextColor,
                                  backGroundColor: bloc.buttonBgColor,
                                  onPressed: () {
                                    if (bloc.isValidated) {
                                      submitDialog(context, dismissible: false);
                                      bloc.verifyDobNid().then((apiResponse) {
                                        _response(bloc, apiResponse);
                                      });
                                    }
                                  })
                            ],
                          ),
                        ),
                        alignment: Alignment.bottomCenter),
                  ],
                ),
              ),
            )));
  }

  _response(bloc, apiRes) {
    Navigator.pop(context);
    if (bloc.isApiError(apiRes)) {
      showToast(apiRes.message ?? translate(context, 'something_went_wrong'));
      return;
    }
    trace.stop();
    navigateNextScreen(context, NewPasswordScreen(userId: widget.userId),
        shouldReplaceCurrentPage: true);
  }
}
