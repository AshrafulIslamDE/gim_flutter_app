import 'package:customer/core/localization/AppTranslation.dart';

String NOT_EMPTY_REGEX = r'^(?!\s*$).+';
String NOT_EMPTY_MSG = 'Must not be empty';
String MOBILE_NUMBER_REGEX = r'^01[0-9]{9}$';
String MOBILE_NUMBER_REGEX_0 = r'^0[0-9]{10}$';
String MOBILE_NUMBER_MSG = 'Invalid Mobile Number';
String PASSWORD_REGEX = r'^[a-zA-Z0-9]{6,}$';
String PASSWORD_ERROR = localize('txt_pwd_msg');
String EMAIL_REGEX=r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
String EMAIL_MSG="Invalid Email Address";
String NID_REGEX = r'^(\d{10}|\d{13}|\d{17})$';
String NID_PASSPORT_REGEX = r'^([a-zA-Z0-9]{9,10}|[a-zA-Z0-9]{13}|[a-zA-Z0-9]{17})$';
/*String NID_MSG='Sorry, Entered National ID Number is not valid, it should be 10, 13 or 17 digit number';*/
String PWD_MSG="Password not matched";
String REFERRAL_NUMBER_MSG = 'Referral code should be 11 characters long';


String validateMobile(String value) {
  if(value.isEmpty) return null;
  RegExp regex = new RegExp(MOBILE_NUMBER_REGEX);
  if (!regex.hasMatch(value))
    return localize('invalid_entered_mobile_number');
  else
    return null;
}

bool isValidField(String regexPattern,String value) {
  if(value.isEmpty) return false;
  RegExp regex = new RegExp(regexPattern);
  if (!regex.hasMatch(value))
    return false;
  else
    return true;
}