import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/components/dialog_box.dart';
import 'package:todo_app/components/todo_tile.dart';
import 'package:todo_app/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _todoBox = Hive.box("todo");
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if this is the first time ever opening the app, then create the default data
    if (_todoBox.get("TODOLIST") == null) {
      print("Creating init data...");
      db.createInitialData();
    } else {
      // load the existing data
      db.loadData();
    }

    super.initState();
  }

  // text editing controller
  final TextEditingController _controller = TextEditingController();

  // check box was changed
  void onChangedCheckBox(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });

    // update the database
    db.updateDatabase();
  }

  // save new task
  void saveNewTask() {
    // check for controller text
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        // update the state of todo list
        db.toDoList.add([_controller.text.trim(), false]);
        // clear the controller text
        _controller.clear();
      });
    }
    // close the dialog
    Navigator.of(context).pop();

    // update the database
    db.updateDatabase();
  }

  // create todo dialog box
  void onCreateNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // delete a task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });

    // update the database
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent[400],
        title: const Text("TO DO"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateNewTask,
        child: const Icon(Icons.add_task),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => onChangedCheckBox(value, index),
            onDeleteTask: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
