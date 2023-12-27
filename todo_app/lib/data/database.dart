import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  // reference to the hive box
  final _todoBox = Hive.box("todo");

  // run this method if this is the 1st time ever user opening this app
  void createInitialData() {
    toDoList = [
      ["Give review of this application.", false],
      ["Share it to my friends.", false],
    ];
  }

  // load the data from the database
  void loadData() {
    toDoList = _todoBox.get("TODOLIST");
  }

  // update the database
  void updateDatabase() {
    _todoBox.put("TODOLIST", toDoList);
  }
}
