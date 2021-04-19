import 'package:customer/data/local/db/district.dart';

import 'sqf_entity_provider.dart';


class DbManager extends SqfEntityModel {
  DbManager() {
    databaseName = "gim.db";
   // databaseTables = [DistrictCode.instance];
    bundledDatabasePath = null;
  }
}