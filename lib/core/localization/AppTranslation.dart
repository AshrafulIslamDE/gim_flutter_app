import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:customer/flavor/flavor_config.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/prefs.dart';
import 'package:customer/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

class AppTranslations {
  Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  AppTranslations(Locale locale) {
    this.locale = locale;
  }

  static AppTranslations of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations);
  }

  static Future<AppTranslations> load(Locale locale) async {
    AppTranslations appTranslations = AppTranslations(locale);
    String jsonContent = await rootBundle.loadString("locale/localization_${locale.languageCode}.json");
    _localisedValues = json.decode(jsonContent);
    return appTranslations;
  }

  get currentLanguage => locale.languageCode;


  String text(String key) {
    return _localisedValues[key] ?? "$key not found";
  }
  String dynamicParam(String key,String dynamicValue,{symbol='%d'}) {
   // if(isNullOrEmpty(dynamicValue))dynamicValue="";
    try {
      if (_localisedValues[key] == null||isNullOrEmpty(dynamicValue))
        return _localisedValues[key] ?? "$key not found";
      String value = _localisedValues[key];
      var f = NumberFormat('###', Prefs.getString(Prefs.language_code));
      if(symbol=='%d')
      value = value.replaceAll(symbol, f.format(int.parse(dynamicValue)));
      else if(symbol=='%f') {
        f=NumberFormat('###.0',Prefs.getString(Prefs.language_code));
        value = value.replaceAll(symbol, f.format(double.parse(dynamicValue)));
       // print(value);
      }
      return value;
    }catch(ex){
      return _localisedValues[key] ?? "$key not found";
    }
  }
}

String translate(BuildContext context,tag,{String dynamicValue}){
  if(!isNullOrEmpty(dynamicValue)) return AppTranslations.of(context).dynamicParam(tag, dynamicValue);
  try {
  return  AppTranslations.of(context).text(tag);
  }catch(ex){
   return tag;
  }
}
String localize(tag,{context,String dynamicValue,symbol="%d"}){
  if(!isNullOrEmpty(dynamicValue)) return AppTranslations.of(context??getGlobalContext()).dynamicParam(tag, dynamicValue,symbol: symbol);
  return AppTranslations.of(getGlobalContext()).text(tag);
}

String languageCode(){
  return Prefs.getStringWithDefaultValue(Prefs.language_code,defaultValue: "en");
}
bool isBangla(){
  return  languageCode()=="bn";
}