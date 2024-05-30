import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sample/data/local/model/todo_item.dart';

class FileHelper {
  FileHelper._();

  static final FileHelper instance = FileHelper._();
  static File? _file;

  // File name
  static const String fileName = 'todos.txt';

  // Define a getter to access the file asynchronously.
  Future<File> get file async => _file ??= await _initFile();

  _initFile() async => File('${await _getFilePath}/$fileName');

  // Function that inserts notes into the database
  Future<void> insert(TodoItem todo) async =>
      (await file).writeAsString('${todo.todoTask}\n', mode: FileMode.append);

  // A method that retrieves all the notes from the Notes table.
  Future<List<TodoItem>?> getAll() async => (await (await file).readAsLines())
      .map((todos) => TodoItem.fromString(todos))
      .toList();

  Future<String> get _getFilePath async =>
      (await getApplicationDocumentsDirectory()).path;
}
