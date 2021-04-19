import 'dart:io';

import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/ui/create_trip/route_map_page.dart';
import 'package:customer/ui/widget/create_trip_title_widget.dart';
import 'package:customer/ui/widget/app_button.dart';
import 'package:customer/ui/widget/mandatory_field_note_widget.dart';
import 'package:customer/ui/widget/navigation_utils.dart';
import 'package:customer/utils/analytics.dart';
import 'package:customer/utils/date_time_utils.dart';
import 'package:customer/utils/screen_dimension_utils.dart';
import 'package:customer/utils/firebase_analytics_utils.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../styles.dart';
import 'bloc/date_time_picker_bloc.dart';

class CreateTripPageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DateTimePickerBloc>(
            create: (_) => DateTimePickerBloc()),
      ],
      child: CreateTripPage(),
    );
  }
}

class CreateTripPage extends StatefulWidget {
  @override
  _CreateTripPageState createState() => _CreateTripPageState();
}

class _CreateTripPageState extends State<CreateTripPage> {
  final TextEditingController dateTec = TextEditingController();
  final TextEditingController timeTec = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String datePref = "Please select...";
  String timePref = "Please select...";
  DateTime currentTime = DateTime.now();
  DateTime selectedDate, selectedTime;
  DateTimePickerBloc bloc;
  final Trace trace =
      FirebasePerformance.instance.newTrace('create_trip_time_picker');

