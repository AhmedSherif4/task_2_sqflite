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
}
