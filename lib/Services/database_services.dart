import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:taskmanager/models/task.dart';
import 'package:taskmanager/Services/globals.dart';

class DatabaseServices {
  //add task user wise
  static Future<Task> addTask(String title) async {
    var user = Globals
        .getUserID(); //user has been set globally after selecting for drop down value
    Map data = {"taskName": title, "username": user};
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'username/$user/tasks');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    Map responseMap = jsonDecode(response.body);
    Task task = Task.fromMap(responseMap);
    return task;
  }

//get task user wise
  static Future<List<Task>> getTasks() async {
    var user = Globals.getUserID();
    var url = Uri.parse(baseURL + 'username/$user/tasks');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    List responseList = jsonDecode(response.body);
    List<Task> tasks = [];
    for (Map taskMap in responseList) {
      Task task = Task.fromMap(taskMap);
      tasks.add(task);
    }
    return tasks;
  }

//toggle task status user wise
  static Future<http.Response> updateTask(int id) async {
    var user = Globals.getUserID();
    var url = Uri.parse(baseURL + 'username/$user/tasks/$id');
    http.Response response = await http.put(
      url,
      headers: headers,
    );
    return response;
  }

//update task title user wise
  static Future<Task> updateTaskTitle(int id, String newTitle) async {
    Map data = {
      "taskName": newTitle,
    };
    var body = json.encode(data);
    var user = Globals.getUserID();
    var url = Uri.parse(baseURL + 'username/$user/tasks/$id');

    http.Response response = await http.put(
      url,
      headers: headers,
      body: body,
    );
    Map responseMap = jsonDecode(response.body);
    Task updatedTask = Task.fromMap(responseMap);

    return updatedTask;
  }

//delete task using task id
  static Future<http.Response> deleteTask(int id) async {
    var url = Uri.parse(baseURL + 'tasks/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    return response;
  }
}
