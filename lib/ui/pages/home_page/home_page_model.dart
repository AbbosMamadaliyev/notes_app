import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/domain/dataproviders/local_dataprovider.dart';

import '../../../domain/entities/todo_model.dart';

class HomePageModel extends ChangeNotifier {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final _localData = LocalDataProvider();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<TodoModel> _todoList = [];

  List<TodoModel> get todoList => _todoList;

  HomePageModel() {
    _loadData();
  }

  void _loadData() {
    final todoBox = _localData.box();

    _readDataAndListen(todoBox);
    todoBox.listenable().addListener(() {
      _readDataAndListen(todoBox);
    });
  }

  _readDataAndListen(Box<TodoModel> todoBox) {
    _todoList = todoBox.values.toList();
    notifyListeners();
  }

  void editItem(BuildContext context, int index) {
    var newTitle = titleController.text;
    var newContent = contentController.text;
    var dateTime = DateTime.now();

    final todoBox = _localData.box();

    TodoModel todo = TodoModel(
        title: newTitle, content: newContent, dateTime: dateTime.toString());

    //edit
    todoBox.putAt(index, todo);
    notifyListeners();

    Navigator.of(context).pop();
  }

  void deleteItem(int index) {
    final todoBox = _localData.box();

    todoBox.deleteAt(index);
    _sendNotification('Deleted', 'Your todo ${_todoList[index].title} deleted');
  }

  String dateFormat(String dateTime) {
    final dateF = DateFormat('dd-MMMM').format(DateTime.parse(dateTime));
    final timeF = DateFormat('hh:mm').format(DateTime.parse(dateTime));
    return '$dateF, $timeF';
  }

  void _sendNotification(String? title, String? body) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        "high channel", "High Importance Notification",
        description: "hello", importance: Importance.max);

    _flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description),
        ));
  }
}
