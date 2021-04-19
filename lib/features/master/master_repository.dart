
import 'package:customer/data/local/db/TruckDimension.dart';
import 'package:customer/data/local/db/customer_trip_cancel_reason.dart';
import 'package:customer/data/local/db/database_controller.dart';
import 'package:customer/data/local/db/district.dart';
import 'package:customer/data/local/db/goods_type.dart';
import 'package:customer/data/local/db/truck_size.dart';
import 'package:customer/data/local/db/truck_types.dart';

class MasterRepository{
  //static var  localDb=openDatabase();
  static Future<List<DistrictCode>>getAllDistrict()async{
   var  localDb=await openDatabase();
   var list =await localDb.districtDao.getAll();
   return list;
  }

  static Future<List<CustomerTripCancelReason>> getCancelReasons()async{
    var  localDb=await openDatabase();
    var list =await localDb.customerTripCancelReasonDao.getAll();
    return list;
  }

  static Future<List<TruckType>> getTruckTypes()async{
    var  localDb=await openDatabase();
    var list =await localDb.truckTypeDao.getAll();
    return list;
  }

  static Future<List<TruckSize>> getTruckSizes()async{
    var  localDb=await openDatabase();
    var list =await localDb.truckSizeDao.getAll();
    return list;
  }

  static Future<List<TruckDimensionWidth>> getTruckWidth()async{
    var  localDb=await openDatabase();
    var list =await localDb.truckDimensionWidthDao.getAll();
    return list;
  }

  static Future<List<TruckDimensionLength>> getTruckLength()async{
    var  localDb=await openDatabase();
    var list =await localDb.truckDimensionLengthDao.getAll();
    return list;
  }

  static Future<List<TruckDimensionHeight>> getTruckHeight()async{
    var  localDb=await openDatabase();
    var list =await localDb.truckDimensionHeightDao.getAll();
    return list;
  }

  static Future<List<GoodsType>> getGoodsType()async{
    var  localDb=await openDatabase();
    var list =await localDb.goodsTypeDao.getAll();
    return list;
  }

}

