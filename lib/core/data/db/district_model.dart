import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'db_manager.dart';
import 'sqf_entity_provider.dart';

// region Code
class Code {
  // FIELDS
  int pid;
  int id;
  String text;
  String textBn;
  // end FIELDS


  static const bool _softDeleteActivated=false;
  CodeManager __mnCode;
  CodeFilterBuilder _select;

  CodeManager get _mnCode {
    if (__mnCode == null) __mnCode = new CodeManager();
    return __mnCode;
  }

  Code({this.pid, this.id,this.text,this.textBn}) { setDefaultValues();}
  Code.withFields(this.id,this.text,this.textBn){ setDefaultValues();}
  Code.withId(this.pid, this.id,this.text,this.textBn){ setDefaultValues();}

  // methods
  Map<String, dynamic> toMap({bool forQuery=false}) {
    var map = Map<String, dynamic>();
    if (pid != null) map["pid"] = pid;    if (id != null) map["id"] = id;
    if (text != null) map["text"] = text;
    if (textBn != null) map["textBn"] = textBn;

    return map;
  }

  Code.fromMap(Map<String, dynamic> o) {
    this.pid = o["pid"];
    this.id = o["id"];
    this.text = o["text"];
    this.textBn = o["textBn"];

  }

  List<dynamic> toArgs() {
    return[pid,id,text,textBn];
  }


  static fromWebUrl(String url, VoidCallback  codeList (List<Code> o)) async {
    var objList = List<Code>();
    http.get(url).then((response) {
      Iterable list = json.decode(response.body);
      try {
        objList = list.map((code) => Code.fromMap(code)).toList();
        codeList(objList);
      } catch (e) {
        print("SQFENTITY ERROR Code.fromWeb: ErrorMessage:" + e.toString());
      }
    });
  }

  static Future<List<Code>> fromObjectList(Future<List<dynamic>> o) async {
    var codesList = new List<Code>();
    o.then((data) {
      for (int i = 0; i < data.length; i++) {
        codesList.add(Code.fromMap(data[i]));
      }
    });
    return codesList;
  }

  static List<Code> fromMapList(List<Map<String, dynamic>> query) {
    List<Code> codes = List<Code>();
    for (Map map in query) {
      codes.add(Code.fromMap(map));
    }
    return codes;
  }

  /// returns Code by ID if exist, otherwise returns null
  /// <param name="pid">Primary Key Value</param>
  /// <returns>returns Code if exist, otherwise returns null</returns>
  getById(int pid, VoidCallback code(Code o)) {
    Code codeObj;
    var codeFuture = _mnCode.getById(pid);
    codeFuture.then((data) {
      if (data.length > 0)
        codeObj = Code.fromMap(data[0]);
      else
        codeObj = null;
      code(codeObj);
    });
  }

  /// <summary>
  /// Saves the object. If the pid field is null, saves as a new record and returns new pid, if pid is not null then updates record
  /// </summary>
  /// <returns>Returns pid</returns>
  Future<int> save() async {
    if (pid == null || pid == 0)
      pid = await _mnCode.insert(
          Code.withFields(id,text,textBn));
    else
      pid= await _upsert();
    return pid;
  }

  /// <summary>
  /// saveAll method saves the sent List<Code> as a batch in one transaction
  /// </summary>
  /// <returns> Returns a <List<BoolResult>> </returns>
  Future<List<BoolResult>> saveAll(List<Code> codes) async {
    var results = _mnCode.saveAll("INSERT OR REPLACE INTO code (pid, id,text,textBn)  VALUES (?,?,?,?)",codes);
    return results;
  }

  /// <summary>
  /// Updates if the record exists, otherwise adds a new row
  /// </summary>
  /// <returns>Returns pid</returns>
  Future<int> _upsert() async {
    pid = await _mnCode.rawInsert(
        "INSERT OR REPLACE INTO code (pid, id,text,textBn)  VALUES (?,?,?,?)", [pid,id,text,textBn]);
    return pid;
  }


