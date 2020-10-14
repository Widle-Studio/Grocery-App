import 'package:f_groceries/database/user/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

class UserHelper{

  final String tableName = "userTable";
  final String columnId = "id";
  final String columnUsername = "username";
  final String columnEmail = "email";
  final String columnPassword = "password";
  final String columnToken = "token";
  final String columnUserId = "userId";


  static final UserHelper _instance = UserHelper.internal();
  factory UserHelper() => _instance;

  static Database _db;
  Future<Database> get db async{
    if(_db != null){

      return _db;
    }
    _db = await initDb();

    return _db;
  }

  UserHelper.internal();

  initDb() async{

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "userdb.db");

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate,);
    return ourDb;
  }




  void _onCreate(Database db, int newVersion) async{
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $tableName("
            "$columnId INTEGER PRIMARY KEY, "
            "$columnUsername TEXT, "
            "$columnEmail TEXT, "
            "$columnPassword TEXT, "
            "$columnToken TEXT,"
            "$columnUserId INTEGER"
            ")"
    );
  }

  //CRUD


  //Insertion
  Future<int> saveUser(User user) async{

    var dbClient = await db;
    int res = await dbClient.insert("$tableName",  user.toMap());
    return res;
  }

  //Get Users
  Future<List> getUsers() async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName ORDER BY $columnId DESC");
    return res.toList();

  }


  // Get Count
  Future<int> getCount() async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName");
    return Sqflite.firstIntValue(res);

  }

  // A User
  Future<User> getUser(int id) async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columnId = $id");

    if(res.length == 0 || res.length > 1){
      return null;
    }

    return User.fromMap(res.first);
  }

  // A User with user ID
  Future<User> getUserWithUsernameId(String name) async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columnUsername = $name");

    if(res.length == 0 || res.length > 1){
      return null;
    }

    return User.fromMap(res.first);
  }

  //Delete a User
  Future<int> deleteUser(int id) async{
    var dbClient = await db;
    return await dbClient.delete(
        tableName,
        where: "$columnId = ?",
        whereArgs: [id]
    );
  }


  //Update a Bookmark
  Future<int> updateWallet(User user) async{
    var dbClient = await db;
    return await dbClient.update(
        tableName,
        user.toMap(),
        where: "$columnId = ?",
        whereArgs: [user.id]
    );
  }


  //Close the connection
  Future close() async{
    var dbClient = await db;
    return dbClient.close();
  }
}