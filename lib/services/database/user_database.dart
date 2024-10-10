import 'package:financial_management_app/services/database/core.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/user.dart';

class UserDatabase extends CoreDatabase {
  Future<int> addMoney(User user) async {
    Database db = await database();
    return db.insert("user", user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

  }

  Future<List<User>> getMoney() async {
    Database db = await database();
    List<Map<String, dynamic>> result = await db.query("user");
    return List.generate(
        result.length,
        (index) => User(
            id: result[index]["id"],
            description: result[index]["description"],
            price: result[index]["price"],
            date: result[index]["date"],
            isRecieved: result[index]["is_recieved"]));
  }

  Future<int> updateMoney(int userId, User user) async {
    Database db = await database();
    return await db
        .update("user", user.toMap(), where: "id = ?", whereArgs: [userId]);
  }

  Future<int> deleteMoney(int userId) async {
    Database db = await database();
    return await db.delete("user", where: "id = ?", whereArgs: [userId]);
  }
}
