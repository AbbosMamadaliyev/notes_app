import 'package:hive/hive.dart';

import '../entities/todo_model.dart';

class LocalDataProvider {
  final String _boxName = 'todo_box';

  Box<TodoModel> box() => Hive.box<TodoModel>(_boxName);

  Future<Box<TodoModel>> openBox() async =>
      await Hive.openBox<TodoModel>(_boxName);
}
