import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/base/screens/base_widget.dart';
import 'package:sample/base/utils/widgets/custom_button_view.dart';
import 'package:sample/base/utils/widgets/custom_list_view.dart';
import 'package:sample/data/local/model/todo_item.dart';
import 'package:sample/ui/local_data/local_data_provider.dart';

class LocalData extends BaseWidget {
  const LocalData({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _LocalDataState();
}

class _LocalDataState extends BaseWidgetState<LocalData> {
  final todoTextController = TextEditingController();
  bool showOptions = false;

  void toggleOptions() {
    setState(() {
      showOptions = !showOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    final noSqlData = ref.watch(noSqlDataProvider);
    final sqlData = ref.watch(sqlDataProvider);
    final fileData = ref.watch(fileDataProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Local Data Storage"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("NoSql DB Data",
                    style: GoogleFonts.robotoSlab(
                        textStyle: const TextStyle(fontSize: 20))),
                Expanded(
                    flex: 1,
                    child: noSqlData.when(
                      data: (noSqlTodoData) {
                        // check if noSqlTodoData null return error view else return list of todos
                        return noSqlTodoData != null
                            ? (noSqlTodoData.isNotEmpty)
                                ? CustomListView<TodoItem>(
                                    separatorHeight: 1,
                                    data: noSqlTodoData,
                                    titleBuilder: (todoItem) =>
                                        Text(todoItem.todoTask),
                                    leadingIcon: const Icon(Icons.task),
                                    onTap: (todoItem) {},
                                  )
                                : getDataEmptyView()
                            : getErrorView();
                      },
                      error: (error, stack) => getErrorView(),
                      loading: () => getLoadingView(),
                    )),
                Text("Sql DB Data",
                    style: GoogleFonts.robotoSlab(
                        textStyle: const TextStyle(fontSize: 20))),
                Expanded(
                    flex: 1,
                    child: sqlData.when(
                      data: (sqlTodoData) {
                        // check if sqlTodoData null return error view else return list of todos
                        return sqlTodoData != null
                            ? (sqlTodoData.isNotEmpty)
                                ? CustomListView<TodoItem>(
                                    separatorHeight: 1,
                                    data: sqlTodoData,
                                    titleBuilder: (todoItem) =>
                                        Text(todoItem.todoTask),
                                    leadingIcon: const Icon(Icons.task),
                                    onTap: (todoItem) {},
                                  )
                                : getDataEmptyView()
                            : getErrorView();
                      },
                      error: (error, stack) => getErrorView(),
                      loading: () => getLoadingView(),
                    )),
                Text("Local File Data",
                    style: GoogleFonts.robotoSlab(
                        textStyle: const TextStyle(fontSize: 20))),
                Expanded(
                    flex: 1,
                    child: fileData.when(
                      data: (fileTodoData) {
                        // check if fileTodoData null return error view else return list of todos
                        return fileTodoData != null
                            ? (fileTodoData.isNotEmpty)
                                ? CustomListView<TodoItem>(
                                    separatorHeight: 1,
                                    data: fileTodoData,
                                    titleBuilder: (todoItem) =>
                                        Text(todoItem.todoTask),
                                    leadingIcon: const Icon(Icons.task),
                                    onTap: (todoItem) {},
                                  )
                                : getDataEmptyView()
                            : getErrorView();
                      },
                      error: (error, stack) => getErrorView(),
                      loading: () => getLoadingView(),
                    )),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: showOptions,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomButtonView("NoSQL DB", () {
                  toggleOptions();
                  showAddTaskDialog(context, addNoSqlDataProvider);
                }, radius: 10, elevation: 5, textColor: Colors.black),
                CustomButtonView("SQL DB", () {
                  toggleOptions();
                  showAddTaskDialog(context, addSqlDataProvider);
                }, radius: 10, elevation: 5, textColor: Colors.black),
                CustomButtonView("Local File", () {
                  toggleOptions();
                  showAddTaskDialog(context, addFileDataProvider);
                }, radius: 10, elevation: 5, textColor: Colors.black),
                const SizedBox(height: 15)
              ],
            ),
          ),
          FloatingActionButton(
            elevation: 10,
            backgroundColor: Colors.amber,
            onPressed: () => toggleOptions(),
            child: const Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void showAddTaskDialog(
      BuildContext context, AutoDisposeProviderFamily<void, String> provider) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Task Details"),
          content: TextField(controller: textController),
          actions: <Widget>[
            TextButton(
              child: const Text("Add Task"),
              onPressed: () {
                ref.read(provider(textController.text));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
