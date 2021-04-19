import 'dart:io';

import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/model/auth/login_response.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/profile/profile_image_box_widget.dart';
import 'package:customer/ui/widget/app_bar.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/base_widget.dart';
import 'package:customer/ui/widget/caller_layout.dart';
import 'package:customer/ui/widget/circular_profile_avatar.dart';
import 'package:customer/ui/widget/editfield.dart';
import 'package:customer/ui/widget/mandatory_field_note_widget.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/image_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:customer/utils/validationUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc/edit_profile_bloc.dart';

class EditMyDetailsScreen extends StatelessWidget {
  final LoginResponse userProfile;

  EditMyDetailsScreen({this.userProfile});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditMyDetailsBloc>(
      create: (context) => EditMyDetailsBloc(userProfile: userProfile),
      child: EditMyDetailsPage(),
    );
  }
}

class EditMyDetailsPage extends StatefulWidget {
  @override
  _EditMyDetailsPage createState() => _EditMyDetailsPage();
}

class _EditMyDetailsPage extends BasePageWidgetState<EditMyDetailsPage, EditMyDetailsBloc> {
  var nameEditController = TextEditingController();
  var emailEditController = TextEditingController();
  var referralEditController = TextEditingController();
  var districtEditController = TextEditingController();
  var dateOfBirthEditController = TextEditingController();
  var nidController = TextEditingController();
  var bigAsterisk="<big>*</big>";

  @override
  PreferredSizeWidget getAppbar() {
    return AppBarWidget(
      title: translate(context, 'ttl_edit_detail'),
    );
  }

  @override
  getFloatingActionButton() => CallerWidget(autoAlignment: false);

