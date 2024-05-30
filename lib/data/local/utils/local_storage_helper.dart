import 'package:localstore/localstore.dart';
import 'package:sample/data/local/model/todo_item.dart';

class LocalStorageHelper {
  LocalStorageHelper._();

  static final LocalStorageHelper instance = LocalStorageHelper._();
  static Localstore? _database;

  // Collection name
  static const String collectionName = 'todos';

  // Define a getter to access the database asynchronously.
  Future<Localstore> get database async => _database ??= await _initDatabase();

  _initDatabase() async => Localstore.instance;

  // Function that inserts notes into the database
  Future<void> insert(TodoItem todo) async =>
      await (await database).collection(collectionName).doc().set(todo.toMap());

  // A method that retrieves all the notes from the Notes table.
  Future<List<TodoItem>?> getAll() async => todoListFromMap(
      (await (await database).collection(collectionName).get())!);
}
