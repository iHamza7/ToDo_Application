import 'package:sqflite/sqflite.dart' as sql;

import '../models/task_model.dart';

class DbHelper {
  //creating tables
  static Future<void> createTables(sql.Database database) async {
    await database.execute("CREATE TABLE todos("
        "id INTERGER PRIMARY KEY AUTOINCREMENT, "
        "title STRING, description TEXT , date STRING,"
        "startTime STRING, endTime STRING,"
        "remind INTEGER, repeat STRING,"
        "isCompleted INTEGER, )");

    await database.execute("CREATE TABLE user("
        "id INTERGER PRIMARY KEY AUTOINCREMENT DEFAULT 0 ,"
        "isVerified INTEGER )");
  }

//opening the database
  static Future<sql.Database> db() async {
    return sql.openDatabase("mydatabase", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  //creating the task
  static Future<int> createItem(TaskModel taskModel) async {
    final db = await DbHelper.db();
    final id = await db.insert("todos", taskModel.toJson(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

//creating the user
  static Future<int> createUser(int isVerified) async {
    final db = await DbHelper.db();

    final data = {
      "id": 0,
      "isVerified": isVerified,
    };
    final id = await db.insert("user", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  //getting the data
  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await DbHelper.db();
    return db.query("user", orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DbHelper.db();
    return db.query("todos", orderBy: 'id');
  }

  //getting only single user or table data

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DbHelper.db();
    return db.query("todos", where: "id = ? ", whereArgs: [id], limit: 1);
  }
}
