import 'package:flutter/foundation.dart';
import 'package:localstore/localstore.dart';
import 'package:sample/data/local/model/todo_item.dart';

class TodoRepository {
  ///------------------------- Todos Operations for Local Storage (NoSql DB) -------------------------///
  Future<List<TodoItem>?> getTodosLocalStorage() async {
    try {
      //todo: fetch todo list from local storage (no sql db)
      final db = Localstore.instance;
      return todoListFromMap((await db.collection('todos').get())!);
    } catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }

  void addTodoLocalStorage(String todoTask) {
    try {
      final db = Localstore.instance;
      db.collection('todos').doc().set({'todoTask': todoTask});
    } catch (ex) {
      debugPrint("Something went wrong");
    }
  }

  ///------------------------- Todos Operations for Sqlite Database (Sql DB) -------------------------///
  Future<List<TodoItem>?> getTodosSqlite() async {
    try {
      //todo: fetch todo list from sqlite database (sql db)
    } catch (ex) {
      debugPrint("Something went wrong");
    }
    return null;
  }

  void addTodoSqlite(String todoTask) {
    try {
      //todo: add todo to sqlite database (sql db)
      debugPrint(todoTask);
    } catch (ex) {
      debugPrint("Something went wrong");
    }
  }

  ///------------------------- Todos Operations for Local File -------------------------///
  Future<List<TodoItem>?> getTodosFile() async {
    try {
      //todo: fetch todo list from local file
    } catch (ex) {
      debugPrint("Something went wrong");
    }
    return null;
  }

  void addTodoFile(String todoTask) {
    try {
      //todo: add todo to local file
      debugPrint(todoTask);
    } catch (ex) {
      debugPrint("Something went wrong");
    }
  }
}
