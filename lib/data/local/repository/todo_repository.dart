import 'package:flutter/foundation.dart';
import 'package:sample/data/local/model/todo_item.dart';
import 'package:sample/data/local/utils/file_helper.dart';
import 'package:sample/data/local/utils/local_storage_helper.dart';
import 'package:sample/data/local/utils/sqlflite_helper.dart';

class TodoRepository {
  final FileHelper fileHelper;
  final SqfliteHelper sqfliteHelper;
  final LocalStorageHelper localStorageHelper;

  TodoRepository({
    required this.fileHelper,
    required this.sqfliteHelper,
    required this.localStorageHelper,
  });

  ///------------------------- Todos Operations for Local Storage (NoSql DB) -------------------------///
  Future<List<TodoItem>?> getTodosLocalStorage() async {
    try {
      return localStorageHelper.getAll();
    } catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }

  void addTodoLocalStorage(String todoTask) {
    try {
      localStorageHelper.insert(TodoItem(todoTask: todoTask));
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  ///------------------------- Todos Operations for Sqlite Database (Sql DB) -------------------------///
  Future<List<TodoItem>?> getTodosSqlite() async {
    try {
      return sqfliteHelper.getAll();
    } catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }

  Future<void> addTodoSqlite(String todoTask) async {
    try {
      sqfliteHelper.insert(TodoItem(todoTask: todoTask));
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  ///------------------------- Todos Operations for Local File -------------------------///
  Future<List<TodoItem>?> getTodosFile() async {
    try {
      return fileHelper.getAll();
    } catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }

  void addTodoFile(String todoTask) {
    try {
      fileHelper.insert(TodoItem(todoTask: todoTask));
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }
}