  /// <summary>
  /// inserts or replaces the sent List<Todo> as a batch in one transaction.
  /// upsertAll() method is faster then saveAll() method. upsertAll() should be used when you are sure that the primary key is greater than zero
  /// </summary>
  /// <returns> Returns a <List<BoolResult>> </returns>
  Future<List<BoolResult>> upsertAll(List<Code> codes) async {
    var results = await _mnCode.rawInsertAll(
        "INSERT OR REPLACE INTO code (pid, id,text,textBn)  VALUES (?,?,?,?)", codes);
    return results;
  }


  /// <summary>
  /// saveAs Code. Returns a new Primary Key value of Code
  /// </summary>
  /// <returns>Returns a new Primary Key value of Code</returns>
  Future<int> saveAs() async {
    pid = await _mnCode.insert(
        Code.withFields(id,text,textBn));
    return pid;
  }


  /// <summary>
  /// Deletes Code
  /// </summary>
  /// <returns>BoolResult res.success=Deleted, not res.success=Can not deleted</returns>
  Future<BoolResult> delete() async {
    print("SQFENTITIY: delete Code invoked (pid=$pid)");
    if (!_softDeleteActivated)
      return _mnCode.delete(QueryParams(whereString: "pid=$pid"));
    else
      return _mnCode.updateBatch(QueryParams(whereString: "pid=$pid"), {"isDeleted": 1});
  }

  //private CodeFilterBuilder _Select;
  CodeFilterBuilder select(
      {List<String> columnsToSelect, bool getIsDeleted}) {
    _select = new CodeFilterBuilder(this);
    _select._getIsDeleted = getIsDeleted==true;
    _select.qparams.selectColumns = columnsToSelect;
    return _select;
  }

  CodeFilterBuilder distinct(
      {List<String> columnsToSelect, bool getIsDeleted}) {
    CodeFilterBuilder _distinct = new CodeFilterBuilder(this);
    _distinct._getIsDeleted = getIsDeleted==true;
    _distinct.qparams.selectColumns = columnsToSelect;
    _distinct.qparams.distinct = true;
    return _distinct;
  }

  void setDefaultValues() {

  }
//end methods
}
// endregion code


