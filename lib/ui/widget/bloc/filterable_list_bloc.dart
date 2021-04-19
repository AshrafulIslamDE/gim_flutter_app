import 'package:customer/data/local/db/goods_type.dart';
import 'package:customer/networking/api_response.dart';
import 'package:customer/ui/create_trip/repo/create_trip_repo.dart';
import 'package:flutter/material.dart';
import 'package:customer/data/local/db/database_controller.dart';

class FilterableListBloc with ChangeNotifier {
  List items;

  FilterableListBloc() {
    initItems();
  }

  initItems() {
    getDatabase().then((database) {
      database.goodsTypeDao.getAll().then((tog) {
        items = tog;
        notifyListeners();
      });
    });
  }

  filterLcNumber(filter) async {
    if (filter == null) return;
    var response = await CreateTripRepo.lcNumber(filter);
    if (response.status == Status.COMPLETED) {
      items = response.data;
    }
  }
}
