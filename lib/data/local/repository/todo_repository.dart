import 'package:flutter/foundation.dart';
import 'package:sample/data/local/model/todo_item.dart';
import 'package:sample/data/local/utils/file_helper.dart';
import 'package:sample/data/local/utils/local_storage_helper.dart';
import 'package:sample/data/local/utils/sqlflite_helper.dart';

class TodoRepository {
  ///------------------------- Todos Operations for Local Storage (NoSql DB) -------------------------///
  Future<List<TodoItem>?> getTodosLocalStorage() async {
    try {
      LocalStorageHelper todoDatabase = LocalStorageHelper.instance;
      return todoDatabase.getAll();
    } catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }

  void addTodoLocalStorage(String todoTask) {
    try {
      LocalStorageHelper todoDatabase = LocalStorageHelper.instance;
      todoDatabase.insert(TodoItem(todoTask: todoTask));
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  ///------------------------- Todos Operations for Sqlite Database (Sql DB) -------------------------///
  Future<List<TodoItem>?> getTodosSqlite() async {
    try {
      SqfliteHelper todoDatabase = SqfliteHelper.instance;
      return todoDatabase.getAll();
    } catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }

  Future<void> addTodoSqlite(String todoTask) async {
    try {
      SqfliteHelper todoDatabase = SqfliteHelper.instance;
      todoDatabase.insert(TodoItem(todoTask: todoTask));
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  ///------------------------- Todos Operations for Local File -------------------------///
  Future<List<TodoItem>?> getTodosFile() async {
    try {
      FileHelper todoFile = FileHelper.instance;
      return todoFile.getAll();
    } catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }

  void addTodoFile(String todoTask) {
    try {
      FileHelper todoFile = FileHelper.instance;
      todoFile.insert(TodoItem(todoTask: todoTask));
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }
}
