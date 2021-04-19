import 'package:customer/ui/create_trip/model/create_trip_request.dart';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerBloc extends ChangeNotifier {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String targetUtcDateTime;
  String targetLocalDateTime;
  String datetimeUtcStr;
  String targetDateformat="yyyy-MM-dd'T'HH:mm:ss'Z'";
  var tripRequest;
  var btnColor = HexColor("#96003250");

  get buttonColor => btnColor;

  get dateController => _dateController;

  get timeController => _timeController;

  get apiUtcDateTime => targetUtcDateTime;

  get apiLocalDateTime => targetLocalDateTime;

  get apiDateTimeUtcStr => datetimeUtcStr;

  DateTimePickerBloc() {
    tripRequest = CreateTripRequest.instance;
    tripRequest.clear();
  }

  setSelectedDate(String date) {
    _dateController.text = date;
    notifyListeners();
  }

  setSelectedTime(String time) {
    _timeController.text = time;
    notifyListeners();
  }

  setButtonColor(HexColor color) {
    btnColor = color;
    notifyListeners();
  }

  stringDateTimeLocal(String dateInString, String timeInString) {
    String dateTimeInString = dateInString + ' ' + timeInString;
    if (dateTimeInString.isNotEmpty) {
      try {
        var formatter = DateFormat("yyyy-MM-dd hh:mm a");
        var convertedFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
        targetLocalDateTime = convertedFormatter
            .format(formatter.parse(dateTimeInString).toLocal());
        targetUtcDateTime = convertedFormatter
            .format(formatter.parse(dateTimeInString).toUtc());
      } catch (e) {
        print(e.toString());
      }
    }
    return "";
  }
}
