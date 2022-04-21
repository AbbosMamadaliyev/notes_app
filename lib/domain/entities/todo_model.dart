import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final String dateTime;

  const TodoModel({
    required this.title,
    required this.content,
    required this.dateTime,
  });
}
