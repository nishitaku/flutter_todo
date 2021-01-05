import 'package:flutter_todo/models/Todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  // Private Constructor
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static final _tableName = "Todo";

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    // DBが存在しない場合は作成する
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "TodoDB.db");
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    return await db.execute("CREATE TABLE Todo ("
        "id TEXT PRIMARY KEY,"
        "title TEXT,"
        "dueDate TEXT,"
        "note TEXT,"
        "isCompleted INTEGER"
        ")");
  }

  Future<int> createTodo(Todo todo) async {
    final db = await database;
    var res = await db.insert(_tableName, todo.toMap());
    return res;
  }

  Future<List<Todo>> getAllTodos() async {
    final db = await database;
    var res = await db.query(_tableName);
    return res.isNotEmpty ? res.map((c) => Todo.fromMap(c)).toList() : [];
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await database;
    var res = await db.update(_tableName, todo.toMap(),
        where: "id = ?", whereArgs: [todo.id]);
    return res;
  }

  Future<int> deleteTodo(String id) async {
    final db = await database;
    var res = db.delete(_tableName, where: "id = ?", whereArgs: [id]);
    return res;
  }
}
