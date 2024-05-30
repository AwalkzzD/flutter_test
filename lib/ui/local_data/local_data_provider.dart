import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/data/local/model/todo_item.dart';
import 'package:sample/data/local/repository/todo_repository.dart';

/// todoRepositoryProvider returns TodoRepository object
final todoRepositoryProvider = Provider.autoDispose<TodoRepository>((ref) {
  return TodoRepository();
});

///-------------------------------------------------------------------------------------

///  noSqlDataProvider returns list of todos from local data storage (NoSql DB)
final noSqlDataProvider = FutureProvider.autoDispose<List<TodoItem>?>((ref) {
  return ref.read(todoRepositoryProvider).getTodosLocalStorage();
});

///  addNoSqlDataProvider adds todos to local data storage (NoSql DB)
final addNoSqlDataProvider =
    Provider.autoDispose.family<void, String>((ref, todoTask) {
  ref.read(todoRepositoryProvider).addTodoLocalStorage(todoTask);
  ref.invalidate(noSqlDataProvider);
});

///-------------------------------------------------------------------------------------

///  sqlDataProvider returns list of todos from sqlite database (Sql DB)
final sqlDataProvider = FutureProvider.autoDispose<List<TodoItem>?>((ref) {
  return ref.read(todoRepositoryProvider).getTodosSqlite();
});

///  addSqlDataProvider adds todos to sqlite database (Sql DB)
final addSqlDataProvider =
    Provider.autoDispose.family<void, String>((ref, todoTask) {
  ref.read(todoRepositoryProvider).addTodoSqlite(todoTask);
  ref.invalidate(sqlDataProvider);
});

///-------------------------------------------------------------------------------------

///  fileDataProvider returns list of todos from local file (Local File)
final fileDataProvider = FutureProvider.autoDispose<List<TodoItem>?>((ref) {
  return ref.read(todoRepositoryProvider).getTodosFile();
});

///  addFileDataProvider adds todos to local file (Local File)
final addFileDataProvider =
    Provider.autoDispose.family<void, String>((ref, todoTask) {
  ref.read(todoRepositoryProvider).addTodoFile(todoTask);
  ref.invalidate(fileDataProvider);
});

final sqlDataNotifierProvider =
    ChangeNotifierProvider.autoDispose<ChangeNotifier>((ref) {
  return SqlDataNotifier();
});

class SqlDataNotifier extends ChangeNotifier {}
