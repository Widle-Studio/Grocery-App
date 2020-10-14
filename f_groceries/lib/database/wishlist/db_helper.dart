
import 'package:f_groceries/database/wishlist/wishlist.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

class WishlistHelper{

  final String tableName = "wishlistTable";
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


  static final WishlistHelper _instance = WishlistHelper.internal();
  factory WishlistHelper() => _instance;

  static Database _db;
  Future<Database> get db async{
    if(_db != null){

      return _db;
    }
    _db = await initDb();

    return _db;
  }

  WishlistHelper.internal();

  initDb() async{

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "uwishdb.db");

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
  Future<int> saveBookmark(Wishlist wishlist) async{

    var dbClient = await db;
    int res = await dbClient.insert("$tableName",  wishlist.toMap());
    return res;
  }

  //Get Bookmarks
  Future<List> getBookmarks() async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName ORDER BY $columnId DESC");
    return res.toList();

  }

  //Check Bookmarks
  Future<int> checkBookmark(int id) async{
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

  // A Bookmark
  Future<Wishlist> getBookmark(int id) async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columnId = $id");

    if(res.length == 0 || res.length > 1){
      return null;
    }

    return Wishlist.fromMap(res.first);
  }

  // A Bookmark with post ID
  Future<Wishlist> getBookmarkWithPostId(int id) async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columnProductId = $id");

    if(res.length == 0 || res.length > 1){
      return null;
    }

    return Wishlist.fromMap(res.first);
  }

  //Delete a Bookmark
  Future<int> deleteBookmark(int id) async{
    var dbClient = await db;
    return await dbClient.delete(
        tableName,
        where: "$columnId = ?",
        whereArgs: [id]
    );
  }


  //Update a Bookmark
  Future<int> updateWallet(Wishlist wishlist) async{
    var dbClient = await db;
    return await dbClient.update(
        tableName,
        wishlist.toMap(),
        where: "$columnId = ?",
        whereArgs: [wishlist.id]
    );
  }


  //Close the connection
  Future close() async{
    var dbClient = await db;
    return dbClient.close();
  }

}