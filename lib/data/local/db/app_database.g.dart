// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final database = _$AppDatabase();
    database.database = await database.open(
      name ?? ':memory:',
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  GoodsTypeDao _goodsTypeDaoInstance;

  DistrictDao _districtDaoInstance;

  TruckTypeDao _truckTypeDaoInstance;

  CustomerTripCancelReasonDao _customerTripCancelReasonDaoInstance;

  TruckSizeDao _truckSizeDaoInstance;

  TruckDimensionLengthDao _truckDimensionLengthDaoInstance;

  TruckDimensionWidthDao _truckDimensionWidthDaoInstance;

  TruckDimensionHeightDao _truckDimensionHeightDaoInstance;

  UserTimeSpentDao _userTimeSpentDaoInstance;

  Future<sqflite.Database> open(String name, List<Migration> migrations,
      [Callback callback]) async {
    final path = join(await sqflite.getDatabasesPath(), name);

    return sqflite.openDatabase(
      path,
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `goodsType` (`id` INTEGER, `text` TEXT, `image` TEXT, `textBn` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `districtCodes` (`id` INTEGER, `text` TEXT, `image` TEXT, `textBn` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `truckType` (`id` INTEGER, `text` TEXT, `textBn` TEXT, `image` TEXT, `sequence` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `customerTripCancelReason` (`id` INTEGER, `value` TEXT, `valueBn` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TruckSize` (`id` INTEGER, `size` REAL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TruckDimensionLength` (`id` INTEGER, `value` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TruckDimensionWidth` (`id` INTEGER, `value` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TruckDimensionHeight` (`id` INTEGER, `value` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserTimeSpent` (`timeIn` TEXT, `timeOut` TEXT, `date` TEXT, PRIMARY KEY (`timeIn`))');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  GoodsTypeDao get goodsTypeDao {
    return _goodsTypeDaoInstance ??= _$GoodsTypeDao(database, changeListener);
  }

  @override
  DistrictDao get districtDao {
    return _districtDaoInstance ??= _$DistrictDao(database, changeListener);
  }

  @override
  TruckTypeDao get truckTypeDao {
    return _truckTypeDaoInstance ??= _$TruckTypeDao(database, changeListener);
  }

  @override
  CustomerTripCancelReasonDao get customerTripCancelReasonDao {
    return _customerTripCancelReasonDaoInstance ??=
        _$CustomerTripCancelReasonDao(database, changeListener);
  }

  @override
  TruckSizeDao get truckSizeDao {
    return _truckSizeDaoInstance ??= _$TruckSizeDao(database, changeListener);
  }

  @override
  TruckDimensionLengthDao get truckDimensionLengthDao {
    return _truckDimensionLengthDaoInstance ??=
        _$TruckDimensionLengthDao(database, changeListener);
  }

  @override
  TruckDimensionWidthDao get truckDimensionWidthDao {
    return _truckDimensionWidthDaoInstance ??=
        _$TruckDimensionWidthDao(database, changeListener);
  }

  @override
  TruckDimensionHeightDao get truckDimensionHeightDao {
    return _truckDimensionHeightDaoInstance ??=
        _$TruckDimensionHeightDao(database, changeListener);
  }

  @override
  UserTimeSpentDao get userTimeSpentDao {
    return _userTimeSpentDaoInstance ??=
        _$UserTimeSpentDao(database, changeListener);
  }
}

class _$GoodsTypeDao extends GoodsTypeDao {
  _$GoodsTypeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _goodsTypeInsertionAdapter = InsertionAdapter(
            database,
            'goodsType',
            (GoodsType item) => <String, dynamic>{
                  'id': item.id,
                  'text': item.text,
                  'image': item.image,
                  'textBn': item.textBn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _goodsTypeMapper = (Map<String, dynamic> row) => GoodsType(
      row['id'] as int,
      row['text'] as String,
      row['image'] as String,
      row['textBn'] as String);

  final InsertionAdapter<GoodsType> _goodsTypeInsertionAdapter;

  @override
  Future<List<GoodsType>> getAll() async {
    return _queryAdapter.queryList('SELECT * from goodsType',
        mapper: _goodsTypeMapper);
  }

  @override
  Future<GoodsType> findGoodsBanglaName(String engName) async {
    return _queryAdapter.query('SELECT * from goodsType where text = ?',
        arguments: <dynamic>[engName], mapper: _goodsTypeMapper);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE from goodsType');
  }

  @override
  Future<void> insertAll(List<GoodsType> goodTypes) async {
    await _goodsTypeInsertionAdapter.insertList(
        goodTypes, sqflite.ConflictAlgorithm.replace);
  }
}

class _$DistrictDao extends DistrictDao {
  _$DistrictDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _districtCodeInsertionAdapter = InsertionAdapter(
            database,
            'districtCodes',
            (DistrictCode item) => <String, dynamic>{
                  'id': item.id,
                  'text': item.text,
                  'image': item.image,
                  'textBn': item.textBn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _districtCodesMapper = (Map<String, dynamic> row) =>
      DistrictCode(row['id'] as int, row['text'] as String,
          row['image'] as String, row['textBn'] as String);

  final InsertionAdapter<DistrictCode> _districtCodeInsertionAdapter;

  @override
  Future<List<DistrictCode>> getAll() async {
    return _queryAdapter.queryList('SELECT * from districtCodes',
        mapper: _districtCodesMapper);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE from districtCodes');
  }

  @override
  Future<void> insertAll(List<DistrictCode> districts) async {
    await _districtCodeInsertionAdapter.insertList(
        districts, sqflite.ConflictAlgorithm.replace);
  }
}

class _$TruckTypeDao extends TruckTypeDao {
  _$TruckTypeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _truckTypeInsertionAdapter = InsertionAdapter(
            database,
            'truckType',
            (TruckType item) => <String, dynamic>{
                  'id': item.id,
                  'text': item.text,
                  'textBn': item.textBn,
                  'image': item.image,
                  'sequence': item.sequence
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _truckTypeMapper = (Map<String, dynamic> row) => TruckType(
      row['id'] as int,
      row['text'] as String,
      row['textBn'] as String,
      row['image'] as String,
      row['sequence'] as int);

  final InsertionAdapter<TruckType> _truckTypeInsertionAdapter;

  @override
  Future<List<TruckType>> getAll() async {
    return _queryAdapter.queryList('SELECT * from truckType',
        mapper: _truckTypeMapper);
  }

  @override
  Future<TruckType> findTruckBanglaName(String engName) async {
    return _queryAdapter.query('SELECT * from truckType where text = ?',
        arguments: <dynamic>[engName], mapper: _truckTypeMapper);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE from truckType');
  }

  @override
  Future<void> insertAll(List<TruckType> items) async {
    await _truckTypeInsertionAdapter.insertList(
        items, sqflite.ConflictAlgorithm.replace);
  }
}

class _$CustomerTripCancelReasonDao extends CustomerTripCancelReasonDao {
  _$CustomerTripCancelReasonDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _customerTripCancelReasonInsertionAdapter = InsertionAdapter(
            database,
            'customerTripCancelReason',
            (CustomerTripCancelReason item) => <String, dynamic>{
                  'id': item.id,
                  'value': item.value,
                  'valueBn': item.valueBn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _customerTripCancelReasonMapper = (Map<String, dynamic> row) =>
      CustomerTripCancelReason(
          row['id'] as int, row['value'] as String, row['valueBn'] as String);

  final InsertionAdapter<CustomerTripCancelReason>
      _customerTripCancelReasonInsertionAdapter;

  @override
  Future<List<CustomerTripCancelReason>> getAll() async {
    return _queryAdapter.queryList('SELECT * from customerTripCancelReason',
        mapper: _customerTripCancelReasonMapper);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE from customerTripCancelReason');
  }

  @override
  Future<void> insertAll(List<CustomerTripCancelReason> items) async {
    await _customerTripCancelReasonInsertionAdapter.insertList(
        items, sqflite.ConflictAlgorithm.replace);
  }
}

class _$TruckSizeDao extends TruckSizeDao {
  _$TruckSizeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _truckSizeInsertionAdapter = InsertionAdapter(
            database,
            'TruckSize',
            (TruckSize item) =>
                <String, dynamic>{'id': item.id, 'size': item.size});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _truckSizeMapper = (Map<String, dynamic> row) =>
      TruckSize(row['id'] as int, row['size'] as double);

  final InsertionAdapter<TruckSize> _truckSizeInsertionAdapter;

  @override
  Future<List<TruckSize>> getAll() async {
    return _queryAdapter.queryList('SELECT * from TruckSize',
        mapper: _truckSizeMapper);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE from TruckSize');
  }

  @override
  Future<void> insertAll(List<TruckSize> items) async {
    await _truckSizeInsertionAdapter.insertList(
        items, sqflite.ConflictAlgorithm.replace);
  }
}

class _$TruckDimensionLengthDao extends TruckDimensionLengthDao {
  _$TruckDimensionLengthDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _truckDimensionLengthInsertionAdapter = InsertionAdapter(
            database,
            'TruckDimensionLength',
            (TruckDimensionLength item) =>
                <String, dynamic>{'id': item.id, 'value': item.value});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _truckDimensionLengthMapper = (Map<String, dynamic> row) =>
      TruckDimensionLength(row['id'] as int, row['value'] as String);

  final InsertionAdapter<TruckDimensionLength>
      _truckDimensionLengthInsertionAdapter;

  @override
  Future<List<TruckDimensionLength>> getAll() async {
    return _queryAdapter.queryList('SELECT * from TruckDimensionLength',
        mapper: _truckDimensionLengthMapper);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE from TruckDimensionLength');
  }

  @override
  Future<void> insertAll(List<TruckDimensionLength> items) async {
    await _truckDimensionLengthInsertionAdapter.insertList(
        items, sqflite.ConflictAlgorithm.replace);
  }
}

class _$TruckDimensionWidthDao extends TruckDimensionWidthDao {
  _$TruckDimensionWidthDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _truckDimensionWidthInsertionAdapter = InsertionAdapter(
            database,
            'TruckDimensionWidth',
            (TruckDimensionWidth item) =>
                <String, dynamic>{'id': item.id, 'value': item.value});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _truckDimensionWidthMapper = (Map<String, dynamic> row) =>
      TruckDimensionWidth(row['id'] as int, row['value'] as String);

  final InsertionAdapter<TruckDimensionWidth>
      _truckDimensionWidthInsertionAdapter;

  @override
  Future<List<TruckDimensionWidth>> getAll() async {
    return _queryAdapter.queryList('SELECT * from TruckDimensionWidth',
        mapper: _truckDimensionWidthMapper);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE from TruckDimensionWidth');
  }

  @override
  Future<void> insertAll(List<TruckDimensionWidth> items) async {
    await _truckDimensionWidthInsertionAdapter.insertList(
        items, sqflite.ConflictAlgorithm.replace);
  }
}

class _$TruckDimensionHeightDao extends TruckDimensionHeightDao {
  _$TruckDimensionHeightDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _truckDimensionHeightInsertionAdapter = InsertionAdapter(
            database,
            'TruckDimensionHeight',
            (TruckDimensionHeight item) =>
                <String, dynamic>{'id': item.id, 'value': item.value});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _truckDimensionHeightMapper = (Map<String, dynamic> row) =>
      TruckDimensionHeight(row['id'] as int, row['value'] as String);

  final InsertionAdapter<TruckDimensionHeight>
      _truckDimensionHeightInsertionAdapter;

  @override
  Future<List<TruckDimensionHeight>> getAll() async {
    return _queryAdapter.queryList('SELECT * from TruckDimensionHeight',
        mapper: _truckDimensionHeightMapper);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE from TruckDimensionHeight');
  }

  @override
  Future<void> insertAll(List<TruckDimensionHeight> items) async {
    await _truckDimensionHeightInsertionAdapter.insertList(
        items, sqflite.ConflictAlgorithm.replace);
  }
}

class _$UserTimeSpentDao extends UserTimeSpentDao {
  _$UserTimeSpentDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userTimeSpentInsertionAdapter = InsertionAdapter(
            database,
            'UserTimeSpent',
            (UserTimeSpent item) => <String, dynamic>{
                  'timeIn': item.timeIn,
                  'timeOut': item.timeOut,
                  'date': item.date
                }),
        _userTimeSpentUpdateAdapter = UpdateAdapter(
            database,
            'UserTimeSpent',
            ['timeIn'],
            (UserTimeSpent item) => <String, dynamic>{
                  'timeIn': item.timeIn,
                  'timeOut': item.timeOut,
                  'date': item.date
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _userTimeSpentMapper = (Map<String, dynamic> row) =>
      UserTimeSpent(row['timeIn'] as String, row['timeOut'] as String,
          row['date'] as String);

  final InsertionAdapter<UserTimeSpent> _userTimeSpentInsertionAdapter;

  final UpdateAdapter<UserTimeSpent> _userTimeSpentUpdateAdapter;

  @override
  Future<List<UserTimeSpent>> getAll() async {
    return _queryAdapter.queryList('SELECT * from UserTimeSpent',
        mapper: _userTimeSpentMapper);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE from UserTimeSpent');
  }

  @override
  Future<void> insert(UserTimeSpent userTimeSpent) async {
    await _userTimeSpentInsertionAdapter.insert(
        userTimeSpent, sqflite.ConflictAlgorithm.replace);
  }

  @override
  Future<void> update(UserTimeSpent userTimeSpent) async {
    await _userTimeSpentUpdateAdapter.update(
        userTimeSpent, sqflite.ConflictAlgorithm.abort);
  }
}
