import 'package:flutter/cupertino.dart';
import 'package:taskmanager/Services/database_services.dart';
import 'package:taskmanager/models/task.dart';

class TasksData extends ChangeNotifier {
  List<Task> tasks = [];

// add a task user wise
  void addTask(String taskTitle) async {
    Task task = await DatabaseServices.addTask(taskTitle);
    tasks.add(task);
    notifyListeners();
  }

// Update the task title
  void updateTaskTitle(Task task, String newTitle) async {
    await DatabaseServices.updateTaskTitle(task.id, newTitle);
    int index = tasks.indexOf(task);
    if (index != -1) {
      tasks[index] = task.copyWith(title: newTitle);
      notifyListeners();
    }
  }

// toggle the task status
  void updateTask(Task task) {
    task.toggle();
    DatabaseServices.updateTask(task.id);
    notifyListeners();
  }

// delete a task
  void deleteTask(Task task) {
    tasks.remove(task);
    DatabaseServices.deleteTask(task.id);
    notifyListeners();
  }
}