  @override
  List<Widget> getPageWidget() {
    return [
      Column(
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
                        CircularProfileAvatar(
                          bloc.userProfile?.pic,
                          imageFile: _imageFile,
                          initialsText:
                              Text(getInitialText(bloc.userProfile?.name)),
                        ),
                        TextEditText(
                          onTap: _handleOnTap,
                          labelText:
                              translate(context, 'lbl_name').toUpperCase(),
                          textEditingController: nameEditController
                            ..text = bloc.userProfile?.name,
                          hintText: translate(context, 'hint_name'),
                          readOnly: true,
                        ),
                        TextEditText(
                          labelText:
                              translate(context, 'txt_email').toUpperCase(),
                          textEditingController: emailEditController
                            ..text = bloc.userProfile?.email,
                          isOptionalFieldWithValidation: true,
                          validationMessageRegexPair: {
                            EMAIL_REGEX: EMAIL_MSG
                          },
                          hintText: translate(context, 'txt_hint_pem'),
                          onChanged: (text) {
                            bloc.userProfile?.email = text;
                            bloc.validateEmail(text);
                          },
                        ),
                        TextEditText(
                          labelText:
                              translate(context, 'txt_ref').toUpperCase(),
                          textEditingController: referralEditController
                            ..text = bloc.userProfile?.referrelCode,
                          isOptionalFieldWithValidation: true,
                          validationMessageRegexPair: {
                            MOBILE_NUMBER_REGEX: REFERRAL_NUMBER_MSG
                          },
                          maxlength: 11,
                          hintText: '018-3431000',
                          onChanged: onReferralCode,
                          readOnly: bloc.isAlreadyValid,
                          onTap: bloc.isAlreadyValid ? _handleOnTap : null,
                        ),
                        TextEditText(
                          isHtmlText: true,
                          labelText: translate(context, 'txt_dob') +bigAsterisk,
                          textEditingController: dateOfBirthEditController
                            ..text = bloc.userProfile?.dob == null
                                ? null
                                : convertTimestampToDateTime(
                                    dateFormat: 'dd MMM yyyy',
                                    timestamp: bloc.userProfile?.dob),
                          readOnly: true,
                          suffixIcon: Image.asset(
                            "images/calendar.png",
                            height: 18,
                            width: 18,
                          ),
                          onTap: _handleOnTap,
                        ),
                        TextEditText(
                          isHtmlText: true,
                          labelText: translate(context, 'txt_dst') + bigAsterisk,
                          textEditingController: districtEditController
                            ..text = bloc.userProfile?.district,
                          readOnly: true,
                          onTap: _handleOnTap,
                        ),
                        TextEditText(
                          isHtmlText: true,
                          labelText: bloc.userProfile?.nationalId == null
                              ? translate(context, 'passport_no') + bigAsterisk
                              : translate(context, 'txt_nid') + bigAsterisk,
                          textEditingController: nidController
                            ..text = bloc.userProfile?.nationalId == null
                                ? bloc.userProfile?.passportNumber
                                : bloc.userProfile?.nationalId,
                          readOnly: true,
                          onTap: _handleOnTap,
                        ),
                        ProfileImageBoxWidget(
                          isHtmlText: true,
                          imgUrl: bloc.userProfile?.nationalId == null
                          ? bloc.userProfile?.passportImage
                          : bloc.userProfile?.nationalIdFrontPhoto,
                          withImageText: bloc.userProfile?.nationalId == null
                          ? translate(context, 'passport_image') + bigAsterisk
                          : translate(context, 'txt_nid_pic') +
                              bigAsterisk +"</br>"+
                              translate(context, 'txt_front'),
                          placeHolderImage: 'images/id_front.webp',
                          withoutImageText:
                              translate(context, 'txt_nid_pic') +
                                  bigAsterisk +"</br>"+
                                  translate(context, 'txt_front'),
                          onTapCallback: _handleOnTap,
                        ),
                        Visibility(
                          visible: bloc.userProfile?.nationalId != null,
                          child: ProfileImageBoxWidget(
                            isHtmlText: true,
                            imgUrl: bloc.userProfile?.nationalIdBackPhoto,
                            withImageText: translate(context, 'txt_nid_pic') +
                                bigAsterisk + "</br>" +
                                translate(context, 'txt_back'),
                            placeHolderImage: 'images/id_back.webp',
                            withoutImageText:
                            translate(context, 'txt_nid_pic') +
                                bigAsterisk + "</br>" +
                                translate(context, 'txt_back'),
                            onTapCallback: _handleOnTap,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

      Padding(
        padding: const EdgeInsets.only(top:8.0,left: 20.0,right: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MandatoryFieldNote(),
            Consumer<EditMyDetailsBloc>(
                builder: (context, bloc, _) => FilledColorButton(
                      backGroundColor:
                          bloc.isReferralValid && bloc.isEmailValid
                              ? HexColor("#003250")
                              : HexColor("#96003250"),
                      buttonText:
                          translate(context, "txt_save_change"),
                      onPressed:
                          bloc.isReferralValid && bloc.isEmailValid
                              ? (){
                                  hideSoftKeyboard(context);
                                  _saveChanges();
                                }
                              : null,
                    )),
          ],
        ),
      ),
        ],
      ),
    ];
  }

  _saveChanges() async {
    submitDialog(context, dismissible: false);
    ApiResponse apiRes = await bloc.updateProfile(emailEditController.text);
    Navigator.pop(context);
    if (bloc.isApiError(apiRes)) {
      showToast(apiRes.message ?? translate(context, 'something_went_wrong'));
      return;
    }
    showAlertWithDefaultAction(context,
        title: translate(context, 'msg_pus_ttl'),
        content: translate(context, 'msg_pus'),
        positiveBtnTxt: translate(context, 'txt_ok'), callback: () {
      Navigator.pop(context, apiRes.message);
    });
  }

  _imageFile(File imageFile) {
    convertImageToBase64(imageFile).then(((value) {
      bloc.image = value;
    }));
  }

  _handleOnTap() {
    var recognizer = TapGestureRecognizer()
      ..onTap =
          () => call('tel://${translate(context, "txt_apl_no")}');
    showSingleSpannableDialog(context,
        normalText: translate(context, "txt_fld_msg"),
        spannableText: translate(context, "txt_apl_no"),
        recognizer: recognizer);
  }

  onReferralCode(String referralCode) async {
    submitDialog(context, dismissible: false);
    ApiResponse apiRes = await bloc.onReferralChange(referralCode);
    Navigator.pop(context);
    if (bloc.isApiError(apiRes)) {
      showAlertWithDefaultAction(context,
          content: apiRes.message,
          positiveBtnTxt: translate(context, "txt_ok"));
    }
  }
}
