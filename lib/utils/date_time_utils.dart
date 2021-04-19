import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:intl/intl.dart';

const int SECOND_MILLIS = 1000;
const int MINUTE_MILLIS = 60 * SECOND_MILLIS;
const int HOUR_MILLIS = 60 * MINUTE_MILLIS;
const int DAY_MILLIS = 24 * HOUR_MILLIS;

const String defaultPresentationDateFormat = 'dd MMM yyyy hh:mm a';
const defaultPresentationDateFormatBangla='dd MMMM yyyy hh:mm a';
const String AppDateFormat = "dd MMM yyyy";
const String AppInputDateFormat = "yyyy-MM-dd";
const String AppTimeFormat = "hh:mm a";

const String ISOFormat="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";

String getFormattedDate(String givenDate, {originalFormat, presentationFormat = AppDateFormat,localization="en"}) {
  //print("givenDate" + givenDate.toString());
try {
  if (isNullOrEmpty(givenDate))
    return ' ';
  else {
    final df = DateFormat(originalFormat);
    var parsedDate = df.parse(givenDate);
    return DateFormat(presentationFormat,localization).format(parsedDate).toUpperCase();
  }
} on Exception catch(ex){
  print(ex.toString());
  return " ";
}
}
String getLocalizedFormattedDate(String givenDate,{format}){
  var presentationFormat=format;
  if(isBangla()&&format==defaultPresentationDateFormat) presentationFormat=defaultPresentationDateFormatBangla;
  if(isBangla()&&format==AppDateFormat) presentationFormat='dd MMMM yyyy';

  return getFormattedDate(givenDate,presentationFormat: presentationFormat,originalFormat: format,localization: languageCode());
}
String getInputDate(input){
  return getFormattedDate(input,originalFormat:AppDateFormat,presentationFormat: AppInputDateFormat );
}
String convertTimestampToDateTime(
    {String dateFormat = defaultPresentationDateFormat, int timestamp,shouldUppercase=true,lng}) {
  if(timestamp==null) return "";
  try {
    if(isBangla()&&dateFormat==defaultPresentationDateFormat) dateFormat=defaultPresentationDateFormatBangla;
    if(isBangla()&&dateFormat==AppDateFormat) dateFormat='dd MMMM yyyy';

    final df = DateFormat(dateFormat,lng??languageCode());
    var formattedDate=df.format(DateTime.fromMillisecondsSinceEpoch(timestamp));
    return shouldUppercase?formattedDate.toUpperCase():formattedDate;

  }catch(ex){
    print('${ex.toString()})');
    return " ";
  }
}

getTimeDifferenceInDaysHours(int stTime) {
  if (stTime == null) return "";
  try {
    var now = DateTime.now().millisecondsSinceEpoch;
    if (stTime < now) {
      return localize('txt_rts');
    }
    var diff = stTime - now;
  print((diff / HOUR_MILLIS).floor().toString());
    if (diff < HOUR_MILLIS) {
      return localize('value_minutes_to_start',dynamicValue:(diff / MINUTE_MILLIS).floor().toString() );//(diff / MINUTE_MILLIS).floor().toString() + " min to start";
    } else if (diff < 24 * HOUR_MILLIS) {
      var hours = diff % HOUR_MILLIS;
      return hours == 0
          ?localize('value_hours_to_start',dynamicValue: (diff / HOUR_MILLIS).floor().toString())
          : localize('value_hours_minute_hr',dynamicValue:(diff / HOUR_MILLIS).floor().toString() ) +

           localize('value_hours_minute_min',dynamicValue:(hours / MINUTE_MILLIS).floor().toString() );
    }
    if (diff < 2 * DAY_MILLIS)
     return localize('value_d_to_start');

    else
      return localize('value_ds_to_start',dynamicValue: getStringFromInt(diff, DAY_MILLIS));

  } catch (ex) {}
  return "";
}

showEtaTime(int minute, int startTime) {
  if (minute == null) return 'N/A';
  int pickUptimeVal;
  int currentTime = DateTime.now().millisecondsSinceEpoch;
  if (startTime == null) {
    pickUptimeVal = currentTime + minute * 60 * 1000;
  } else
    pickUptimeVal = startTime + minute * 60 * 1000;

  var remainingTime = localize('running');
  String pickUpDateTime = DateFormat("hh:mm a,dd MMM",languageCode())
      .format(DateTime.fromMillisecondsSinceEpoch(pickUptimeVal));
  String eta=localize('eta');
  if(isBangla()) {
    pickUpDateTime = pickUpDateTime.replaceAll("PM", "অপরাহ্ন");
    pickUpDateTime = pickUpDateTime.replaceAll("AM", "পূর্বাহ্ন");
  }
  if (currentTime < pickUptimeVal) return (eta+ pickUpDateTime.toString()).toUpperCase();
  return (eta + pickUpDateTime.toString() + " " + remainingTime.toString()).toUpperCase();
}

getTimeDifferenceInText(oldTime, latestTime ) {
  try {
   //print("oldtime:"+oldTime);
    if (oldTime!=null) {
      if (oldTime > latestTime || oldTime <= 0) {
        return localize('updated_0_min');
      }
      var diff = latestTime - oldTime;
      String updateTimeString;
      //print("diff" + diff.toString());
      if (diff < MINUTE_MILLIS)
        updateTimeString = localize('updated_just_now');
      else if (diff < 2 * MINUTE_MILLIS)
        updateTimeString = localize('updated_a_minute_ago');
      else if (diff < 50 * MINUTE_MILLIS)
        updateTimeString =localize('updated_minutes_ago',dynamicValue: getStringFromInt(diff, MINUTE_MILLIS));
      else if (diff < 90 * MINUTE_MILLIS)
        updateTimeString = localize('updated_a_hour_ago');
      else if (diff < 24 * HOUR_MILLIS)
        updateTimeString =localize('updated_hours_ago',dynamicValue:getStringFromInt(diff, HOUR_MILLIS) ) ;
      else if (diff < 48 * HOUR_MILLIS)
        updateTimeString = localize('updated_yesterday');
      else
        updateTimeString =localize('updated_days_ago',dynamicValue: getStringFromInt(diff, DAY_MILLIS));
      return updateTimeString;
    } else
      return localize('updated_0_min');
  } catch (Exception) {
    print("catch method:${Exception.toString()}");
  }
  return localize('updated_0_min');

}



getDayDifferenceInText(int stTime) {
  if (stTime==null || stTime <= 0) return "";
  try {
    if (stTime != null) {

      final serverTime = DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.fromMillisecondsSinceEpoch(stTime)));
      final nowTimeStamp = DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now()));

      final days = nowTimeStamp.difference(serverTime).inDays;

      String updateTimeString;
      if (days == 0)
        updateTimeString = localize('today');
      else if (days == 1)
        updateTimeString = localize('yesterday');
      else
        updateTimeString = localize('value_days',dynamicValue:days.toString());
      return updateTimeString;
    }
  } catch (e) {}
  return "";
}

isSelCurrentDate(DateTime selDateTime){
  DateTime curDateDay = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  DateTime selDateDay = DateTime.parse(DateFormat('yyyy-MM-dd').format(selDateTime));
  return curDateDay.compareTo(selDateDay) == 0;
}

currentDateInFormat(){

}

DateTime getDateFromFormattedDate(String givenDate,String format){
  var formatter = DateFormat(format);
  return formatter.parse(givenDate);
}

getStringFromInt(int value1, int value2) {
  return (value1 / value2).floor().toString();
}