// region CodeField
class CodeField extends SearchCriteria {
  DbParameter param;
  String _waitingNot = "";
  CodeFilterBuilder codeFB;
  CodeField(CodeFilterBuilder fb) {
    param = new DbParameter();
    codeFB = fb;
  }
  CodeField get not {
    _waitingNot = " NOT ";
    return this;
  }
  CodeFilterBuilder equals(var pValue) {
    param.expression = "=";
    codeFB._addedBlocks = _waitingNot == ""
        ? setCriteria(pValue, codeFB.parameters, param, SqlSyntax.EQuals,
        codeFB._addedBlocks)
        : setCriteria(pValue, codeFB.parameters, param, SqlSyntax.NotEQuals,
        codeFB._addedBlocks);
    _waitingNot = "";
    codeFB._addedBlocks.needEndBlock[codeFB._blockIndex] =
        codeFB._addedBlocks.retVal;
    return codeFB;
  }
  CodeFilterBuilder isNull() {
    codeFB._addedBlocks = setCriteria(
        0,
        codeFB.parameters,
        param,
        SqlSyntax.IsNULL.replaceAll(SqlSyntax.NOT_KEYWORD, _waitingNot),
        codeFB._addedBlocks);
    _waitingNot = "";
    codeFB._addedBlocks.needEndBlock[codeFB._blockIndex] =
        codeFB._addedBlocks.retVal;
    return codeFB;
  }
  CodeFilterBuilder contains(dynamic pValue) {
    codeFB._addedBlocks = setCriteria(
        "%" + pValue + "%",
        codeFB.parameters,
        param,
        SqlSyntax.Contains.replaceAll(SqlSyntax.NOT_KEYWORD, _waitingNot),
        codeFB._addedBlocks);
    _waitingNot = "";
    codeFB._addedBlocks.needEndBlock[codeFB._blockIndex] =
        codeFB._addedBlocks.retVal;
    return codeFB;
  }
  CodeFilterBuilder startsWith(dynamic pValue) {
    codeFB._addedBlocks = setCriteria(
        pValue + "%",
        codeFB.parameters,
        param,
        SqlSyntax.Contains.replaceAll(SqlSyntax.NOT_KEYWORD, _waitingNot),
        codeFB._addedBlocks);
    _waitingNot = "";
    codeFB._addedBlocks.needEndBlock[codeFB._blockIndex] =
        codeFB._addedBlocks.retVal;
    codeFB._addedBlocks.needEndBlock[codeFB._blockIndex] =
        codeFB._addedBlocks.retVal;
    return codeFB;
  }
  CodeFilterBuilder endsWith(dynamic pValue) {
    codeFB._addedBlocks = setCriteria(
        "%" + pValue,
        codeFB.parameters,
        param,
        SqlSyntax.Contains.replaceAll(SqlSyntax.NOT_KEYWORD, _waitingNot),
        codeFB._addedBlocks);
    _waitingNot = "";
    codeFB._addedBlocks.needEndBlock[codeFB._blockIndex] =
        codeFB._addedBlocks.retVal;
    return codeFB;
  }
  CodeFilterBuilder between(dynamic pFirst, dynamic pLast) {
    if (pFirst != null && pLast != null) {
      codeFB._addedBlocks = setCriteria(
          pFirst,
          codeFB.parameters,
          param,
          SqlSyntax.Between.replaceAll(SqlSyntax.NOT_KEYWORD, _waitingNot),
          codeFB._addedBlocks,
          pLast);
    } else if (pFirst != null) {
      if (_waitingNot != "")
        codeFB._addedBlocks = setCriteria(pFirst, codeFB.parameters,
            param, SqlSyntax.LessThan, codeFB._addedBlocks);
      else
        codeFB._addedBlocks = setCriteria(pFirst, codeFB.parameters,
            param, SqlSyntax.GreaterThanOrEquals, codeFB._addedBlocks);
    } else if (pLast != null) {
      if (_waitingNot != "")
        codeFB._addedBlocks = setCriteria(pLast, codeFB.parameters, param,
            SqlSyntax.GreaterThan, codeFB._addedBlocks);
      else
        codeFB._addedBlocks = setCriteria(pLast, codeFB.parameters, param,
            SqlSyntax.LessThanOrEquals, codeFB._addedBlocks);
    }
    _waitingNot = "";
    codeFB._addedBlocks.needEndBlock[codeFB._blockIndex] =
        codeFB._addedBlocks.retVal;
    return codeFB;
  }
  CodeFilterBuilder greaterThan(dynamic pValue) {
    param.expression = ">";
    codeFB._addedBlocks = _waitingNot == ""
        ? setCriteria(pValue, codeFB.parameters, param,
        SqlSyntax.GreaterThan, codeFB._addedBlocks)
        : setCriteria(pValue, codeFB.parameters, param,
        SqlSyntax.LessThanOrEquals, codeFB._addedBlocks);
    _waitingNot = "";
    codeFB._addedBlocks.needEndBlock[codeFB._blockIndex] =
        codeFB._addedBlocks.retVal;
    return codeFB;
  }
  CodeFilterBuilder lessThan(dynamic pValue) {
    param.expression = "<";
    codeFB._addedBlocks = _waitingNot == ""
        ? setCriteria(pValue, codeFB.parameters, param, SqlSyntax.LessThan,
        codeFB._addedBlocks)
        : setCriteria(pValue, codeFB.parameters, param,
        SqlSyntax.GreaterThanOrEquals, codeFB._addedBlocks);
    _waitingNot = "";
    codeFB._addedBlocks.needEndBlock[codeFB._blockIndex] =
        codeFB._addedBlocks.retVal;
    return codeFB;
  }
  CodeFilterBuilder greaterThanOrEquals(dynamic pValue) {
    param.expression = ">=";
    codeFB._addedBlocks = _waitingNot == ""
        ? setCriteria(pValue, codeFB.parameters, param,
        SqlSyntax.GreaterThanOrEquals, codeFB._addedBlocks)
        : setCriteria(pValue, codeFB.parameters, param, SqlSyntax.LessThan,
        codeFB._addedBlocks);
    _waitingNot = "";
    codeFB._addedBlocks.needEndBlock[codeFB._blockIndex] =
        codeFB._addedBlocks.retVal;
    return codeFB;
  }
  CodeFilterBuilder lessThanOrEquals(dynamic pValue) {
    param.expression = "<=";
    codeFB._addedBlocks = _waitingNot == ""
        ? setCriteria(pValue, codeFB.parameters, param,
        SqlSyntax.LessThanOrEquals, codeFB._addedBlocks)
        : setCriteria(pValue, codeFB.parameters, param,
        SqlSyntax.GreaterThan, codeFB._addedBlocks);
    _waitingNot = "";
    codeFB._addedBlocks.needEndBlock[codeFB._blockIndex] =
        codeFB._addedBlocks.retVal;
    return codeFB;
  }
  CodeFilterBuilder inValues(var pValue) {
    codeFB._addedBlocks = setCriteria(
        pValue,
        codeFB.parameters,
        param,
        SqlSyntax.IN.replaceAll(SqlSyntax.NOT_KEYWORD, _waitingNot),
        codeFB._addedBlocks);
    _waitingNot = "";
    codeFB._addedBlocks.needEndBlock[codeFB._blockIndex] =
        codeFB._addedBlocks.retVal;
    return codeFB;
  }
}
// endregion CodeField

