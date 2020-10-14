import 'package:f_groceries/database/cart/cart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

class CartHelper{

  final String tableName = "cartTable";
  final String columnId = "id";
  final String columnProductId = "productId";
  final String columnName = "name";
  final String columnImg = "img";
  final String columnPrice = "price";
  final String columnQuantity = "quantity";
  final String columnLink = "link";
  final String rateAmount = "rateAmount";
  final String cat  = "cat";
  String _regularPrice  = "regularPrice"; 
  String _rating = "rating";
  String _desc = "desc";
  String _serve_quantity = "serve_quantity";



  static final CartHelper _instance = CartHelper.internal();
  factory CartHelper() => _instance;

  static Database _db;
  Future<Database> get db async{
    if(_db != null){

      return _db;
    }
    _db = await initDb();

    return _db;
  }

  CartHelper.internal();

  initDb() async{

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "cartdb.db");

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate,);
    return ourDb;
  }


  void _onCreate(Database db, int newVersion) async{
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $tableName("
            "$columnId INTEGER PRIMARY KEY, "
            "$columnProductId INTEGER, "
            "$columnName TEXT, "
            "$columnImg TEXT, "
            "$columnPrice DOUBLE, "
            "$columnQuantity INTEGER, "
            "$columnLink TEXT,"
            "$_regularPrice DOUBLE,"
            "$_rating TEXT,"
            "$_desc TEXT,"
            "$rateAmount INTEGER,"
            "$cat INTEGER,"
            "$_serve_quantity TEXT"
            ")"
    );
  }

  //CRUD


  //Insertion
  Future<int> saveCart(Cart cart) async{

    var dbClient = await db;
    int res = await dbClient.insert("$tableName",  cart.toMap());
    return res;
  }

  //Get Cart items
  Future<List> getCarts() async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName ORDER BY $columnId DESC");
    return res.toList();

  }

  //Check Cart if item exist
  Future<int> checkCart(int id) async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columnProductId = $id");
    if(res.length != 0){
      return 0;
    }else{
      return 1;
    }
  }

  // Get Count
  Future<int> getCount() async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName");
    return Sqflite.firstIntValue(res);

  }

  // A Cart
  Future<Cart> getUser(int id) async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columnId = $id");

    if(res.length == 0 || res.length > 1){
      return null;
    }

    return Cart.fromMap(res.first);
  }

  // A Cart with item ID
  Future<Cart> getProductWithProductId(int id) async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columnProductId = $id");

    if(res.length == 0 || res.length > 1){
      return null;
    }

    return Cart.fromMap(res.first);
  }

  //Delete a Cart
  Future<int> deleteCart(int id) async{
    var dbClient = await db;
    return await dbClient.delete(
        tableName,
        where: "$columnId = ?",
        whereArgs: [id]
    );
  }


  //Update a Cart
  Future<int> updateWallet(Cart cart) async{
    var dbClient = await db;
    return await dbClient.update(
        tableName,
        cart.toMap(),
        where: "$columnId = ?",
        whereArgs: [cart.id]
    );
  }


  //Close the connection
  Future close() async{
    var dbClient = await db;
    return dbClient.close();
  }

    Future deleteWholeCart() async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName ORDER BY $columnId DESC");
    List list = res.toList();
    for(int i = 0; i< res.length;i++){
       await dbClient.delete(
        tableName,
        where: "$columnId = ?",
        whereArgs: [list[i]["id"]]
    );
    }
   

  }

}