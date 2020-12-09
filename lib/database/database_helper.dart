import 'dart:ffi';
import 'dart:io';
import 'package:ratatouille/models/users.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final _dbName = 'ratatouille_database';

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database _database;

  Future<Database> get database async {
    if(_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, _dbName);
    print(path);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<Void> _onCreate(Database db, int version) async {
    await db.execute(
        '''
      CREATE TABLE "Users" (
        "UserID"	TEXT NOT NULL UNIQUE,
        "Email"	TEXT NOT NULL UNIQUE,
        "Password"	TEXT NOT NULL,
        "Username"	TEXT NOT NULL UNIQUE,
        "Name"	TEXT NOT NULL,
        "Phone"	TEXT NOT NULL,
        "Address"	TEXT NOT NULL,
        "LastLogin"	TEXT NOT NULL,
        PRIMARY KEY("UserID")
      )
      '''
    );
  }

  Future<Users> login(String username, String password) async {
    final db = await _database;
    final List<Map<String, dynamic>> user = await db.rawQuery(
      '''
        SELECT * FROM Users WHERE Username = ? AND PASSWORD = ?
      ''',
      [username, password]
    );

    return Users(
      UserID: user[0]['UserID'],
      Username: user[0]['Username'],
      Email: user[0]['Email'],
      Name: user[0]['Name'],
      Phone: user[0]['Phone'],
      Address: user[0]['Address'],
      LastLogin: user[0]['LastLogin']);
  }

}