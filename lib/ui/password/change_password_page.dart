import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/password/change_password_request.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/caller_layout.dart';
import 'package:customer/ui/widget/editfield.dart';
import 'package:customer/ui/widget/mandatory_field_note_widget.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:customer/utils/validationUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc/change_password_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChangePasswordBloc>(
            create: (_) => ChangePasswordBloc()),
      ],
      child: ChangePasswordPage(),
    );
  }
}

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState
    extends BasePageWidgetState<ChangePasswordPage, ChangePasswordBloc> {
  var oldPwdController = TextEditingController();
  var newPwdController = TextEditingController();
  var cnfPwdController = TextEditingController();

  @override
  PreferredSizeWidget getAppbar() => AppBarWidget(
        title: translate(context, 'txt_change_pwd').toUpperCase(),
        shouldShowBackButton: true,
      );

  @override
  getFloatingActionButton() => CallerWidget(autoAlignment: false);

  @override
  List<Widget> getPageWidget() {
    return [
      Container(
        child: Consumer<ChangePasswordBloc>(
            builder: (context, bloc, _) => Column(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  TextEditText(
                                      textEditingController: oldPwdController,
                                      labelText: translate(context, 'lbl_ecp'),
                                      hintText: translate(context, 'hnt_msc'),
                                      obscured: true,
                                      suffixIconColor: Colors.grey,
                                      validationMessageRegexPair: {
                                        PASSWORD_REGEX:
                                            translate(context, "txt_pwd_msg")
                                      },
                                      onChanged: _onChange),
                                  TextEditText(
                                      textEditingController: newPwdController,
                                      labelText: translate(context, 'lbl_enp'),
                                      hintText: translate(context, 'hnt_msc'),
                                      obscured: true,
                                      suffixIconColor: Colors.grey,
                                      validationMessageRegexPair: {
                                        PASSWORD_REGEX:
                                            translate(context, "txt_pwd_msg")
                                      },
                                      onChanged: _onChange),
                                  TextEditText(
                                    textEditingController: cnfPwdController,
                                    labelText: translate(context, 'lbl_cnp'),
                                    hintText: translate(context, 'hnt_msc'),
                                    obscured: true,
                                    suffixIconColor: Colors.grey,
                                    validationMessageRegexPair: {
                                      PASSWORD_REGEX:
                                          translate(context, "txt_pwd_msg")
                                    },
                                    onChanged: _onChange,
                                    errorText: bloc.errorMsg,
                                  ),
                                ],
                              ),
                            ),
                          ])),
                    ),
                    _buildFooter(bloc)
                  ],
                )),
      ),
    ];
  }

  _buildFooter(bloc) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(18.0, 5.0, 18.0, 5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          MandatoryFieldNote(),
          FilledColorButton(
            buttonText: translate(context, "txt_cpw"),
            backGroundColor: bloc.buttonColor,
            onPressed: bloc.isValidated
                ? () {
                    hideSoftKeyboard(context);
                    submitDialog(context, dismissible: false);
                    bloc
                        .changePassword(ChangePassWordRequest(
                            oldPass: oldPwdController.text,
                            newPass: newPwdController.text))
                        .then((apiResponse) {
                      Navigator.pop(context);
                      _manipulateResponse(bloc, apiResponse);
                    });
                  }
                : null,
          ),
        ],
      ),
    );
  }

  _manipulateResponse(bloc, ApiResponse response) {
    if (bloc.isApiError(response)) {
      showToast(response.message ?? translate(context, 'something_went_wrong'));
      return;
    }
    FireBaseAnalytics().logEvent(AnalyticsEvents.EVENT_CHANGE_PASSWORD,null);
    Navigator.pop(context, response);
  }

  _onChange(String value) {
    Provider.of<ChangePasswordBloc>(context, listen: false).validate(
        [oldPwdController.text, newPwdController.text, cnfPwdController.text]);
  }
}
