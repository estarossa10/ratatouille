import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  Future<DatabaseProvider> getDatabaseProvider() async {
    return db;
  }

  Future<Database> getDatabase() async {
    if(_database != null) {
      return _database;
    }

    _database = await InitDB();
    return _database;
  }

  InitDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      readOnly: true
    );
  }

}