// region CodeFilterBuilder
class CodeFilterBuilder extends SearchCriteria {
  AddedBlocks _addedBlocks;
  int _blockIndex = 0;
  List<DbParameter> parameters;
  List<String> orderByList;
  Code _obj;
  QueryParams qparams;
  int _pagesize;
  int _page;
  CodeFilterBuilder(Code obj) {
    whereString = "";
    qparams = new QueryParams();
    parameters = List<DbParameter>();
    orderByList = List<String>();
    groupByList = List<String>();
    _addedBlocks = new AddedBlocks(new List<bool>(), new List<bool>());
    _addedBlocks.needEndBlock.add(false);
    _addedBlocks.waitingStartBlock.add(false);
    _pagesize = 0;
    _page = 0;
    _obj = obj;
  }

  CodeFilterBuilder get and {
    if (parameters.length > 0)
      parameters[parameters.length - 1].wOperator = " AND ";
    return this;
  }

  CodeFilterBuilder get or {
    if (parameters.length > 0)
      parameters[parameters.length - 1].wOperator = " OR ";
    return this;
  }

  CodeFilterBuilder get startBlock {
    _addedBlocks.waitingStartBlock.add(true);
    _addedBlocks.needEndBlock.add(false);
    _blockIndex++;
    if (_blockIndex > 1) _addedBlocks.needEndBlock[_blockIndex - 1] = true;
    return this;
  }

  CodeFilterBuilder where(String whereCriteria) {
    if (whereCriteria != null && whereCriteria != "") {
      DbParameter param = new DbParameter();
      _addedBlocks = setCriteria(
          0, parameters, param, "(" + whereCriteria + ")", _addedBlocks);
      _addedBlocks.needEndBlock[_blockIndex] = _addedBlocks.retVal;
    }
    return this;
  }

  CodeFilterBuilder page(int page, int pagesize) {
    if (page > 0) _page = page;
    if (pagesize > 0) _pagesize = pagesize;
    return this;
  }

