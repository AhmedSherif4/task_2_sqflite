import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/department_model.dart';

class SQLDatabase {
  Database? _database;

  // for making initial database only once, and then store it in (_database)
  Future<Database?> get database async {
    if (_database == null) {
      return _database = await initialDatabase();
    } else {
      return _database;
    }
  }

  initialDatabase() async {
    // تحديد مسار تخزين الداتا
    String databasePath = await getDatabasesPath();
    // بربط المسار بإسم الداتا بيز
    //databasePath/task.db
    String path = join(databasePath, 'task.db');
    //opening database (task.db) and create on this database tables
    // the version important for in the future in case you want to make upgrade and using onUpdate to create new table you HAVE TO change the version to new one.
    Database initDatabase =
        await openDatabase(path, onCreate: _onCreate, version: 1);
    return initDatabase;
  }

  // for sql
  String tableName = 'departments';
  String columnId = 'id';
  String columnTitle = 'title';
  String columnBody = 'body';
  String columnImagePath = 'imagePath';

  // create tables
  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName 
    (
    $columnId INTEGER PRIMARY KEY,
    $columnTitle TEXT,
    $columnBody TEXT,
    $columnImagePath TEXT
    )
    ''');
    if (kDebugMode) {
      print('database and tables are created --------------------------------');
    }
  }

  // create with batch
  // batch for multi tables at once, and generally he make multi things at once
  FutureOr<void> _onCreateWithBatch(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
    CREATE TABLE $tableName 
    (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnTitle TEXT NOT NULL,
    $columnBody TEXT NOT NULL,
    $columnImagePath TEXT NOT NULL
    )
    ''');
    batch.execute('''
    CREATE TABLE newTable 
    (
    "$columnId" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "address" TEXT NOT NULL
    )
    ''');
    await batch.commit();
    if (kDebugMode) {
      print('database and tables are created --------------------------------');
    }
  }

  // = select
  Future<List<DepartmentModel>> readDatabase() async {
    Database? readDatabase = await database;
    List<Map<String, Object?>> response = await readDatabase!.rawQuery('''
        SELECT * FROM $tableName
    ''');
    final List<DepartmentModel> departmentModel = response
        .map<DepartmentModel>((jsonDepartmentMode) =>
            DepartmentModel.fromJson(jsonDepartmentMode))
        .toList();
    print('readed --------------------------------');
    return departmentModel;
  }

  // = delete
  // return 0 if it did not delete, 1 if it deleted.
  Future<int> deleteDatabase(int id) async {
    Database? deleteDatabase = await database;
    Future<int> response = deleteDatabase!.rawDelete('''
        DELETE FROM $tableName 
        WHERE $columnId = $id
        ''');
    return response;
  }

  // = update
  // return 0 if it did not update, 1 if it updated.

  Future<int> updateDatabase(int id, String newTitle, String newBody) async {
    Database? updateDatabase = await database;
    Future<int> response = updateDatabase!.rawUpdate('''
    UPDATE $tableName 
    SET $columnTitle = ?, $columnBody = ? WHERE $columnId = ?
    ''', [
      newTitle,
      newBody,
      id,
    ]);
    return response;
  }

  // = insert
  Future<int> insertDatabase(DepartmentModel department) async {
    Database? insertDatabase = await database;
    Future<int> response = insertDatabase!.rawInsert('''
    INSERT INTO 
    $tableName ($columnTitle , $columnBody , $columnImagePath) 
    VALUES ("${department.title}" , "${department.body}" , "${department.imagePath}")
    ''');
    print('inserted --------------------------------');
    return response;
  }

//shortcuts
  // = select
  // return List of map of row that were found (default)
  Future<List<DepartmentModel>> readDatabaseShortcut() async {
    Database? readDatabase = await database;
    List<Map<String, Object?>> response =
        /* you just add table name, thats it */
        await readDatabase!.query('${tableName}');
    final List<DepartmentModel> departmentModel = response
        .map<DepartmentModel>((jsonDepartmentMode) =>
            DepartmentModel.fromJson(jsonDepartmentMode))
        .toList();
    print('readed --------------------------------');
    return departmentModel;
  }

  // = delete
  // return 0 if it did not delete, 1 if it deleted.
  Future<int> deleteDatabaseShortcut(int id) async {
    Database? deleteDatabase = await database;
    Future<int> response = deleteDatabase!
        /* you just add table name, where: condition (like ==) whereArgs: the value of condition */
        .delete('${tableName}', where: 'id = ?', whereArgs: ['$id']);
    return response;
  }

  // = update
  // return 0 if it did not update, 1 if it updated.

  Future<int> updateDatabaseShortcut(
      int id, String newTitle, String newBody) async {
    Database? updateDatabase = await database;
    /* you just add table name,(colum and new value) as map, where: condition, (?) = whereArgs */
    Future<int> response = updateDatabase!.update(
        '$tableName', {'$columnTitle': '$newTitle', '$columnBody': '$newBody'},
        where: 'id = $id');
    return response;
  }

  // = insert
  // return last inserted row id.
  Future<int> insertDatabaseShortcut(DepartmentModel department) async {
    Database? insertDatabase = await database;
    /* you just add table name,(values) columns and values: as map */
    Future<int> response = insertDatabase!.insert(
      '$tableName',
      {
        '$columnTitle': department.title,
        '$columnBody': department.body,
        '$columnImagePath': department.imagePath,
      },
    );
    print('inserted --------------------------------');
    return response;
  }
}
