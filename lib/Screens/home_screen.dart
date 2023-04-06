import 'package:flutter/material.dart';
// imports the material design widgets and styles which provide a set of ready-made UI components, such as buttons, text inputs
import 'package:provider/provider.dart';
// imports the provider library, which is used for managing state
import 'package:taskmanager/Services/database_services.dart';
import 'package:taskmanager/models/task.dart';
import 'package:taskmanager/models/tasks_data.dart';
import 'package:taskmanager/Services/globals.dart' as gl;
import 'package:taskmanager/task_tile.dart';
import 'package:taskmanager/Screens/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task>? tasks; //define tasks
  String dropdownValue = 'user1'; //setting default value of dropdown to user1

  getTasks() async {
    tasks = await DatabaseServices.getTasks(); //get task from database service
    Provider.of<TasksData>(context, listen: false).tasks = tasks!;
    setState(() {}); //trigger UI update
  }

  void filterTasks(String? option) {
    if (option != null) {
      dropdownValue = option; //set the selected drop down value
      gl.Globals.setUserID(
          option); // set the value of global userID to selected value from dropdown
    }
    getTasks(); //get task for selected user, user has been selected globally
  }

  @override
  void initState() {
    super.initState();
    gl.Globals.setUserID(
        dropdownValue); // set the value of userID to "user1" after initialization
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return tasks == null
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Task Manager (${Provider.of<TasksData>(context).tasks.length})',
              ),
              centerTitle: true,
              backgroundColor: Colors.green,
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      filterTasks(
                          newValue); //after selecting the value call filter method
                    },
                    items: <String>['user1', 'user2']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Consumer<TasksData>(
                      builder: (context, tasksData, child) {
                        return ListView.builder(
                            itemCount: tasksData.tasks.length,
                            itemBuilder: (context, index) {
                              Task task = tasksData.tasks[index];
                              return TaskTile(
                                task: task,
                                tasksData: tasksData,
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              child: const Icon(
                Icons.add,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const AddTaskScreen();
                    });
              },
            ),
          );
  }
}
