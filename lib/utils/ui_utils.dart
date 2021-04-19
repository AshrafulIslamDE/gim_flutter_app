import 'dart:io';

import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/ui/home/homepage.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

showToast(String msg) {
  print('toast');
  showCustomSnackbar(msg);
  return;
}

showSnackBar(ScaffoldState context, String msg) {
  if (!isNullOrEmpty(msg)) showCustomSnackbar(msg);
  return;
  context.showSnackBar(SnackBar(
    content: Text(msg),
  ));
}

OverlayEntry showOverLay(BuildContext context, builder) {
  OverlayState overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(builder: builder);
  overlayState.insert(overlayEntry);

  return overlayEntry;
}

showCustomSnackbar(msg, {bgColor = null, textColor = null}) async {
  OverlayState overlayState = getGlobalState().overlay;
  OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => getSnackWidget(context,
          msg: msg, textColor: textColor, bgColor: bgColor));

  overlayState.insert(overlayEntry);

  await new Future.delayed(const Duration(seconds: 4));

  overlayEntry.remove();
}

Widget getSnackWidget(BuildContext context,
    {msg = "thanks", bgColor, textColor}) {
  var mediaQuery = MediaQuery.of(getGlobalContext());
  return Positioned(
    top: 0.0,
    left: 0.0,
    child: SafeArea(
      child: new Material(
          color: bgColor ?? Colors.black,
          child: Container(
              width: mediaQuery.size.width,
              padding: EdgeInsets.only(left: 18, right: 5, top: 15, bottom: 15),
              child: Text(
                msg,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: textColor ?? ColorResource.colorWhite,
                    fontSize: responsiveSize(18)),
              ))),
    ),
  );
}

void showAppDatePicker(context,
    {int minYear = 0,
    int minDay = 0,
    int minMonth = 0,
    int minHour = 0,
    minDate,
    String targetDateFormat = 'yyyy-MM-dd',
    Function onSelected}) async {
  bool shouldSetMaximumDate =
      minYear != 0 || minMonth != 0 || minDay != 0 || minHour != 0;
  bool isMaximumisInitialDate =
      minYear < 0 || minMonth < 0 || minDay < 0 || minHour < 0;
  var currentDate = DateTime.now();
  DateTime maximumDate = DateTime(
      currentDate.year + minYear,
      currentDate.month + minMonth,
      currentDate.day + minDay,
      currentDate.hour + minHour);
  var selectedDate =
      isMaximumisInitialDate ? maximumDate : minDate ?? DateTime.now();
  if (Platform.isIOS)
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  color: isDarkModeEnabled() ? Colors.black : Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 14.0, right: 14, top: 10, bottom: 5),
                          child: Text(
                            translate(
                              context,
                              'txt_cancel',
                            ),
                            style: TextStyle(
                                color: isDarkModeEnabled()
                                    ? Colors.white
                                    : Colors.lightBlue,
                                fontSize: responsiveTextSize(20)),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(builder).pop();
                        },
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 14.0, right: 14, top: 10, bottom: 5),
                          child: Text(
                            translate(context, 'txt_done'),
                            style: TextStyle(
                                color: isDarkModeEnabled()
                                    ? Colors.white
                                    : Colors.lightBlue,
                                fontSize: responsiveTextSize(20)),
                          ),
                        ),
                        onTap: () {
                          onSelected(DateFormat(targetDateFormat)
                              .format(selectedDate));
                          Navigator.of(builder).pop();
                        },
                      ),
                    ],
                  )),
              Container(
                height: MediaQuery.of(context).copyWith().size.height / 3,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                    color: isDarkModeEnabled() ? Colors.white : Colors.black,
                    fontSize: 22,
                  ))),
                  child: CupertinoDatePicker(
                    minimumYear: currentDate.year - 100,
                    backgroundColor:
                        isDarkModeEnabled() ? Colors.black : Colors.white,
                    maximumDate: shouldSetMaximumDate ? maximumDate : null,
                    minimumDate: minDate,
                    initialDateTime:
                        isMaximumisInitialDate ? maximumDate : minDate,
                    onDateTimeChanged: (DateTime newDate) {
                      selectedDate = newDate;
                    },

/*
                  maximumYear: currentDate.year,
                  minimumDate: selectedDate,
                  maximumDate: DateTime(currentDate.year,
                      currentDate.month, currentDate.day + 90),
*/
                    mode: CupertinoDatePickerMode.date,
                  ),
                ),
              ),
            ],
          );
        });
  else {
    var datePicked = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: isMaximumisInitialDate ? maximumDate : minDate,
      firstDate: minDate,
      lastDate: shouldSetMaximumDate ? maximumDate : null,
      dateFormat: targetDateFormat,
      locale: DateTimePickerLocale.en_us,
    );
    if (datePicked != null)
      // datePicked=isMaximumisInitialDate?selectedDate:minDate??DateTime.now();
      onSelected(DateFormat(targetDateFormat).format(datePicked));
  }
}

