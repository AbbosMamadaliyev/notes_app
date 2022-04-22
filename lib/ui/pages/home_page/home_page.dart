import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/ui/pages/home_page/home_page_model.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/todo_model.dart';
import '../add_todo_page/add_todo_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomePageModel>();
    final todoList = model.todoList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('my note'),
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            TodoModel data = todoList[index];
            final title = data.title.isEmpty ? 'title' : data.title;
            final dateTime = model.dateFormat(data.dateTime);

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          data.content,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(dateTime),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              showEditDialog(index);
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              showDeleteDataDialog(index);
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTodoPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showEditDialog(int index) {
    final model = context.read<HomePageModel>();
    final todoList = model.todoList;

    TodoModel todo = todoList[index];

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: model.titleController..text = todo.title,
                ),
                TextField(
                  controller: model.contentController..text = todo.content,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('no')),
              TextButton(
                  onPressed: () {
                    model.editItem(context, index);
                  },
                  child: const Text('yes')),
            ],
          );
        });
  }

  void showDeleteDataDialog(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete item?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('no')),
              TextButton(
                  onPressed: () {
                    context.read<HomePageModel>().deleteItem(index);

                    Fluttertoast.showToast(
                        msg: "Deleted",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);

                    Navigator.of(context).pop();
                  },
                  child: const Text('yes')),
            ],
          );
        });
  }
}
