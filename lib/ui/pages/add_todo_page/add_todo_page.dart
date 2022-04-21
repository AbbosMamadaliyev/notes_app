import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_todo_page_model.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddTodoPageModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: model.titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'title',
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: model.contentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'content',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => model.showAddTodo(context),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