showTimepicker(context) {
  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                color: isDarkModeEnabled() ? Colors.black : Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                        child: Text(
                          translate(context, 'txt_cancel'),
                          style: TextStyle(
                              color: isDarkModeEnabled()
                                  ? Colors.white
                                  : Colors.lightBlue,
                              fontSize: responsiveTextSize(20)),
                        ),
                        onPressed: () => Navigator.of(builder).pop()),
                    CupertinoButton(
                        child: Text(
                          translate(context, 'txt_done'),
                          style: TextStyle(
                              color: isDarkModeEnabled()
                                  ? Colors.white
                                  : Colors.lightBlue,
                              fontSize: responsiveTextSize(20)),
                        ),
                        onPressed: () {
                          Navigator.of(builder).pop();
                        }),
                  ],
                )),
            Container(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              child: CupertinoDatePicker(
                backgroundColor:
                    isDarkModeEnabled() ? Colors.black : Colors.white,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  // selectedTime = newDate;
                },
                mode: CupertinoDatePickerMode.time,
              ),
            )
          ],
        );
      });
}

hideSoftKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

Future<Null> submitDialog(BuildContext context, {dismissible = true}) async {
  return await showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => true, //dismissible,
          child: SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: responsiveSize(40),
                  height: responsiveSize(40),
                  child: CircularProgressIndicator(
                    backgroundColor: ColorResource.colorMarineBlue,
                  ),
                ),
              )
            ],
          ),
        );
      });
}

onAlertWithTitlePress(BuildContext context, String title, String content,
    String btnTxtPos, String btnTxtNeg, Function callback) {
  showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(title),
            content: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: isNullOrEmpty(content)
                  ? null
                  : Text(
                      content,
                      style: TextStyle(fontFamily: "roboto", height: 1.25),
                    ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(btnTxtPos),
                onPressed: () {
                  Navigator.pop(context, btnTxtPos);
                  callback();
                },
              ),
              CupertinoDialogAction(
                child: Text(btnTxtNeg),
                onPressed: () => Navigator.pop(context, btnTxtNeg),
              ),
            ],
          ));
}

showAlertWithDefaultAction(BuildContext context,
    {String title,
    String content,
    String positiveBtnTxt,
    String negativeButtonText,
    Function callback}) {
  BuildContext dialogContext;
  List<Widget> actionWidgets = [
    CupertinoDialogAction(
      child: Text(positiveBtnTxt.toUpperCase()),
      onPressed: () {
        if(dialogContext != null)Navigator.pop(dialogContext, positiveBtnTxt);
        if (callback != null) callback();
      },
    )
  ];

  if (!isNullOrEmpty(negativeButtonText))
    actionWidgets.add(
      CupertinoDialogAction(
        child: Text(negativeButtonText.toUpperCase()),
        onPressed: () {
          Prefs.saveLastCheckedDate();
          if(dialogContext != null)Navigator.pop(dialogContext, negativeButtonText);
        },
      ),
    );
  showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        dialogContext = context;
        return WillPopScope(
            onWillPop: () async => false,
            child: CupertinoAlertDialog(
              title: title == null ? null : Text(title),
              content: content == null
                  ? null
                  : Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  content,
                  style: TextStyle(fontFamily: "roboto", height: 1.25),
                ),
              ),
              actions: actionWidgets,
            ));
      });
}

