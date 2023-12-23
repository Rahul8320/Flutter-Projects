import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // Text editing controller to get an access to what thr user typed.
  TextEditingController myController = TextEditingController();

  List<String> todoList = [];

  void addTodo() {
    String input = myController.text;

    if (input.trim().isNotEmpty) {
      setState(() {
        todoList.add(input);
      });
    }

    myController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo List Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Text field
              TextField(
                controller: myController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Write your todo...",
                ),
              ),
              // add todo button
              ElevatedButton(
                onPressed: addTodo,
                child: const Text("Add todo"),
              ),

              // list all todo
              ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(index.toString()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
