List<TodoItem> todoListFromMap(Map<String, dynamic>? map) {
  if (map == null) return [];

  List<TodoItem> todoList = List.empty(growable: true);
  map.forEach((key, value) {
    if (value is Map<String, dynamic>) {
      todoList.add(TodoItem.fromMap(value));
    }
  });
  return todoList;
}

class TodoItem {
  String todoTask;

  TodoItem({
    required this.todoTask,
  });

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(todoTask: map['todoTask'] as String);
  }
}
