import 'package:my_restaurant/features/data/model/local_place_model.dart';
import 'package:my_restaurant/features/data/model/result_model.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/constant.dart';

class DbHelper {
  static Database? _database;
  static Database? _databaseSaveMode;

  Future<Database?> get databaseSaveMode async {
    _databaseSaveMode ??= await openSaveMode();
    return _databaseSaveMode;
  }

  Future<Database> openSaveMode() async {
    var path = await getDatabasesPath();
    final dbPath = '$path/myrestaurant.db';
    var db =
        await openDatabase(dbPath, version: 1, onCreate: _onCreateSaveMode);
    return db;
  }

  _onCreateSaveMode(var db, int version) async {
    await db.execute('''
        CREATE TABLE ${Constant.tblSaveMode} (
          ${Constant.id} INTEGER PRIMARY KEY, 
          ${Constant.geometryLat} TEXT,
          ${Constant.geometryLang} TEXT,
          ${Constant.title} TEXT,
          ${Constant.icon} TEXT, 
          ${Constant.rating} TEXT,
          ${Constant.reference} TEXT, 
          ${Constant.totalRating} TEXT,
          ${Constant.description} TEXT,
          ${Constant.dateUpdate} TEXT,
          ${Constant.types} TEXT );
      ''');
  }

  Future<int> insertSaveMode(ResultModel list) async {
    final db = await databaseSaveMode;
    Map<String, dynamic> data = {
      Constant.geometryLat: list.geometry.location.lat,
      Constant.geometryLang: list.geometry.location.lng,
      Constant.title: list.name,
      Constant.icon: list.icon,
      Constant.rating: list.rating,
      Constant.reference: list.reference,
      Constant.totalRating: list.userRatingsTotal,
      Constant.description: list.vicinity,
      Constant.dateUpdate: DateTime.now().toString(),
      Constant.types: list.types.toString()
    };
    return db!.insert(Constant.tblSaveMode, data);
  }

  Future<int> deleteSingleSaveMode(ResultModel list) async {
    final db = await databaseSaveMode;
    return await db!.delete(Constant.tblSaveMode,
        where: '${Constant.reference} = ?', whereArgs: [list.reference]);
  }

  Future deleteAllSaveMode() async {
    final db = await databaseSaveMode;
    return db!.delete(Constant.tblSaveMode);
  }

  getOfflineDataById(String list) async {
    var db = await databaseSaveMode;
    var singleProduct = await db!.query(Constant.tblSaveMode,
        columns: [
          Constant.id,
          Constant.title,
          Constant.icon,
          Constant.rating,
          Constant.totalRating,
          Constant.reference,
          Constant.description,
          Constant.geometryLat,
          Constant.geometryLang,
          Constant.types
        ],
        where: '${Constant.reference} = ?',
        whereArgs: [list]);
    return singleProduct;
  }

  tableIsEmpty(ResultModel list) async {
    var db = await databaseSaveMode;
    int? count = Sqflite.firstIntValue(await db!.rawQuery(
        'SELECT COUNT(*) FROM ${Constant.tblSaveMode} WHERE reference = ${list.reference}'));
    return count;
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await databaseSaveMode;
    final List<Map<String, dynamic>> result =
        await db!.query(Constant.tblSaveMode);
    return result;
  }

  /*
    Local place begin
   */

  Future<Database?> get databaseLocalPlace async {
    _database ??= await openLocalPlace();
    return _database;
  }

  Future<Database> openLocalPlace() async {
    var path = await getDatabasesPath();
    final dbPath = '$path/localPlace.db';
    var db =
        await openDatabase(dbPath, version: 1, onCreate: _onCreateLocalPlace);
    return db;
  }

  Future _onCreateLocalPlace(Database db, int version) async {
    await db.execute('''
        CREATE TABLE ${Constant.tblPlace} (
        ${Constant.placeId} INTEGER PRIMARY KEY, 
        ${Constant.placeAddress} TEXT,
        ${Constant.placeLat} TEXT, 
        ${Constant.placeLong} TEXT );
      ''');
  }

  Future<int> addLocalPlace(LocalPlaceModel list) async {
    final db = await databaseLocalPlace;
    return db!.insert(Constant.tblPlace, list.toJson());
  }

  Future deleteLocalPlace(LocalPlaceModel list) async {
    final db = await databaseLocalPlace;
    return await db!.delete(Constant.tblPlace,
        where: '${Constant.placeAddress} = ?', whereArgs: [list.address]);
  }

  Future<List<Map<String, dynamic>>> getAllLocalPlace() async {
    final db = await databaseLocalPlace;
    final List<Map<String, dynamic>> result =
        await db!.query(Constant.tblPlace);
    return result;
  }
}
