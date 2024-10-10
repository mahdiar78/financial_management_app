import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class CoreDatabase {
  Future<Database> database() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'money_user.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL , description TEXT NOT NULL , price TEXT NOT NULL , date TEXT NOT NULL , is_recieved INTEGER NOT NULL)");
      },
      version: 1,
    );
  }
}
