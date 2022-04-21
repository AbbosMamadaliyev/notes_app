import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../domain/dataproviders/local_dataprovider.dart';
import '../../../domain/entities/todo_model.dart';

class AddTodoPageModel extends ChangeNotifier {
  final _localData = LocalDataProvider();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  void showAddTodo(BuildContext context) {
    final todoBox = _localData.box();

    var title = titleController.text;
    var content = contentController.text;
    var dateTime = DateTime.now();

    TodoModel todo = TodoModel(
        title: title, content: content, dateTime: dateTime.toString());

    todoBox.add(todo);

    Fluttertoast.showToast(
        msg: "Added your todo",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

    titleController.clear();
    contentController.clear();

    Navigator.of(context).pop();
  }
}
