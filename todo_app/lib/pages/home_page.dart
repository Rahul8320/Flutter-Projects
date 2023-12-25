import 'package:flutter/material.dart';
import 'package:todo_app/components/dialog_box.dart';
import 'package:todo_app/components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text editing controller
  final TextEditingController _controller = TextEditingController();

  // list of todo tasks.
  List toDoList = [
    ["Complete Flutter Tutorial", false],
    ["Make Todo App Using Flutter", false],
    ["Post This journey to LinkedIn", false],
    ["Push the code on Github", false],
    ["with screenshot of the todo app", false],
  ];

  // check box was changed
  void onChangedCheckBox(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  // save new task
  void saveNewTask() {
    // check for controller text
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        // update the state of todo list
        toDoList.add([_controller.text.trim(), false]);
        // clear the controller text
        _controller.clear();
      });
    }
    // close the dialog
    Navigator.of(context).pop();
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
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => onChangedCheckBox(value, index),
          );
        },
      ),
    );
  }
}
