import 'package:customer/data/local/db/customer_trip_cancel_reason.dart' as prefix0;
import 'package:customer/data/local/db/district.dart';
import 'package:customer/data/local/db/goods_type.dart';
import 'package:customer/data/local/db/stats.dart';
import 'package:customer/data/local/db/truck_size.dart';
import 'package:customer/data/local/db/truck_types.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
import 'package:path/path.dart';
import 'TruckDimension.dart';
import 'customer_trip_cancel_reason.dart';
part 'app_database.g.dart';

@Database(version: 2, entities: [GoodsType,DistrictCode,TruckType,
  CustomerTripCancelReason,TruckSize,TruckDimensionLength,
  TruckDimensionWidth,TruckDimensionHeight,UserTimeSpent])
abstract class AppDatabase extends FloorDatabase{
  GoodsTypeDao get goodsTypeDao;
  DistrictDao get districtDao;
  TruckTypeDao get truckTypeDao;
  CustomerTripCancelReasonDao get customerTripCancelReasonDao;
  TruckSizeDao get truckSizeDao;
  TruckDimensionLengthDao get truckDimensionLengthDao;
  TruckDimensionWidthDao get truckDimensionWidthDao;
  TruckDimensionHeightDao get truckDimensionHeightDao;
  UserTimeSpentDao get userTimeSpentDao;
}


