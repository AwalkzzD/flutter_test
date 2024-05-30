import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample/data/local/model/todo_item.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteHelper {
  SqfliteHelper._();

  static final SqfliteHelper instance = SqfliteHelper._();
  static Database? _database;

  // Database name and version
  static const String databaseName = 'todos.db';
  static const int versionNumber = 1;

  // Table name
  static const String tableTodos = 'Todos';

  // Table (Todos) Columns
  static const String colId = 'id';
  static const String colTitle = 'todoTask';

  // Create Table Query
  static const String createTableQuery =
      'CREATE TABLE IF NOT EXISTS $tableTodos ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT NOT NULL)';

  // Define a getter to access the database asynchronously.
  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);

    var db =
        await openDatabase(path, version: versionNumber, onCreate: _onCreate);
    return db;
  }

  // Run the CREATE TABLE statement on the database.
  _onCreate(Database db, int intVersion) async =>
      await db.execute(createTableQuery);

  // A method that retrieves all the notes from the Notes table.
  Future<List<TodoItem>> getAll() async =>
      (await (await database).query(tableTodos, orderBy: '$colId ASC'))
          .map((records) => TodoItem.fromMap(records))
          .toList();

  // Function that inserts notes into the database
  Future<void> insert(TodoItem todo) async =>
      await (await database).insert(tableTodos, todo.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);

  // Function to close the database
  Future close() async => (await database).close();
}
