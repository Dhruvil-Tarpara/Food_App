import 'package:food/helper/db_helper.dart';
import 'package:food/models/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LoginDBHelper {
  LoginDBHelper._();

  static final LoginDBHelper loginDBHelper = LoginDBHelper._();
  final String tableName = "User";
  final String colName = "Name";
  final String colEmail = "Email";
  final String colPassword = "Password";

  Future<void> creat() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, DBHelper.dbHelper.databaseName);
    DBHelper.dbHelper.db = await openDatabase(path, version: 1,
        onCreate: (Database database, int version) async {
      database.execute(
          "CREATE TABLE IF NOT EXISTS $tableName($colName TEXT, $colEmail TEXT, $colPassword TEXT);");
    });
  }

  Future<void> insertRecord(
      {required String name,
      required String email,
      required String password}) async {
    await creat();
    Login data = Login(name: name, email: email, password: password);
    String query =
        "INSERT INTO $tableName($colName, $colEmail, $colPassword) VALUES(?, ?, ?);";
    List args = [data.name, data.email, data.password];
    await DBHelper.dbHelper.db!.rawInsert(query, args);
  }

  Future<List<Login>> fetchAllRecords() async {
    String query = "SELECT * FROM $tableName";
    List<Map<String, dynamic>> allData = await DBHelper.dbHelper.db!.rawQuery(query);

   List<Login> data = allData.map((e) => Login.fromDB(data: e)).toList();

   return data;
  }
}
