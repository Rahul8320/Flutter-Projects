// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

/*
  // Constant -> create and initialize at same time and value never changed.
  const age = 27;
  const twiceAge = age * 2;

  // Variables
  var name = "Foo"; // Value can be changed.
  final college = "IIT" // Value never changed after initialized.
*/

// functions
// String getFullName(String firstName, String lastName) => '$firstName $lastName';

void main() {
  runApp(const MyApp());
}

void test() {
  // List
  final fruits = ["Mango", "Banana", "Apple", "Lichi"];
  print(fruits.length);

  // Set -> list of unique things.
  var names = {"foo", "bar", "baz"};
  names.add("foo");
  names.add("var");
  print(names);

  // Map -> Holds key value pairs.
  var person = {"name": "User one", "age": 35};
  print(person);
  person['name'] = "User Two";
  print(person);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    test();
    // print(getFullName('foo', 'bar'));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
