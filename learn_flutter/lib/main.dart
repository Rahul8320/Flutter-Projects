import 'package:flutter/material.dart';
import 'package:learn_flutter/pages/counter_page.dart';
import 'package:learn_flutter/pages/tapme_page.dart';
import 'package:learn_flutter/pages/todo_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: TapMePage(),
      home: const CounterPage(title: "Counter Page"),
      routes: {
        "/todo_list_page": (context) => const TodoListPage(),
        "/tapme_page": (context) => const TapMePage(),
      },
    );
  }
}
