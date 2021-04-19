import 'package:customer/bloc/base_bloc.dart';
import 'package:customer/core/localization/AppTranslation.dart';
import 'package:customer/utils/common_utils.dart';
import 'package:floor/floor.dart';
import 'app_database.dart';
import 'package:synchronized/synchronized.dart';


Future<AppDatabase> getDatabase() async{

  print("create Database");

  // create migration
  final migration1to2 = Migration(1, 2, (database) {
    database.execute('CREATE TABLE IF NOT EXISTS `UserTimeSpent` (`timeIn` '
        'TEXT, `timeOut` TEXT, `date` TEXT, PRIMARY KEY (`timeIn`))');
  });

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db')
      .addMigrations([migration1to2])
      .build();
  return database;
}

class DatabaseHelper{

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  final _lock = new Lock();
  static var _database;
  static var isClosed=true;
  Future<AppDatabase> get database async {
    if (_database == null || isClosed) {
      await _lock.synchronized(() async {
        // Check again once entering the synchronized block
        if (_database == null || isClosed) {
          _database = await getDatabase();
          isClosed=false;

        }
      });
    }
    return _database;
  }


}



openDatabase(){
  return DatabaseHelper.instance.database;
}

closeDatabase() async {
  var db=await DatabaseHelper.instance.database;
  await db?.close();
  DatabaseHelper.isClosed=true;
}

filterInBanglaGoodsType(goodsList,{isTrip=true,BaseBloc bloc})async{
  if(isNullOrEmptyList(goodsList)) return;
  for(var item in goodsList){
    var searchText=isTrip?item.goodsType:item.text;
    if(searchText.isNotEmpty){
      AppDatabase dbItem=await openDatabase();
      var searchedItem=await dbItem.goodsTypeDao.findGoodsBanglaName(searchText);
      if(searchedItem!=null && !isNullOrEmpty(searchedItem.textBn)){
        if(isTrip)
          item.goodsTypeInBn=searchedItem.textBn;
        else
        item.text=searchedItem.textBn;
      }
    }

  }
  bloc?.notifyListeners();
}
filterInBanglaTruckType(trucktypeList,{isTrip=true,BaseBloc bloc})async{
  if(isNullOrEmptyList(trucktypeList)) return;
  for(var item in trucktypeList){
    if(isTrip && isNullOrEmpty(item.truckType)) continue;
    var searchText=isTrip?item.truckType:item.text;
    if(searchText.isNotEmpty){
      AppDatabase dbItem = await openDatabase();
      var searchedItem=await dbItem.truckTypeDao.findTruckBanglaName(searchText);
      if(searchedItem!=null && !isNullOrEmpty(searchedItem.textBn)){
        if(isTrip)
          item.truckTypeInBn = searchedItem.textBn;
        else
        item.text=searchedItem.textBn;
      }
    }

  }
  bloc?.notifyListeners();

}