  CodeFilterBuilder top(int count) {
    if (count > 0) {
      _pagesize = count;
    }
    return this;
  }

  CodeFilterBuilder get endBlock {
    if (_addedBlocks.needEndBlock[_blockIndex]) {
      parameters[parameters.length - 1].whereString += " ) ";
    }
    _addedBlocks.needEndBlock.removeAt(_blockIndex);
    _addedBlocks.waitingStartBlock.removeAt(_blockIndex);
    _blockIndex--;
    return this;
  }

  CodeFilterBuilder orderBy(var argFields) {
    if (argFields != null) {
      if (argFields is String)
        this.orderByList.add(argFields);
      else
        for (String s in argFields) {
          if (s != null && s != "") this.orderByList.add(" $s ");
        }
    }
    return this;
  }

  CodeFilterBuilder orderByDesc(var argFields) {
    if (argFields != null) {
      if (argFields is String)
        this.orderByList.add("$argFields desc ");
      else
        for (String s in argFields) {
          if (s != null && s != "") this.orderByList.add(" $s desc ");
        }
    }
    return this;
  }

  CodeFilterBuilder groupBy(var argFields) {
    if (argFields != null) {
      if (argFields is String)
        this.groupByList.add(" $argFields ");
      else
        for (String s in argFields) {
          if (s != null && s != "") this.groupByList.add(" $s ");
        }
    }
    return this;
  }

  CodeField setField(CodeField field, String colName, DbType dbtype) {
    field = new CodeField(this);
    field.param = new DbParameter(
        dbType: dbtype,
        columnName: colName,
        wStartBlock: _addedBlocks.waitingStartBlock[_blockIndex]);
    return field;
  }

  CodeField _pid;
  CodeField get pid {
    _pid = setField(_pid, "pid", DbType.integer);
    return _pid;
  }
  CodeField _id;
  CodeField get id {
    _id = setField(_id, "id", DbType.integer);
    return _id;
  }
  CodeField _text;
  CodeField get text {
    _text = setField(_text, "text", DbType.text);
    return _text;
  }
  CodeField _textBn;
  CodeField get textBn {
    _textBn = setField(_textBn, "textBn", DbType.text);
    return _textBn;
  }


  bool _getIsDeleted;

  void _buildParameters() {
    if (_page > 0 && _pagesize > 0) {
      qparams.limit = _pagesize;
      qparams.offset = (_page - 1) * _pagesize;
    } else {
      qparams.limit = _pagesize;
      qparams.offset = _page;
    }
    for (DbParameter param in parameters) {
      if (param.columnName != null) {
        if (param.value is List) {
          param.value = param.value
              .toString()
              .replaceAll("[", "")
              .replaceAll("]", "")
              .toString();
          whereString += param.whereString
              .replaceAll("{field}", param.columnName)
              .replaceAll("?", param.value);
          param.value = null;
        } else
          whereString +=
              param.whereString.replaceAll("{field}", param.columnName);
        switch (param.dbType) {
          case DbType.bool:
            if (param.value != null) param.value = param.value ? 1 : 0;
            break;
          default:
        }

        if (param.value != null) whereArguments.add(param.value);
        if (param.value2 != null) whereArguments.add(param.value2);
      } else
        whereString += param.whereString;
    }
    if (Code._softDeleteActivated) {
      if (whereString != "")
        whereString = (!_getIsDeleted ? "ifnull(isDeleted,0)=0 AND" : "") +
            " ($whereString)";
      else if (!_getIsDeleted) whereString = "ifnull(isDeleted,0)=0";
    }

    if (whereString != "") qparams.whereString = whereString;
    qparams.whereArguments = whereArguments;
    qparams.groupBy = groupByList.join(',');
    qparams.orderBy = orderByList.join(',');
  }


