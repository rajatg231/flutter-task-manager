import 'package:flutter/material.dart';

import 'package:taskmanager/models/task.dart';
import 'package:taskmanager/models/tasks_data.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final TasksData tasksData;

  const TaskTile({Key? key, required this.task, required this.tasksData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          activeColor: Colors.green,
          value: task.done,
          onChanged: (checkbox) {
            tasksData.updateTask(task);
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration:
                task.done ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController _titleController =
                        TextEditingController(text: task.title);
                    return AlertDialog(
                      title: Text('Edit Task'),
                      content: TextField(
                        controller: _titleController,
                        decoration: InputDecoration(hintText: "New Task Title"),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            String newTitle = _titleController.text;
                            tasksData.updateTaskTitle(task, newTitle);
                            Navigator.of(context).pop();
                          },
                          child: Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                tasksData.deleteTask(task);
              },
            ),
          ],
        ),
      ),
    );
  }
}
