import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:excursoes_app_organizer/model/excursion.dart';

class DbHelper {
  String tblExcursions = "excursions";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colLocal = "local";
  String colDate = "date";

  DbHelper._internal();

  static final DbHelper _dbHelper = DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "excursion_app.db";

    var dbExcursion = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbExcursion;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblExcursions($colId INTEGER PRIMARY KEY, $colTitle TEXT, " +"$colDescription TEXT, $colLocal INTEGER, $colDate TEXT)"
    );
  }

  static Database _db;
  Future<Database> get db async {
    if(_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<int> insertExcursion(Excursion excursion) async {
    Database db = await this.db;
    var result = await db.insert(tblExcursions, excursion.toMap());
    return result;
  }

  Future<List> getExcursions() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblExcursions order by $colDate DESC");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(await db.rawQuery("select count (*) from $tblExcursions")  );
    return result;
  }

  Future<int> updateExcursion(Excursion excursion) async {
    var db = await this.db;
    var result = await db.update(
      tblExcursions,
      excursion.toMap(),
      where: "$colId = ?",
      whereArgs: [excursion.id]
    );
    return result;
  }

  Future<int> deleteExcursion(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete('DELETE FROM $tblExcursions WHERE $colId = $id');
    return result;
  }

}