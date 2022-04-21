import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/ui/pages/add_todo_page/add_todo_page_model.dart';
import 'package:notes_app/ui/pages/home_page/home_page_model.dart';
import 'package:provider/provider.dart';

import 'app/my_app.dart';
import 'domain/dataproviders/local_dataprovider.dart';
import 'domain/entities/todo_model.dart';

void main() async {
  final localData = LocalDataProvider();
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  await localData.openBox();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => HomePageModel()),
        ChangeNotifierProvider(create: (create) => AddTodoPageModel()),
      ],
      child: const MyApp(),
    ),
  );
}