appUpdateDialog(BuildContext context, FlagWrapper dialogShowing, Function callback) async {
  bool isForceUpdate = await forceUpdate();
  bool isOptUpdate = await optUpdate();
  if (isForceUpdate || isOptUpdate) {
    dialogShowing.isDialogShowing = true;
    List<Widget> actionWidgets = [
      CupertinoDialogAction(
        child: Text(localize('update_btn_txt').toUpperCase()),
        onPressed: () {
          Navigator.pop(context);
          dialogShowing.isDialogShowing = false;
          launchURL(AppConstants.storeURL);
        },
      )
    ];
    if (!isForceUpdate) {
      actionWidgets.add(
        CupertinoDialogAction(
          child: Text(localize('later_btn_txt').toUpperCase()),
          onPressed: () {
            Navigator.pop(context);
            Prefs.saveLastCheckedDate();
            dialogShowing.isDialogShowing = false;
          },
        ),
      );
    }
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => WillPopScope(
            onWillPop: () async => callback(),
            child: CupertinoAlertDialog(
              title: Text(localize('app_update_ttl')),
              content: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  isForceUpdate ? localize('app_update_msg') : localize('app_opt_update_msg'),
                  style: TextStyle(fontFamily: "roboto", height: 1.25),
                ),
              ),
              actions: actionWidgets,
            )));
  }
}

showAlertWithoutTitleAction(
    BuildContext context, List<TextSpan> content, String positiveBtnTxt,
    {Function callback}) {
  showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            content: content == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: RichText(
                      text: TextSpan(children: content),
                      textAlign: TextAlign.center,
                    ),
                  ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(positiveBtnTxt),
                onPressed: () {
                  Navigator.pop(context, positiveBtnTxt);
                  if (callback != null) callback();
                },
              )
            ],
          ));
}

showThreeLabelSpannableDialog(BuildContext context, String messageTag,
    {callback}) {
  var textSpan = List<TextSpan>();
  textSpan.add(TextSpan(
      text: translate(context, messageTag),
      style: TextStyle(
          color: isDarkModeEnabled() ? Colors.white : ColorResource.colorBlack,
          height: 1.25)));
  textSpan.add(TextSpan(
      text: translate(context, "txt_apl_no"),
      style: spannableTextStyle,
      recognizer: getContactNumberUrlRecognizer(context)));

  textSpan.add(TextSpan(
      text: translate(context, "txt_apl_fas"),
      style: TextStyle(
          color: isDarkModeEnabled() ? Colors.white : ColorResource.colorBlack,
          height: 1.25)));
  showAlertWithoutTitleAction(context, textSpan, translate(context, 'txt_ok'),
      callback: callback);
}

final spannableTextStyle = const TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: Colors.black,
    height: 1.25,
    color: ColorResource.colorMarineBlueLight);

showSpannableDialog(context,
    {normalText, List spannableText, List recognizer}) {
  var textSpan = TextSpan(
    children: [
      TextSpan(
          text: normalText,
          style: TextStyle(
              color: isDarkModeEnabled()
                  ? ColorResource.colorWhite
                  : ColorResource.colorBlack,
              height: 1.25)),
      for (int index = 0; index < spannableText.length; index++)
        TextSpan(
            text: spannableText[index],
            style: spannableTextStyle,
            recognizer: recognizer != null ? recognizer[index] : null),
    ],
  );

  showAlertWithoutTitleAction(
      context, [textSpan], translate(context, 'txt_ok'));
}

showSingleSpannableDialog(context, {normalText, spannableText, recognizer}) {
  showSpannableDialog(context,
      recognizer: [recognizer],
      normalText: normalText,
      spannableText: [spannableText]);
}

getContactNumberUrlRecognizer(context) {
  return TapGestureRecognizer()
    ..onTap = () => call('tel://${translate(context, "txt_apl_no")}');
}

showLoader<T extends BaseBloc>(T bloc) {
  return Center(
    child: Selector<T, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, builderVal, _) => Visibility(
            visible: bloc.isLoading,
            child: SizedBox(
              width: responsiveSize(40),
              height: responsiveSize(40),
              child: CircularProgressIndicator(
                backgroundColor: ColorResource.colorMarineBlue,
              ),
            ))),
  );
}

BuildContext getGlobalContext() {
  var context = FlavorConfig.instance.values.navigatorKey.currentContext;
  return context;
}

NavigatorState getGlobalState() {
  var state = FlavorConfig.instance.values.navigatorKey.currentState;
  return state;
}

childWithVerticalDevider({child}) => Container(
    child: child,
    decoration: BoxDecoration(
      color: Colors.lightBlue,
      border: Border(
        right: BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),
    ));

bool isDarkModeEnabled() {
  var brightness = MediaQuery.of(getGlobalContext()).platformBrightness;
  return brightness == Brightness.dark;
}
