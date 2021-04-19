import 'dart:convert';
import 'dart:io';

import 'package:customer/networking/background_process.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:customer/utils/prefs.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FireBaseRemoteConfig{
  static final  masterDataVersion = "master_data_version";
  static final paymentIds = 'customer_payment_ids';
  static final optUpdateVersion = Platform.isIOS ? 'optl_update_iOS_customer' : 'optl_update_android_customer';
  static final forceUpdateVersion = Platform.isIOS ? 'force_update_iOS_customer' : 'force_update_version_customer';

  RemoteConfig _remoteConfig;
  List<String> _paymentIdsList;

  FireBaseRemoteConfig._privateConstructor();

  _initConfiguration() async{
    try {
      _remoteConfig = await RemoteConfig.instance;
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
      await _remoteConfig.fetch(expiration: const Duration(seconds: 5));
      await _remoteConfig.activateFetched();
    }on Exception catch(ex){
      print(ex.toString());
      return;
    }
  }

   getRemoteConfigValue()async{
    try {
      if (_remoteConfig == null)
        await _initConfiguration();
      var allRemoteVal = _remoteConfig.getAll();
      _setPaymentIds(allRemoteVal);
      var optVersion = allRemoteVal[optUpdateVersion];
      var manVersion = allRemoteVal[forceUpdateVersion];
      Prefs.setInt(optUpdateVersion, isNullOrEmpty(optVersion?.asString()) ? 0 : optVersion.asInt());
      Prefs.setInt(forceUpdateVersion, isNullOrEmpty(manVersion?.asString()) ? 0 : manVersion.asInt());
      return allRemoteVal;
    }on Exception catch(ex){
      print('Error in fetching firebase config $ex');
      return null;
    }
  }

  syncMasterData() async{
    int localDbVersion  = await Prefs.getInt(Prefs.pref_master_data_version);
    var remoteDbVersion = ((await getRemoteConfigValue())[masterDataVersion])?.asInt() ?? 0;
    if(localDbVersion == null ||  localDbVersion < remoteDbVersion)
      getMasterDataUsingNativeProcess(master_data_version: remoteDbVersion);
  }

  static final FireBaseRemoteConfig _instance = FireBaseRemoteConfig._privateConstructor();

  static FireBaseRemoteConfig get instance => _instance;

  factory FireBaseRemoteConfig(){
    return _instance;
  }

  _setPaymentIds(Map allRemoteVal) async{
    var paymentIdsList = allRemoteVal[paymentIds];
    var listOfPaymentIds = jsonDecode(paymentIdsList?.asString() ?? '{"data":[]}')['data'];
    _paymentIdsList = listOfPaymentIds != null ? List.from(listOfPaymentIds) : null;
  }

  setPaymentId(contactId) async{
    isNullOrEmptyList(_paymentIdsList) || _paymentIdsList.indexOf(contactId) == -1 ?
      Prefs.setBoolean(Prefs.IS_PAY_ID,false) : Prefs.setBoolean(Prefs.IS_PAY_ID,true);
  }

}