  @override
  void initState() {
    selectedDate = currentTime;
    selectedTime = currentTime;
    datePref = localize('hint_please_select');
    timePref = localize('hint_please_select');
    trace.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<DateTimePickerBloc>(context, listen: false);
    dateTec.text = dateTec.text.trim().length == 0 ? ' ' : dateTec.text;
    timeTec.text = timeTec.text.trim().length == 0 ? ' ' : timeTec.text;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: CreateTripHeader(
        currentStep: 1,
        titleSpacing: 20.0,
        isShowBackButton: false,
        leadingWidget: Icon(
          Icons.navigate_before,
          color: Colors.transparent,
        ),
      ),
      body: Container(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, top: 20.0, right: 20.0, bottom: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        localize("create_trip_ttl"),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: "roboto",
                            fontWeight: FontWeight.w300,
                            fontSize: responsiveTextSize(16.0),
                            color: ColorResource.greyIshBrown),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                child: Text(
                                    AppTranslations.of(context)
                                        .text("create_trip_dt_ttl"),
                                    style: TextStyle(
                                        fontFamily: "roboto",
                                        fontWeight: FontWeight.w700,
                                        color: ColorResource.colorMarineBlue,
                                        fontSize: responsiveTextSize(20.0))))),
                      ),
                      TextField(
                        autocorrect: false,
                        readOnly: true,
                        controller: dateTec,
                        style: TextStyle(
                            fontFamily: "roboto",
                            fontWeight: FontWeight.w300,
                            fontSize: responsiveTextSize(15.0),
                            color: ColorResource.colorBlack),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: AppTranslations.of(context)
                                .text("ct_pick_date_lbl"),
                            labelStyle: TextStyle(
                                fontFamily: "roboto",
                                fontWeight: FontWeight.w300,
                                fontSize: responsiveTextSize(16.0),
                                color: ColorResource.brownish_grey),
                            prefixText: datePref,
                            prefixStyle: Styles.mapHintTextStyle,
                            suffixIcon: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 12.0),
                              child: SvgPicture.asset(
                                'svg_img/ic_vector_calendar.svg',
                                height: responsiveSize(10),
                                width: responsiveSize(10),
                              ), // myIcon is a 48px-wide widget.
                            )),
                        onTap: () => _showDatePicker(),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        autocorrect: false,
                        readOnly: true,
                        controller: timeTec,
                        style: TextStyle(
                            fontFamily: "roboto",
                            fontWeight: FontWeight.w300,
                            fontSize: responsiveTextSize(16.0),
                            color: ColorResource.colorBlack),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppTranslations.of(context)
                              .text("ct_pick_time_lbl"),
                          labelStyle: TextStyle(
                              fontFamily: "roboto",
                              fontWeight: FontWeight.w300,
                              fontSize: responsiveSize(16.0),
                              color: ColorResource.brownish_grey),
                          prefixText: timePref,
                          prefixStyle: Styles.mapHintTextStyle,
                          suffixIcon: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(end: 12.0),
                            child: SvgPicture.asset(
                              'svg_img/ic_time.svg',
                              height: responsiveSize(10),
                              width: responsiveSize(10),
                            ), // myIcon is a 48px-wide widget.
                          ),
                        ),
                        onTap: () => _showTimePicker(), //_selectTime(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "",
                            style: TextStyle(
                                fontSize: responsiveDefaultTextSize()),
                            children: <TextSpan>[
                              TextSpan(
                                  text: AppTranslations.of(context)
                                      .text("ct_note_start"),
                                  style: TextStyle(
                                      fontFamily: "roboto",
                                      fontWeight: FontWeight.w300,
                                      color: ColorResource.colorMarineBlue)),
                              TextSpan(
                                  text: AppTranslations.of(context)
                                      .text("ct_note_mid"),
                                  style: TextStyle(
                                      fontFamily: "roboto",
                                      fontWeight: FontWeight.w500,
                                      color: ColorResource.colorMarineBlue)),
                              TextSpan(
                                  text: AppTranslations.of(context)
                                      .text("ct_note_end"),
                                  style: TextStyle(
                                      fontFamily: "roboto",
                                      fontWeight: FontWeight.w300,
                                      color: ColorResource.colorMarineBlue)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MandatoryFieldNote(),
              Consumer<DateTimePickerBloc>(
                  builder: (context, bloc, _) => FilledColorButton(
                        buttonText: translate(context, 'txt_next'),
                        backGroundColor: bloc.buttonColor,
                        onPressed: () {
                          if (validate()) {
                            trace.stop();
                            FireBaseAnalytics().logEvent(
                                AnalyticsEvents.EVENT_CREATE_TRIP_PICKER, null);
                            bloc.tripRequest.datetimeUtc = bloc.apiUtcDateTime;
                            bloc.tripRequest.datetimeLocal =
                                bloc.apiLocalDateTime;
                            navigateNextScreen(context, CreateTripMapScreen());
                          }
                        },
                      )),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker() {

    showAppDatePicker(context,minDay: 90,minHour: 1,minDate: DateTime.now(),
        targetDateFormat:AppDateFormat,onSelected:(value){
setState(() {
  timePref = translate(context, 'hint_please_select');
  timeTec.text = "";
  selectedDate= getDateFromFormattedDate(value, AppDateFormat);
  datePref = "";
  dateTec.text =value;
});
    } );
    return;
  }

  void _showTimePicker() async{

    if(Platform.isIOS) {
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
                              setState(() {
                                timePref = "";
                                timeTec.text =
                                    DateFormat.jm().format(selectedTime);
                                validate();
                                bloc.stringDateTimeLocal(
                                    DateFormat("yyyy-MM-dd").format(
                                        selectedDate),
                                    timeTec.text);
                                bloc.tripRequest.datetimeUtcStr =
                                    dateTec.text + " " + timeTec.text;
                              });
                              Navigator.of(builder).pop();
                            }),
                      ],
                    )),
                Container(
                  height: MediaQuery
                      .of(context)
                      .copyWith()
                      .size
                      .height / 3,
                  child: CupertinoDatePicker(
                    backgroundColor:
                    isDarkModeEnabled() ? Colors.black : Colors.white,
                    initialDateTime:
                    selectedTime = isSelCurrentDate(selectedDate)
                        ? DateTime.now().add(
                        Duration(hours: 1, minutes: 1, seconds: 1))
                        : DateTime.now(),
                    onDateTimeChanged: (DateTime newDate) {
                      selectedTime = newDate;
                    },
                    mode: CupertinoDatePickerMode.time,
                  ),
                )
              ],
            );
          });
    }else{
      var nowTime=TimeOfDay.now();
      var timePicker=await showTimePicker(context: context,
        initialTime:isSelCurrentDate(selectedDate)?TimeOfDay(hour: nowTime.hour+1, minute: nowTime.minute+1):nowTime,
      );
      if(timePicker!=null) {
        MaterialLocalizations localizations = MaterialLocalizations.of(context);
        String formattedTime2 = localizations.formatTimeOfDay(timePicker,
            alwaysUse24HourFormat: false);
        setState(() {
          timePref = "";
          timeTec.text = formattedTime2;
          validate();
          bloc.stringDateTimeLocal(DateFormat("yyyy-MM-dd").format(selectedDate), timeTec.text);
          bloc.tripRequest.datetimeUtcStr = dateTec.text + " " + timeTec.text;
        });
      }
    }

  }

  bool validate() {
    String dateTimeInString =
        DateFormat("yyyy-MM-dd").format(selectedDate) + ' ' + timeTec.text;
    var formatter = DateFormat("yyyy-MM-dd hh:mm aa");
    DateTime selDateTime = formatter.parse(dateTimeInString);
    if ((selDateTime.difference(DateTime.now()).inHours >= 1 ||
            selDateTime.difference(DateTime.now()).inHours == -9) &&
        dateTec.text.trim().isNotEmpty &&
        timeTec.text.trim().isNotEmpty) {
      bloc.setButtonColor(HexColor("#003250"));
      return true;
    } else {
      showToast(translate(context, 'inv_dat_tim'));
      bloc.setButtonColor(HexColor("#96003250"));
      return false;
    }
  }
}