  /// <summary>
  /// Deletes List<Code> batch by query
  /// </summary>
  /// <returns>BoolResult res.success=Deleted, not res.success=Can not deleted</returns>
  Future<BoolResult> delete() async {
    _buildParameters();
    var r= BoolResult();
    if(Code._softDeleteActivated)
      r = await _obj._mnCode.updateBatch(qparams,{"isDeleted":1});
    else
      r = await _obj._mnCode.delete(qparams);
    return r;
  }


  Future<BoolResult> update(Map<String, dynamic> values) {
    _buildParameters();
    return _obj._mnCode.updateBatch(qparams, values);
  }

  /// This method always returns CodeObj if exist, otherwise returns null
  /// <returns>List<Code></returns>
  void toSingle(VoidCallback code(Code o)) {
    _pagesize = 1;
    _buildParameters();
    var objFuture = _obj._mnCode.toList(qparams);
    objFuture.then((data) {
      if (data.length > 0)
        code(Code.fromMap(data[0]));
      else
        code(null);
    });
  }


  /// This method always returns int.
  /// <returns>int</returns>
  Future<BoolResult> toCount(VoidCallback codeCount (int c)) async {
    _buildParameters();
    qparams.selectColumns = ["COUNT(1) AS CNT"];
    var codesFuture = await _obj._mnCode.toList(qparams);
    int count = codesFuture[0]["CNT"];
    codeCount (count);
    return BoolResult(success:count>0, successMessage: count>0? "toCount(): $count items found":"", errorMessage: count>0?"": "toCount(): no items found");
  }

  /// This method always returns List<Code>.
  /// <returns>List<Code></returns>
  void toList(VoidCallback codeList (List<Code> o)) async {

    _buildParameters();

    var codesFuture = _obj._mnCode.toList(qparams);

    List<Code> codesData = new List<Code>();
    codesFuture.then((data) {
      int count = data.length;
      for (int i = 0; i < count; i++) {
        codesData.add(Code.fromMap(data[i]));
      }
      codeList (codesData);
      codesData = null;
    });
  }

  /// This method always returns Primary Key List<int>.
  /// <returns>List<int></returns>
  Future<List<int>> toListPrimaryKey(VoidCallback pidList (List<int> o),
      [bool buildParameters=true]) async {
    if(buildParameters) _buildParameters();
    List<int> pidData = new List<int>();
    qparams.selectColumns= ["pid"];
    var pidFuture = await _obj._mnCode.toList(qparams);

    int count = pidFuture.length;
    for (int i = 0; i < count; i++) {
      pidData.add(pidFuture[i]["pid"]);
    }
    pidList (pidData);
    return pidData;
  }

  void toListObject(VoidCallback listObject(List<dynamic> o)) async {
    _buildParameters();

    var objectFuture = _obj._mnCode.toList(qparams);

    List<dynamic> objectsData = new List<dynamic>();
    objectFuture.then((data) {
      int count = data.length;
      for (int i = 0; i < count; i++) {
        objectsData.add(data[i]);
      }
      listObject(objectsData);
      objectsData = null;
    });


  }

}
// endregion CodeFilterBuilder




// region CodeFields
class CodeFields {
  static TableField _fPid;
  static TableField get pid {
    _fPid = SqlSyntax.setField(_fPid, "pid", DbType.integer);
    return _fPid;
  }
  static TableField _fId;
  static TableField get id {
    _fId = SqlSyntax.setField(_fId, "id", DbType.integer);
    return _fId;
  }
  static TableField _fText;
  static TableField get text {
    _fText = SqlSyntax.setField(_fText, "text", DbType.text);
    return _fText;
  }
  static TableField _fTextBn;
  static TableField get textBn {
    _fTextBn = SqlSyntax.setField(_fTextBn, "textBn", DbType.text);
    return _fTextBn;
  }

}
// endregion CodeFields

//region CodeManager
class CodeManager extends SqfEntityProvider {
  static String _tableName = "code";
  static String _colId = "pid";
  CodeManager():super(DbManager(),tableName: _tableName, colId: _colId);
}
//endregion CodeManager
