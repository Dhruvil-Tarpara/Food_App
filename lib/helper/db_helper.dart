import 'dart:typed_data';
import 'package:food/helper/image_helper.dart';
import 'package:food/models/models.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../globals/globals.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  final String databaseName = "foodProduct.db";
  final String tableName = "product";
  final String colId = "Id";
  final String colName = "Name";
  final String colDetails = "Details";
  final String colCategory = "Category";
  final String colReview = "Review";
  final String colLike = "likes";
  final String colQuantity = "Quantity";
  final String colPrice = "Price";
  final String colImage = "Image";

  Database? db;

  Future<void> create() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, databaseName);

    db = await openDatabase(path, version: 1,
        onCreate: (Database database, int version) async {
      await database.execute(
          "CREATE TABLE IF NOT EXISTS $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colCategory TEXT, $colDetails TEXT, $colLike INTEGER, $colPrice INTEGER, $colQuantity INTEGER, $colReview INTEGER, $colImage BLOB);");
    });
  }

  Future<void> insertRecord() async {
    await create();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isInserted = prefs.getBool(tableName) ?? false;

    if (isInserted == false) {
      for (int i = 0; i < Global.products.length; i++) {
        Uint8List? imageData = await ProductImage.productImage
            .getImage(productName: Global.products[i].name,category: Global.products[i].category);
        Product data =
            Product.fromData(data: Global.products[i], image: imageData);

        String query =
            "INSERT INTO $tableName($colName, $colCategory, $colDetails, $colLike, $colPrice, $colQuantity, $colReview, $colImage) VALUES(?, ?, ?, ?, ?, ?, ?, ?);";
        List args = [
          data.name,
          data.category,
          data.details,
          data.like,
          data.price,
          data.quantity,
          data.review,
          data.image,
        ];
        await db!.rawInsert(query, args);
      }
      prefs.setBool(tableName, true);
    }
  }

  Future<List<ProductDB>> fetchAllRecords() async {
    await insertRecord();

    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> allData = await db!.rawQuery(query);

    List<ProductDB> customData =
        allData.map((e) => ProductDB.fromData(data: e)).toList();

    return customData;
  }
}
