import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static DBHelper dbHalper = DBHelper();
  Database? database;

  Future<Database?> checkDb() async {
    if (database != null) {
      return database;
    } else {
      return await createDb();
    }
  }

  Future<Database> createDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'jeet.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE News(id INTEGER PRIMARY KEY AUTOINCREMENT,author TEXT,title TEXT,description TEXT,source Text)";
        db.execute(query);
      },
    );
  }

  Future<void> insertData({required String author,
    required String title,
    required String description,
    required String source,}) async {
    database = await checkDb();
    database!.insert(
      "News",
      {
        "author": author,
        "title": title,
        "description": description,
        "publishedAtl̥": source,
      },
    );
  }

  Future<List<Map>> readData() async {
    database = await checkDb();
    String query = "SELECT * FROM News";
    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }

  Future<void> deleteData({required int id}) async {
    database = await checkDb();
    database!.delete(
      "News",
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
