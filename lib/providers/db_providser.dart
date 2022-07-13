import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DB {
  static Future<sql.Database> connection() async {
    final String dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sql.Database db = await DB.connection();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sql.Database db = await DB.connection();
    return db.query(table);
  }
}
