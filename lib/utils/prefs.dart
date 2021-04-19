import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences _prefsInstance;
  static bool _initCalled = false;
  static const String token = "TOKEN";
  static const String ROLE_ID = "roleId";
  static const String USER_ID = "userId";
  static const String IS_PAY_ID = "payEnabled";
  static const String IS_LOGGED_IN = "IS_LOGGED_IN";
  static const String INVOICE_STATUS = "isInvActivated";
  static const  PREF_FIREBASE_LINK_MOBILE = "firebase_link_mobile";
  static const  PREF_FIREBASE_LINK_CUSTOMER = "firebase_link_customer";
  static const  PREF_FIREBASE_LINK_PARTNER = "firebase_link_partner";
  static const  PREF_ANALYTICS_PROPERTIES = "properties_updated";
  static const PREF_USER_MOBILE = "user_mobile";
  static const PREF_DEVICE_TOKEN = "PREF_DEVICE_TOKEN";
  static const IS_DISTRIBUTOR = "IsDistributor";
  static const PREF_IS_ENTERPRISE_USER = "PREF_IS_ENTERPRISE_USER";
  static const IS_APPROVED_USER="IS_APPROVED_USER";
  static const PREF_IS_NOTIFICATIONS_SOUND_ACTIVATED="PREF_IS_NOTIFICATIONS_SOUND_ACTIVATED";
  static const pref_master_data_version="pref_master_data_version";
  static const language_code="language_code";
  static const LAST_CHECK_DATE = "last_check_date";
  static const LAST_HANDLED_NOTIFICATION = "lni";
  static const INVITE_REFERRAL_CODE = "refCode";

  static init() async {
    _initCalled = true;
    await getInstance();
  }

  static void dispose() {
    _prefsInstance = null;
  }

  static Future<SharedPreferences> getInstance() async {
    if (_prefsInstance == null)
      _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  static setString(String key, String value) async {
    _prefsInstance = await getInstance();
    _prefsInstance.setString(key, value);
  }

  static setInt(String key, int value) async {
    _prefsInstance = await getInstance();
    _prefsInstance.setInt(key, value);
  }

  static Future<int> getInt(String key) async {
    await getInstance();
    return _prefsInstance.getInt(key) == null
        ? null
        : _prefsInstance.getInt(key);
  }

  static int getIntWithDefValue(String key,{defaultValue = 0}) {
    try {
      return _prefsInstance.getInt(key) ?? defaultValue;
    }catch(ex){return defaultValue;}
  }

  static setBoolean(String key, bool value) async {
    _prefsInstance = await getInstance();
    _prefsInstance.setBool(key, value);
  }

  static Future<dynamic> getPrefValue(String key) async {
    var retVal = await getInstance();
    return _prefsInstance.get(key);
  }

  static String getString(String key) {
    try {
      return _prefsInstance.getString(key);
    }catch(ex){return "";}
  }

  static Future<String> getStringAsync(String key) async{
    try {
      return _prefsInstance.getString(key);
    }catch(ex){return "";}
  }

  static Future<String> getContactId(String key) async{
    try {
      return _prefsInstance.getString(key);
    }catch(ex){return "";}
  }

  static Future<String> getFcmToken() async{
    try {
      return _prefsInstance.getString(Prefs.PREF_DEVICE_TOKEN);
    }catch(ex){return "";}
  }

  static String getStringWithDefaultValue(String key,{defaultValue=""}) {
    try {
      return _prefsInstance.getString(key)??defaultValue;
    }catch(ex){return defaultValue;}
  }

  static Future<bool> getBool(String key, {defaultValue=false}) async {
    _prefsInstance = _prefsInstance == null ? await getInstance() : _prefsInstance;
    return _prefsInstance.getBool(key) ?? defaultValue;
  }

  static bool getBoolean(String key, {defaultValue=false})  {
    try {
      return _prefsInstance.getBool(key)??defaultValue;
    }catch(ex){return defaultValue;}

  }

  static Future<bool> remove(String key) async {
    var retVal = await getInstance();
    return _prefsInstance.remove(key);
  }

  static Future<bool> clear() async {
    var retVal = await getInstance();
    return _prefsInstance.clear();
  }

  static saveLastCheckedDate() async{
    _prefsInstance = await getInstance();
    _prefsInstance.setInt(LAST_CHECK_DATE, DateTime.now().millisecondsSinceEpoch);
  }
}
