import 'package:customer/data/local/db/app_database.dart';
import 'package:customer/data/local/db/database_controller.dart';
import 'package:customer/data/local/db/stats.dart';
import 'package:customer/data/repository/common_repository.dart';
import 'package:customer/model/stats/stats_request.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/utils/prefs.dart';
import 'package:intl/intl.dart';

import 'common_utils.dart';
import 'date_time_utils.dart';

getServerTime() async {
  if (await waitForToken() == null) {
    return;
  }
  ApiResponse apiResponse = await CommonRepository.serverTime();

  if (isApiError(apiResponse)) {
    print('api error');
    return;
  }

  final serverTime = int.parse(apiResponse.data.toString());
  final dateTime = DateTime.fromMillisecondsSinceEpoch(serverTime, isUtc: true);
  print('server time $dateTime');
  final df = DateFormat(ISOFormat);
  var timeIn = df.format(dateTime);
  var logDate = df.format(DateTime(dateTime.year, dateTime.month, dateTime
      .day));

  AppDatabase localDb = await getDatabase();

  localDb.userTimeSpentDao.insert(UserTimeSpent(timeIn, null, logDate));
  print('User stats inserted to DB');
}

getServerTimeAndPostUserStats() async {
  if (await waitForToken() == null) {
    return;
  }
  ApiResponse apiResponse = await CommonRepository.serverTime();

  if (isApiError(apiResponse)) {
    print('api error');
    return;
  }

  final serverTime = int.parse(apiResponse.data.toString());
  final dateTime = DateTime.fromMillisecondsSinceEpoch(serverTime, isUtc: true);
  print('server time $dateTime');
  final df = DateFormat(ISOFormat);
  var timeOut = df.format(dateTime);

  AppDatabase localDb = await getDatabase();
  var list = await localDb.userTimeSpentDao.getAll();

  print('list size ${list.length}');

  if (list.isNotEmpty) {
    var userTimeSpent = list[list.length - 1];
    userTimeSpent.timeOut = timeOut;

    //Update timeOut in DB
    localDb.userTimeSpentDao.update(userTimeSpent);
    print('User stats updated to DB');

    var requestList = UserTimeSpentRequestList(userAppTimeBatchs: List());

    for (UserTimeSpent item in list) {
      if (item.timeOut == null) continue;
      requestList.userAppTimeBatchs.add(UserTimeSpent(item.timeIn, item
          .timeOut, item.date));
    }

    var response = await CommonRepository.appTime(requestList);

    if (isApiError(response)) {
      print('api error');
      return;
    }

    localDb.userTimeSpentDao.deleteAll();
    print('User stats updated to server');
  }
}

Future<String> waitForToken() async {
  var token = Prefs.getString(Prefs.token);
  var counter = 1;
  while (isNullOrEmpty(token) && counter < 4) {
    print('authtoekn not found, retry $counter');
    await Future.delayed(Duration(milliseconds: 300));
    counter++;
    token = Prefs.getString(Prefs.token);
  }
  return token;
}

bool isApiError(ApiResponse response) =>
    response == null || response.status == Status.ERROR;
